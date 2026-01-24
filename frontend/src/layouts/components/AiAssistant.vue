<template>
  <div class="ai-assistant-container">
    <t-space>
      <t-sticky-tool
        class="ai-assistant-tool"
        :style="{ position: 'relative', overflow: 'hidden' }"
        :offset="[0, 0]"
        type="compact"
      >
        <t-sticky-item label="打开AI" @click="toggleVisible">
          <template #icon><chat-icon /></template>
        </t-sticky-item>
        <t-sticky-item label="二维码" :popup="renderPopup" :popup-props="{ overlayInnerStyle: { padding: '8px' } }">
          <template #icon><qrcode-icon /></template>
        </t-sticky-item>
        <t-sticky-item label="回到顶部" @click="handleScrollTop">
          <template #icon><arrow-up-icon /></template>
        </t-sticky-item>
      </t-sticky-tool>
    </t-space>

    <div v-show="visible" class="ai-chat-window">
      <div class="ai-header">
        <div class="title-block">
          <span class="title">AI 智能助手</span>
          <span class="subtitle">参考 ChatGPT 体验，结合系统安全策略</span>
        </div>
        <div class="header-actions">
          <t-select
            v-model="selectedProviderId"
            :options="providerOptions"
            size="small"
            placeholder="选择模型"
            style="width: 210px"
          />
          <t-button size="small" variant="outline" @click="reloadContext">刷新</t-button>
          <t-button variant="text" shape="circle" @click="toggleVisible">
            <template #icon><t-icon name="close" /></template>
          </t-button>
        </div>
      </div>

      <div v-if="tools.length" class="tool-panel">
        <span class="tool-title">可调用工具:</span>
        <t-space size="small">
          <t-tag v-for="tool in tools" :key="tool.name" variant="light-outline" shape="round">
            {{ tool.name }}
          </t-tag>
        </t-space>
      </div>

      <div class="t-chat-container">
        <t-chat class="t-chat-demo" :style="{ height: '100%' }" :messages="messages" @submit="onSend" />
      </div>
    </div>
  </div>
</template>
<script setup lang="tsx">
import { ArrowUpIcon, ChatIcon, QrcodeIcon } from 'tdesign-icons-vue-next';
import { MessagePlugin } from 'tdesign-vue-next';
import { onMounted, ref } from 'vue';

import type { AiProvider } from '@/api/system/ai';
import { fetchAiProviders } from '@/api/system/ai';
import { prefix } from '@/config/global';
import { useSettingStore } from '@/store';
import { request } from '@/utils/request';

const settingStore = useSettingStore();
const visible = ref(false);

interface ChatMessage {
  role: 'user' | 'assistant' | 'system';
  content: string;
  name?: string;
  avatar?: string;
  loading?: boolean;
}

const messages = ref<ChatMessage[]>([
  { role: 'assistant', content: '您好！我是您的智能助手，可以帮您查询数据或执行授权操作。', name: 'AI Assistant' },
]);

const providerOptions = ref<Array<{ label: string; value: number }>>([]);
const selectedProviderId = ref<number>();
const providers = ref<AiProvider[]>([]);
const tools = ref<Array<{ name: string; description: string }>>([]);

const toggleVisible = () => {
  visible.value = !visible.value;
};

const loadProviders = async () => {
  try {
    providers.value = await fetchAiProviders();
    providerOptions.value = providers.value.map((p) => ({ label: `${p.name} (${p.model || '-'})`, value: p.id }));
    const def = providers.value.find((p) => p.isDefaultProvider) || providers.value[0];
    selectedProviderId.value = def?.id;
  } catch (err: any) {
    MessagePlugin.error(String(err?.message || '加载模型失败'));
  }
};

const loadTools = async () => {
  try {
    const res = await request.get<Array<{ name: string; description: string }>>({ url: '/ai/tools' });
    tools.value = res || [];
  } catch {
    tools.value = [];
  }
};

const reloadContext = async () => {
  await Promise.all([loadProviders(), loadTools()]);
  MessagePlugin.success('模型与工具已更新');
};

// 发送消息处理
const onSend = async (context: { text: string }) => {
  const content = context.text;
  if (!content.trim()) return;
  if (!selectedProviderId.value) {
    MessagePlugin.warning('请先选择模型或配置 AI 接入');
    return;
  }

  messages.value.push({ role: 'user', content, name: '我' });
  const aiMsgIndex = messages.value.length;
  messages.value.push({
    role: 'assistant',
    content: '正在思考...',
    name: 'AI Assistant',
    loading: true,
  });

  try {
    await fetchStream(content, (data) => {
      const currentMsg = messages.value[aiMsgIndex];
      if (!currentMsg) return;
      currentMsg.loading = false;

      if (data.type === 'error') {
        currentMsg.content = `⚠️ ${data.content}`;
        return;
      }

      if (data.type === 'text' || data.type === 'meta') {
        currentMsg.content = (currentMsg.content || '') + data.content;
      }
    });
  } catch (e: any) {
    messages.value[aiMsgIndex].content = String(e?.message || '无法连接到 AI 服务');
    messages.value[aiMsgIndex].loading = false;
  }
};

// SSE 流式读取辅助函数
const fetchStream = async (msg: string, onChunk: (data: any) => void) => {
  const prefix = import.meta.env.VITE_API_URL_PREFIX || '/api';
  const response = await fetch(`${prefix}/ai/chat/sse`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: localStorage.getItem('t-design-starter-token') || '',
    },
    body: JSON.stringify({ message: msg, providerId: selectedProviderId.value }),
  });

  if (!response.ok) {
    throw new Error(response.statusText);
  }

  if (!response.body) return;

  const reader = response.body.getReader();
  const decoder = new TextDecoder();
  let buffer = '';

  while (true) {
    const { done, value } = await reader.read();
    if (done) break;

    buffer += decoder.decode(value, { stream: true });
    const lines = buffer.split('\n');
    buffer = lines.pop() || '';

    for (const line of lines) {
      if (line.startsWith('data:')) {
        const dataStr = line.slice(5).trim();
        if (!dataStr) continue;
        try {
          const data = JSON.parse(dataStr);
          onChunk(data);
        } catch (e) {
          console.error('JSON Parse Error', e);
        }
      }
    }
  }
};

const renderPopup = () => (
  <div class="ai-qr-popup" style={{ width: '140px', padding: '4px' }}>
    {settingStore.qrCodeUrl ? (
      <img
        class="ai-qr-popup__image"
        src={settingStore.qrCodeUrl}
        alt="二维码"
        style={{ width: '128px', height: '128px', objectFit: 'contain', display: 'block', margin: '0 auto' }}
      />
    ) : (
      <div class="ai-qr-popup__placeholder">
        <div class="ai-qr-popup__title">未配置二维码</div>
        <div class="ai-qr-popup__desc">请在系统设置 / 个性化设置 / 图片设置中配置</div>
      </div>
    )}
  </div>
);

const isScrollable = (el: HTMLElement) => {
  const style = window.getComputedStyle(el);
  const overflowY = style.overflowY;
  const canScroll = overflowY === 'auto' || overflowY === 'scroll' || overflowY === 'overlay';
  return canScroll && el.scrollHeight > el.clientHeight + 1;
};

const findScrollableAncestor = (el: HTMLElement | null) => {
  let current = el;
  while (current) {
    if (isScrollable(current)) return current;
    current = current.parentElement;
  }
  const scrolling = document.scrollingElement as HTMLElement | null;
  if (scrolling && scrolling.scrollHeight > scrolling.clientHeight + 1) {
    return scrolling;
  }
  return null;
};

const resolveScrollContainers = () => {
  const contentLayout = document.querySelector(`.${prefix}-content-layout`) as HTMLElement | null;
  const layoutEl = document.querySelector(`.${prefix}-layout`) as HTMLElement | null;
  const layoutContent = document.querySelector('.t-layout__content') as HTMLElement | null;
  const scrollParent = findScrollableAncestor(contentLayout || layoutContent);
  const tableScrollAreas = Array.from(
    document.querySelectorAll<HTMLElement>(
      '.t-table__content, .t-table__body, .t-table__body-inner, .t-scrollbar__wrap',
    ),
  );

  const candidates = [
    scrollParent,
    layoutEl,
    contentLayout,
    layoutContent,
    document.scrollingElement as HTMLElement | null,
    document.documentElement,
    document.body,
    ...tableScrollAreas,
  ].filter(Boolean) as HTMLElement[];

  const seen = new Set<HTMLElement>();
  const result: HTMLElement[] = [];
  for (const el of candidates) {
    if (!seen.has(el)) {
      seen.add(el);
      result.push(el);
    }
  }
  return result;
};

const scrollToTop = (el: HTMLElement) => {
  if (typeof el.scrollTo === 'function') {
    el.scrollTo({ top: 0, behavior: 'smooth' });
  } else {
    el.scrollTop = 0;
  }
};

const handleScrollTop = () => {
  const containers = resolveScrollContainers();
  let handled = false;
  containers.forEach((el) => {
    if (el.scrollTop > 0 || el.scrollHeight > el.clientHeight + 1 || isScrollable(el)) {
      scrollToTop(el);
      handled = true;
    }
  });
  if (!handled) {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
};

onMounted(() => {
  reloadContext();
});
</script>
<style lang="less" scoped>
.ai-assistant-container {
  position: fixed;
  bottom: max(24px, env(safe-area-inset-bottom));
  right: max(24px, env(safe-area-inset-right));
  z-index: 2000;
  max-width: calc(100vw - 16px);
}

.ai-assistant-tool {
  :deep(.t-sticky-tool__item) {
    width: 52px;
    height: 52px;
    border-radius: 14px 0 0 14px;
    background: var(--td-bg-color-container);
    box-shadow: 0 6px 16px rgb(0 0 0 / 12%);
    border: 1px solid var(--td-component-stroke);
    margin: 8px 0;
    transition: all 0.2s ease;

    &:hover {
      transform: translateX(-2px);
      color: var(--td-brand-color);
      border-color: var(--td-brand-color);
    }
  }

  :deep(.t-sticky-tool__item__icon) {
    font-size: 20px;
  }

  :deep(.t-sticky-tool__item__label) {
    font-size: 12px;
  }
}

.ai-chat-window {
  width: 420px;
  height: 640px;
  background: var(--td-bg-color-container);
  border-radius: 12px;
  box-shadow: 0 8px 24px rgb(0 0 0 / 12%);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: 1px solid var(--td-component-stroke);
}

.ai-header {
  padding: 12px 16px;
  background: linear-gradient(135deg, var(--td-brand-color), #0052d9);
  color: #fff;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  font-weight: 600;
  flex-shrink: 0;

  .title-block {
    display: flex;
    flex-direction: column;
    gap: 4px;

    .subtitle {
      font-size: 12px;
      opacity: 0.9;
      font-weight: 400;
    }
  }

  .header-actions {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .t-button {
    color: #fff;

    &:hover {
      background: rgb(255 255 255 / 10%);
    }
  }
}

.tool-panel {
  padding: 8px 16px;
  border-bottom: 1px solid var(--td-component-stroke);
  background: var(--td-bg-color-secondarycontainer);
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;

  .tool-title {
    color: var(--td-text-color-secondary);
  }
}

.t-chat-container {
  flex: 1;
  overflow: hidden;
  background: var(--td-bg-color-secondarycontainer);
}

.ai-qr-popup {
  text-align: center;
  min-width: 140px;
}

.ai-qr-popup__image {
  width: 128px;
  height: 128px;
  object-fit: contain;
  display: block;
  margin: 0 auto;
}

.ai-qr-popup__placeholder {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 6px 4px;
  color: var(--td-text-color-secondary);
}

.ai-qr-popup__title {
  font-weight: 600;
  color: var(--td-text-color-primary);
}

.ai-qr-popup__desc {
  font-size: 12px;
  line-height: 1.4;
}
</style>
