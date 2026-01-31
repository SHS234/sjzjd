<template>
  <div class="order-detail-page">
    <!-- 1. Top HUD -->
    <t-card :bordered="false" class="hud-card mb-4">
      <t-row :gutter="16" align="middle">
        <!-- Progress Steps -->
        <t-col :span="6">
          <t-steps :current="currentStep" theme="dot">
            <t-step-item title="待接单" />
            <t-step-item title="进行中" />
            <t-step-item title="已结算" />
          </t-steps>
        </t-col>

        <!-- Countdown -->
        <t-col :span="3" class="countdown-wrapper">
          <div class="countdown-container">
            <div class="label">
              剩余时间
              <t-button
                variant="text"
                size="small"
                shape="square"
                style="margin-left: 4px"
                @click="manualTimeVisible = true"
              >
                <template #icon><edit-icon /></template>
              </t-button>
            </div>
            <div class="timer" :class="{ 'text-danger': isOverdue }">
              {{ remainingTime }}
            </div>
            <t-tag v-if="isOverdue" theme="danger" variant="light" size="small">已超时</t-tag>

            <div class="countdown-controls" style="margin-top: 8px; display: flex; justify-content: center; gap: 8px">
              <t-button
                theme="default"
                variant="outline"
                size="small"
                :disabled="!order.deadlineTime && !order.isPaused"
                @click="handleTogglePause"
              >
                <template #icon>
                  <play-circle-icon v-if="order.isPaused" />
                  <pause-circle-icon v-else />
                </template>
                {{ order.isPaused ? '继续' : '暂停' }}
              </t-button>

              <t-button
                theme="danger"
                variant="outline"
                size="small"
                :disabled="!order.deadlineTime && !order.isPaused"
                @click="handleClearTime"
              >
                <template #icon><stop-circle-icon /></template>
                清零
              </t-button>
            </div>
          </div>
        </t-col>

        <!-- Executor Info -->
        <t-col :span="3">
          <div class="executor-info" style="flex-direction: row; align-items: center; gap: 32px">
            <t-button size="small" theme="warning" style="margin-left: -32px" @click="handleChangeBooster">
              更换打手
            </t-button>
            <div class="info">
              <template v-if="boosterHistory.length > 0">
                <div v-for="(b, index) in boosterHistory" :key="index" class="name">
                  {{ index === 0 ? '打手：' : '新打手：' }}{{ b.name }}
                  <span v-if="b.nickname">({{ b.nickname }})</span>
                </div>
              </template>
              <template v-else>
                <div class="name">
                  打手：{{ booster.name }}
                  <span v-if="booster.nickname">({{ booster.nickname }})</span>
                </div>
              </template>
            </div>
          </div>
        </t-col>
      </t-row>
    </t-card>

    <!-- 2. Info Row -->
    <t-row :gutter="16" class="info-row mb-4 stretch-row">
      <!-- Order Info -->
      <t-col :span="4">
        <t-card title="订单信息" :bordered="false" class="full-height-card">
          <template #header>
            <div style="display: flex; justify-content: center; width: 100%">
              <t-space align="center">
                <span class="font-bold">订单信息</span>
              </t-space>
            </div>
          </template>
          <t-descriptions :column="1" layout="vertical">
            <t-descriptions-item label="内部单号">{{ order.orderNo }}</t-descriptions-item>
            <t-descriptions-item label="闲鱼订单编号">
              <t-button v-if="order.xianyuOrderNo" size="small" variant="text" @click="copyText(order.xianyuOrderNo)"
                >[复制]</t-button
              >
              {{ order.xianyuOrderNo || '-' }}
            </t-descriptions-item>
            <t-descriptions-item label="订单金额">
              <span class="text-price">¥{{ order.amount }}</span>
            </t-descriptions-item>
          </t-descriptions>
          <t-divider dashed style="margin: 12px 0" />
          <t-descriptions :column="1" layout="vertical">
            <t-descriptions-item label="微信号">{{ order.customerWechat || '-' }}</t-descriptions-item>
          </t-descriptions>
        </t-card>
      </t-col>

      <!-- Account Info -->
      <t-col :span="4">
        <t-card title="账号信息" :bordered="false" class="full-height-card">
          <template #header>
            <div style="display: flex; justify-content: center; width: 100%">
              <t-space align="center">
                <span class="font-bold">账号信息</span>
              </t-space>
            </div>
          </template>
          <template #actions>
            <t-tag theme="primary" variant="light">{{ order.region }}</t-tag>
          </template>
          <t-list :split="true">
            <t-list-item>
              <t-space direction="vertical" size="small">
                <div class="label">游戏UID</div>
                <div class="value">{{ order.gameUid || '-' }}</div>
              </t-space>
            </t-list-item>
          </t-list>
        </t-card>
      </t-col>

      <!-- Game Goals -->
      <t-col :span="4">
        <t-card title="代练目标" :bordered="false" class="full-height-card">
          <template #header>
            <div style="display: flex; justify-content: center; width: 100%">
              <t-space align="center">
                <span class="font-bold">代练目标</span>
              </t-space>
            </div>
          </template>
          <t-descriptions :column="1" layout="vertical">
            <t-descriptions-item label="游戏需求">{{ order.gameName }}</t-descriptions-item>
            <t-descriptions-item label="当前哈弗币">{{
              order.gameRank ? `${order.gameRank}w` : '-'
            }}</t-descriptions-item>
            <t-descriptions-item label="目标资产">
              <span class="text-primary font-bold">{{ order.targetAssets ? `${order.targetAssets}w` : '-' }}</span>
            </t-descriptions-item>
          </t-descriptions>
        </t-card>
      </t-col>
    </t-row>

    <!-- 3. Bottom Actions (Sticky) -->
    <t-card class="action-bar mb-4" :bordered="false">
      <t-row justify="space-between" align="middle">
        <t-col>
          <t-space align="center">
            <div>
              <span class="text-secondary">当前操作视角: </span>
              <t-radio-group v-model="currentView" variant="default-filled">
                <t-radio-button value="booster">打手</t-radio-button>
                <t-radio-button value="admin">管理员</t-radio-button>
              </t-radio-group>
            </div>

            <div
              v-if="currentView === 'booster' || uploadFiles.length > 0"
              class="upload-wrapper"
              style="margin-left: 32px"
            >
              <span class="text-secondary mr-2" style="white-space: nowrap">{{
                currentView === 'booster' && !['COMPLETED', 'CLOSED', 'LOCKED'].includes(order.status)
                  ? '上传截图:'
                  : '截图证据:'
              }}</span>
              <div class="upload-panel">
                <t-upload
                  v-model="uploadFiles"
                  class="upload-grid-5"
                  action="/api/system/file/upload"
                  :headers="uploadHeaders"
                  theme="image"
                  accept="image/*"
                  multiple
                  :max="maxUploadCount"
                  :disabled="currentView !== 'booster' || ['COMPLETED', 'CLOSED', 'LOCKED'].includes(order.status)"
                  :before-upload="handleBeforeUpload"
                  :before-all-files-upload="handleBeforeAllFilesUpload"
                  :locale="{ triggerUploadText: { image: '点击上传' } }"
                  :format-response="formatResponse"
                  @change="handleUploadChange"
                  @success="handleUploadSuccess"
                  @fail="handleUploadFail"
                  @remove="handleRemove"
                />
                <div
                  v-if="currentView === 'booster' && !['COMPLETED', 'CLOSED', 'LOCKED'].includes(order.status)"
                  class="t-upload__tips"
                >
                  请上传相关截图证据，最多6张
                </div>
                <t-button
                  v-if="currentView === 'booster' && !['COMPLETED', 'CLOSED', 'LOCKED'].includes(order.status)"
                  theme="primary"
                  size="small"
                  :loading="saveScreenshotsLoading"
                  style="margin-top: 8px; width: fit-content"
                  @click="handleSaveScreenshots"
                >
                  保存截图
                </t-button>
              </div>
            </div>
          </t-space>
        </t-col>
        <t-col>
          <t-space v-if="currentView === 'booster'" align="center" class="booster-actions" style="margin-left: -8px">
            <!-- 结单按钮 -->
          <template v-if="['PENDING', 'PROCESSING', 'LOCKED'].includes(order.status)">
            <t-popconfirm
              v-if="order.boosterId"
              content="确认结单吗？这将生成结算记录。"
              @confirm="handleComplete"
            >
              <t-button theme="success" size="medium">结单</t-button>
            </t-popconfirm>
            <t-button v-else theme="success" size="medium" @click="handleComplete">
              结单
            </t-button>
          </template>

            <!-- 售后按钮 -->
            <t-button
              v-if="!['LOCKED', 'CLOSED'].includes(order.status)"
              theme="danger"
              size="medium"
              @click="$router.push(`/after-sales/apply?orderId=${order.id}`)"
            >
              申请售后
            </t-button>
            <t-button
              v-else
              theme="warning"
              variant="outline"
              @click="$router.push(`/after-sales/detail?orderId=${order.id}`)"
            >
              查看售后
            </t-button>
          </t-space>
          <t-space v-else>
            <!-- 管理员强制结单按钮 -->
          <t-popconfirm
            v-if="['PENDING', 'PROCESSING', 'LOCKED'].includes(order.status)"
            content="确认强制结单吗？这将生成结算记录。"
            @confirm="handleComplete"
          >
            <t-button theme="success" variant="outline">强制结单</t-button>
          </t-popconfirm>

            <t-button
              v-if="order.status === 'LOCKED'"
              theme="warning"
              @click="$router.push(`/after-sales/detail?orderId=${order.id}`)"
            >
              处理售后
            </t-button>
            <t-button theme="warning" :loading="changeBoosterLoading" @click="handleChangeBooster"> 更换打手 </t-button>
          </t-space>
        </t-col>
      </t-row>
    </t-card>

    <!-- Special Requirements -->
    <t-card title="备注" :bordered="false" class="highlight-card">
      <div v-if="order.description" class="special-req-block" style="padding: 0; margin-bottom: 8px">
        <div class="content">{{ order.description }}</div>
      </div>
      <ul class="requirement-list">
        <li v-for="(req, index) in order.requirements" :key="index">{{ req }}</li>
      </ul>
    </t-card>

    <!-- Change Booster Dialog -->
    <t-dialog
      v-model:visible="changeBoosterVisible"
      title="更换打手"
      width="400px"
      attach="body"
      :destroy-on-close="true"
      @confirm="handleChangeBoosterSubmit"
    >
      <t-space direction="vertical" style="width: 100%">
        <p>当前订单: {{ order.orderNo }}</p>
        <t-select
          v-model="changeBoosterId"
          :options="boosterOptions"
          placeholder="请选择打手 (已录入并空闲)"
          filterable
          clearable
        />
      </t-space>
    </t-dialog>

    <!-- Manual Time Dialog -->
    <t-dialog
      v-model:visible="manualTimeVisible"
      title="设置倒计时"
      width="400px"
      attach="body"
      @confirm="handleManualTimeSubmit"
    >
      <t-space direction="vertical" style="width: 100%">
        <p>请输入剩余小时数 (0-1000):</p>
        <t-input-number v-model="manualTimeHours" :min="0" :max="1000" suffix="小时" style="width: 100%" />
      </t-space>
    </t-dialog>
  </div>
</template>
<script lang="ts">
import dayjs from 'dayjs';
import { EditIcon, PauseCircleIcon, PlayCircleIcon, StopCircleIcon } from 'tdesign-icons-vue-next';
import { DialogPlugin, MessagePlugin } from 'tdesign-vue-next';
import { computed, defineComponent, onMounted, onUnmounted, reactive, ref } from 'vue';
import { useRoute } from 'vue-router';

import { getBoosterDetail, getBoosterList } from '@/api/booster';
import { assignOrder, completeOrder, getOrderDetail, getOrderTimeline, updateOrder } from '@/api/order';
import { useUserStore } from '@/store';

export default defineComponent({
  name: 'OrderDetail',
  components: { EditIcon, PlayCircleIcon, PauseCircleIcon, StopCircleIcon },
  setup() {
    const route = useRoute();
    const { id } = route.params;

    // 1. Status Flow Logic
    const currentStep = ref(0); // 0: Pending, 1: In Progress, 2: Settled
    const remainingTime = ref('--:--:--');
    const isOverdue = ref(false);

    // Manual Countdown Setting
    const manualTimeVisible = ref(false);
    const manualTimeHours = ref(0);
    const getCountdownStorageKey = () => `order-countdown-${String(id)}`;
    const readCountdownState = () => {
      if (typeof window === 'undefined') return null;
      try {
        const raw = window.localStorage.getItem(getCountdownStorageKey());
        if (!raw) return null;
        const parsed = JSON.parse(raw);
        if (!parsed || typeof parsed !== 'object') return null;
        return parsed as { deadlineTime?: string; isPaused?: boolean; gameMetaData?: string };
      } catch {
        return null;
      }
    };
    const saveCountdownState = () => {
      if (typeof window === 'undefined') return;
      try {
        window.localStorage.setItem(
          getCountdownStorageKey(),
          JSON.stringify({
            deadlineTime: order.deadlineTime,
            isPaused: order.isPaused,
            gameMetaData: order.gameMetaData,
          }),
        );
      } catch {}
    };
    const clearCountdownState = () => {
      if (typeof window === 'undefined') return;
      try {
        window.localStorage.removeItem(getCountdownStorageKey());
      } catch {}
    };

    const handleManualTimeSubmit = async () => {
      const hours = Number(manualTimeHours.value);
      if (hours < 0 || hours > 1000) {
        MessagePlugin.warning('请输入0-1000之间的数值');
        return;
      }

      const now = new Date();
      const deadline = new Date(now.getTime() + hours * 60 * 60 * 1000);
      const deadlineStr = dayjs(deadline).format('YYYY-MM-DD HH:mm:ss');

      try {
        let meta = {};
        try {
          meta = JSON.parse(order.gameMetaData || '{}');
        } catch {}
        if ((meta as any).pausedRemainingMs) {
          delete (meta as any).pausedRemainingMs;
        }
        const payload: any = {
          deadlineTime: deadlineStr,
          region: order.region,
          gameName: order.gameName,
          amount: order.amount,
          title: order.title,
          gameMode: order.gameMode,
          accountUsername: order.account,
          isPaused: false,
          gameMetaData: Object.keys(meta).length ? JSON.stringify(meta) : '',
        };
        await updateOrder(String(id), payload);
        order.deadlineTime = deadlineStr;
        order.isPaused = false;
        order.gameMetaData = payload.gameMetaData;

        if (timer) clearInterval(timer);
        updateCountdown();
        timer = setInterval(updateCountdown, 1000);
        saveCountdownState();

        MessagePlugin.success('倒计时设置成功');
        manualTimeVisible.value = false;
      } catch (e: any) {
        console.error(e);
        MessagePlugin.error(e.message || '设置失败');
      }
    };

    const handleTogglePause = async () => {
      try {
        let meta = {};
        try {
          meta = JSON.parse(order.gameMetaData || '{}');
        } catch {}

        const payload: any = {
          region: order.region,
          gameName: order.gameName,
          amount: order.amount,
          title: order.title,
          gameMode: order.gameMode,
          accountUsername: order.account,
        };

        if (order.isPaused) {
          // Resume
          const pausedRemainingMs = (meta as any).pausedRemainingMs || 0;
          const newDeadline = dayjs().add(pausedRemainingMs, 'ms').format('YYYY-MM-DD HH:mm:ss');
          delete (meta as any).pausedRemainingMs;

          payload.isPaused = false;
          payload.deadlineTime = newDeadline;
          payload.gameMetaData = JSON.stringify(meta);

          await updateOrder(String(id), payload);
          order.isPaused = false;
          order.deadlineTime = newDeadline;
          order.gameMetaData = payload.gameMetaData;
          MessagePlugin.success('倒计时已恢复');
          saveCountdownState();
        } else {
          // Pause
          if (!order.deadlineTime) {
            MessagePlugin.warning('倒计时未设置，无法暂停');
            return;
          }
          const now = new Date().getTime();
          const deadline = new Date(order.deadlineTime).getTime();
          const diff = deadline - now;

          if (diff <= 0) {
            MessagePlugin.warning('倒计时已结束，无法暂停');
            return;
          }

          (meta as any).pausedRemainingMs = diff;
          payload.isPaused = true;
          payload.deadlineTime = ''; // Clear deadline or keep it? If we clear, updateCountdown handles it.
          // Note: Backend might reject empty deadlineTime if we don't send it or send null.
          // Let's send null or empty string if allowed. Model says string.
          // But to be safe, maybe we don't update deadlineTime in backend?
          // If we don't update deadlineTime, it keeps ticking.
          // So we MUST update deadlineTime to null or something far future?
          // Let's try sending empty string as per our previous logic for "clearing".
          payload.deadlineTime = null;

          payload.gameMetaData = JSON.stringify(meta);

          await updateOrder(String(id), payload);
          order.isPaused = true;
          order.deadlineTime = '';
          order.gameMetaData = payload.gameMetaData;
          MessagePlugin.success('倒计时已暂停');
          saveCountdownState();
        }
        updateCountdown();
      } catch (e: any) {
        console.error(e);
        MessagePlugin.error(e.message || '操作失败');
      }
    };

    const handleClearTime = async () => {
      const confirmDialog = DialogPlugin.confirm({
        header: '确认清零',
        body: '确定要清零倒计时吗？此操作无法撤销。',
        onConfirm: async () => {
          try {
            const payload: any = {
              region: order.region,
              gameName: order.gameName,
              amount: order.amount,
              title: order.title,
              gameMode: order.gameMode,
              accountUsername: order.account,
              deadlineTime: null,
              isPaused: false,
            };

            // Clean metadata
            let meta = {};
            try {
              meta = JSON.parse(order.gameMetaData || '{}');
              if ((meta as any).pausedRemainingMs) {
                delete (meta as any).pausedRemainingMs;
                payload.gameMetaData = JSON.stringify(meta);
              }
            } catch {}

            await updateOrder(String(id), payload);
            order.deadlineTime = '';
            order.isPaused = false;
            if (payload.gameMetaData) {
              order.gameMetaData = payload.gameMetaData;
            }
            updateCountdown();
            clearCountdownState();
            MessagePlugin.success('倒计时已清零');
            confirmDialog.hide();
          } catch (e: any) {
            console.error(e);
            MessagePlugin.error(e.message || '操作失败');
          }
        },
      });
    };

    const handleComplete = async () => {
      if (!order.boosterId) {
        MessagePlugin.warning('请先分配打手，否则无法结单');
        return;
      }
      try {
        const payload: any = {
          region: order.region,
          gameName: order.gameName,
          amount: order.amount,
          title: order.title,
          gameMode: order.gameMode,
          accountUsername: order.account,
          deadlineTime: null,
          isPaused: false,
        };

        let meta = {};
        try {
          meta = JSON.parse(order.gameMetaData || '{}');
          if ((meta as any).pausedRemainingMs) {
            delete (meta as any).pausedRemainingMs;
            payload.gameMetaData = JSON.stringify(meta);
          }
        } catch {}

        await updateOrder(String(order.id), payload);
        await completeOrder(order.id);
        clearCountdownState();
        MessagePlugin.success('订单已完成，结算记录已生成');
        initData();
      } catch (e: any) {
        console.error(e);
        MessagePlugin.error(e.message || '操作失败');
      }
    };

    // 2. Data
    const boosterHistory = ref<any[]>([]);
    const booster = reactive({
      id: 0,
      name: '',
      nickname: '',
      avatar: '',
      rating: 0,
    });

    const order = reactive({
      id: '',
      orderNo: '',
      xianyuOrderNo: '',
      title: '',
      amount: 0,
      status: 'PENDING',
      boosterId: '',
      customerName: '',
      customerPhone: '',
      customerWechat: '',
      customerQq: '',
      description: '',
      region: '',
      gameName: '',
      gameMode: '',
      gameUid: '',
      gameRank: '',
      specialRequirements: '',
      targetAssets: '',
      targetItems: [] as string[],
      requirements: [] as string[],
      account: '',
      createdAt: '',
      deadlineTime: '',
      isPaused: false,
      gameMetaData: '',
    });

    let timer: any = null;

    onUnmounted(() => {
      if (timer) clearInterval(timer);
    });

    const updateCountdown = () => {
      // If Paused, show static remaining time from metadata
      if (order.isPaused) {
        isOverdue.value = false;
        try {
          const meta = JSON.parse(order.gameMetaData || '{}');
          if (meta.pausedRemainingMs) {
            const diff = meta.pausedRemainingMs;
            const days = Math.floor(diff / (1000 * 60 * 60 * 24));
            const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((diff % (1000 * 60)) / 1000);

            const pad = (n: number) => n.toString().padStart(2, '0');
            if (days > 0) {
              remainingTime.value = `${days}天 ${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
            } else {
              remainingTime.value = `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
            }
            return;
          }
        } catch (e) {
          console.error(e);
        }
        remainingTime.value = '已暂停';
        return;
      }

      if (!order.deadlineTime) {
        remainingTime.value = '--:--:--';
        return;
      }
      const now = new Date().getTime();
      const deadline = new Date(order.deadlineTime).getTime();
      const diff = deadline - now;

      if (diff <= 0) {
        remainingTime.value = '00:00:00';
        isOverdue.value = true;
      } else {
        isOverdue.value = false;
        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((diff % (1000 * 60)) / 1000);

        const pad = (n: number) => n.toString().padStart(2, '0');

        if (days > 0) {
          remainingTime.value = `${days}天 ${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
        } else {
          remainingTime.value = `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
        }
      }
    };

    const initData = async () => {
      try {
        const res = await getOrderDetail(id as string);
        if (res) {
          order.id = res.id;
          order.orderNo = res.orderNo;
          order.xianyuOrderNo = res.xianyuOrderNo || '';
          order.title = res.title;
          order.amount = res.amount;
          order.status = res.status;
          order.boosterId = res.boosterId || '';
          order.customerPhone = res.customerPhone || '';
          order.customerWechat = res.customerWechat || '';
          order.customerQq = res.customerQq || '';
          order.description = res.description || '';
          order.region = res.region;
          order.gameName = res.gameName;
          order.gameMode = res.gameMode;
          order.gameUid = res.gameUid || '';
          order.gameRank = res.gameRank || '';
          order.account = res.accountUsername;
          order.createdAt = res.createdAt || '';
          order.deadlineTime = res.deadlineTime || '';
          order.isPaused = res.isPaused || false;
          order.gameMetaData = res.gameMetaData || '';
          const storedCountdown = readCountdownState();
          if (storedCountdown) {
            if (!order.deadlineTime && storedCountdown.deadlineTime) {
              order.deadlineTime = storedCountdown.deadlineTime;
            }
            if (!order.gameMetaData && storedCountdown.gameMetaData) {
              order.gameMetaData = storedCountdown.gameMetaData;
            }
            if (!order.isPaused && storedCountdown.isPaused) {
              order.isPaused = storedCountdown.isPaused;
            }
          }
          if (order.deadlineTime || order.isPaused || order.gameMetaData) {
            saveCountdownState();
          }

          // Load proof images
          if (res.proofImages) {
            try {
              const images = JSON.parse(res.proofImages);
              if (Array.isArray(images)) {
                uploadFiles.value = images.map((url, index) => ({
                  url,
                  name: `screenshot-${index + 1}`,
                  status: 'success',
                }));
              }
            } catch (e) {
              console.error('Failed to parse proofImages', e);
            }
          }

          updateCountdown();
          if (timer) clearInterval(timer);
          timer = setInterval(updateCountdown, 1000);

          // Update Status Step
          const statusMap: Record<string, number> = {
            PENDING: 0,
            ACCEPTED: 1,
            PROCESSING: 1,
            VALIDATING: 1,
            COMPLETED: 2,
            CANCELLED: 2,
            LOCKED: 2,
            CLOSED: 2,
          };
          currentStep.value = statusMap[res.status] || 0;

          // Parse Meta Data if available
          if (res.gameMetaData) {
            try {
              const meta = JSON.parse(res.gameMetaData);
              order.targetAssets = meta.targetAssets || '';
              order.targetItems = meta.targetItems || [];
              order.requirements = meta.requirements || [];
            } catch (e) {
              console.error('Failed to parse gameMetaData', e);
            }
          }

          // Fetch Booster Info
          if (res.boosterId) {
            try {
              const boosterRes = await getBoosterDetail(res.boosterId);
              if (boosterRes) {
                booster.id = Number(boosterRes.id);
                booster.name = boosterRes.name;
                booster.nickname = boosterRes.nickname || '';
              }
            } catch (e) {
              console.error(e);
            }
          }

          // Fetch Booster History from Timeline
          try {
            const timelineRes = await getOrderTimeline(id as string);
            if (timelineRes) {
              const assigns = timelineRes.filter((t: any) => t.action === '分配打手' || t.action === '更换打手');
              assigns.sort((a: any, b: any) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());

              const history: Array<{ id: string | number; name: string; nickname: string }> = [];
              for (const t of assigns) {
                let bInfo = null;
                // Try parse metadata
                if (t.metaData) {
                  try {
                    const meta = JSON.parse(t.metaData);
                    if (meta.boosterId) {
                      bInfo = {
                        id: meta.boosterId,
                        name: meta.name,
                        nickname: meta.nickname,
                      };
                    }
                  } catch {}
                }

                // Legacy Fallback
                if (!bInfo && t.content) {
                  const match1 = /已分配给打手: (.+)/.exec(t.content);
                  const match2 = /新打手：(.+)/.exec(t.content);
                  const nameRaw = match1 ? match1[1] : match2 ? match2[1] : null;

                  if (nameRaw) {
                    // Check if name has parens for nickname
                    // E.g. "Name (Nickname)"
                    // But if Name has parens? "Name (Nick)"
                    // Let's assume standard format we generated: "Name (Nickname)"
                    const nickMatch = /(.+) \((.+)\)$/.exec(nameRaw);
                    if (nickMatch) {
                      bInfo = { id: `legacy-${t.id}`, name: nickMatch[1], nickname: nickMatch[2] };
                    } else {
                      bInfo = { id: `legacy-${t.id}`, name: nameRaw, nickname: '' };
                    }
                  }
                }

                if (bInfo) {
                  history.push(bInfo);
                }
              }
              boosterHistory.value = history;

              // Fetch missing nicknames for legacy records
              const missingNicknames = history.filter((h) => !h.nickname && h.name);
              if (missingNicknames.length > 0) {
                const namesToFetch = [...new Set(missingNicknames.map((h) => h.name))];
                Promise.all(
                  namesToFetch.map(async (name) => {
                    try {
                      const res = await getBoosterList({
                        page: 1,
                        pageSize: 10,
                        keyword: name,
                      });
                      if (res.list && res.list.length > 0) {
                        const match = res.list.find((b: any) => b.name === name);
                        if (match && match.nickname) {
                          history
                            .filter((h) => h.name === name)
                            .forEach((h) => {
                              h.nickname = match.nickname;
                            });
                        }
                      }
                    } catch (e) {
                      console.error(`Failed to fetch nickname for ${name}`, e);
                    }
                  }),
                ).then(() => {
                  boosterHistory.value = [...history];
                });
              }
            }
          } catch (e) {
            console.error('Failed to fetch timeline for booster history', e);
          }
        }
      } catch (error) {
        console.error(error);
        MessagePlugin.error('获取订单详情失败');
      }
    };

    onMounted(() => {
      initData();
    });

    const copyText = (text: string) => {
      navigator.clipboard.writeText(text);
      MessagePlugin.success('复制成功');
    };

    // 4. Action View
    const currentView = ref('booster');

    // 5. Upload Logic
    const userStore = useUserStore();
    const uploadFiles = ref([]);
    const uploadHeaders = computed(() => ({
      Authorization: userStore.token,
    }));
    const maxUploadCount = 6;

    const formatResponse = (res: any) => {
      let payload = res;
      if (typeof res === 'string') {
        try {
          payload = JSON.parse(res);
        } catch {
          payload = { message: res };
        }
      }

      // Robust check for success
      if (payload?.code === 0 || payload?.url || payload?.data?.url) {
        const url = payload?.url || payload?.data?.url;
        return { ...payload, url, status: 'success' };
      }

      return { ...payload, error: payload?.message || '上传失败' };
    };

    const saveScreenshotsLoading = ref(false);

    const handleSaveScreenshots = async () => {
      if (uploadFiles.value.some((f: any) => f.status !== 'success')) {
        MessagePlugin.warning('请等待所有图片上传完成');
        return;
      }

      saveScreenshotsLoading.value = true;
      try {
        const images = uploadFiles.value.filter((f: any) => f.status === 'success' && f.url).map((f: any) => f.url);

        await updateOrder(String(id), {
          region: order.region,
          gameName: order.gameName,
          amount: order.amount,
          title: order.title,
          gameMode: order.gameMode,
          accountUsername: order.account,
          proofImages: JSON.stringify(images),
        });

        console.log('Proof images updated:', images);
        MessagePlugin.success('截图已保存');
      } catch (e: any) {
        console.error('Failed to update proof images', e);
        MessagePlugin.error('保存截图失败');
      } finally {
        saveScreenshotsLoading.value = false;
      }
    };

    const handleUploadSuccess = (context: any) => {
      if (context.response && context.response.code === 0) {
        MessagePlugin.success('截图上传成功，请点击“保存截图”');
        console.log('Uploaded image:', context.response.data.url);
      } else {
        MessagePlugin.error(`上传失败: ${context.response?.message || '未知错误'}`);
      }
    };

    const handleRemove = (_context: any) => {
      // No auto-save on remove
    };

    const handleUploadFail = (_context: any) => {
      MessagePlugin.error('上传失败');
    };

    const handleBeforeUpload = () => {
      const count = Array.isArray(uploadFiles.value) ? uploadFiles.value.length : 0;
      if (count >= maxUploadCount) {
        MessagePlugin.warning('最多上传3张图片');
        return false;
      }
      return true;
    };

    const handleBeforeAllFilesUpload = (files: any[]) => {
      const currentCount = Array.isArray(uploadFiles.value) ? uploadFiles.value.length : 0;
      const nextCount = currentCount + (Array.isArray(files) ? files.length : 0);
      if (currentCount >= maxUploadCount || nextCount > maxUploadCount) {
        MessagePlugin.warning('最多上传3张图片');
        return false;
      }
      return true;
    };

    const handleUploadChange = (value: any, context: any) => {
      const list = Array.isArray(value) ? value : context?.files || value?.fileList || value?.files || [];
      if (Array.isArray(list) && list.length > maxUploadCount) {
        uploadFiles.value = list.slice(0, maxUploadCount);
        MessagePlugin.warning('最多上传6张图片');
        return;
      }
      uploadFiles.value = list;
    };

    // Change Booster Logic
    const changeBoosterVisible = ref(false);
    const changeBoosterLoading = ref(false);
    const changeBoosterId = ref('');
    const boosterOptions = ref<{ label: string; value: string }[]>([]);

    const handleChangeBooster = async () => {
      changeBoosterLoading.value = true;
      changeBoosterVisible.value = true;
      changeBoosterId.value = '';
      try {
        const res = await getBoosterList({ page: 1, pageSize: 100, status: 'Online' });
        if (res && res.list) {
          boosterOptions.value = res.list.map((b: any) => ({
            label: `${b.name}${b.nickname ? ` (${b.nickname})` : ''}`,
            value: String(b.id),
          }));
        }
      } catch (e) {
        console.error(e);
        MessagePlugin.error('获取打手列表失败');
      } finally {
        changeBoosterLoading.value = false;
      }
    };

    const handleChangeBoosterSubmit = async () => {
      if (!changeBoosterId.value) {
        MessagePlugin.warning('请选择打手');
        return;
      }
      try {
        await assignOrder(order.id, changeBoosterId.value);
        const selected = boosterOptions.value.find((opt) => opt.value === changeBoosterId.value);
        MessagePlugin.success(`更换打手成功，新打手：${selected?.label || ''}`);
        changeBoosterVisible.value = false;
        initData(); // Refresh data
      } catch (e) {
        console.error(e);
        MessagePlugin.error('更换打手失败');
      }
    };

    return {
      uploadFiles,
      uploadHeaders,
      maxUploadCount,
      formatResponse,
      handleUploadSuccess,
      handleUploadFail,
      handleBeforeUpload,
      handleBeforeAllFilesUpload,
      handleUploadChange,
      currentStep,
      remainingTime,
      isOverdue,
      booster,
      order,
      copyText,
      currentView,
      changeBoosterVisible,
      changeBoosterLoading,
      changeBoosterId,
      boosterOptions,
      boosterHistory,
      handleChangeBooster,
      handleChangeBoosterSubmit,
      manualTimeVisible,
      manualTimeHours,
      handleManualTimeSubmit,
      handleTogglePause,
      handleClearTime,
      handleComplete,
      handleRemove,
      handleSaveScreenshots,
      saveScreenshotsLoading,
    };
  },
});
</script>
<style lang="less" scoped>
.order-detail-page {
  .mb-4 {
    margin-bottom: 16px;
  }
  .stretch-row {
    display: flex;
    align-items: stretch;
  }
  .full-height-card {
    height: 100%;
    display: flex;
    flex-direction: column;
    :deep(.t-card__body) {
      flex: 1;
    }
  }
  .mr-2 {
    margin-right: 8px;
  }
  .mt-2 {
    margin-top: 8px;
  }
  .mt-4 {
    margin-top: 16px;
  }
  .text-danger {
    color: var(--td-error-color);
  }
  .text-primary {
    color: var(--td-brand-color);
  }
  .text-secondary {
    color: var(--td-text-color-secondary);
  }
  .text-price {
    color: var(--td-error-color);
    font-weight: bold;
    font-size: 16px;
  }

  .upload-wrapper {
    display: flex;
    align-items: flex-start;
  }

  .upload-panel {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  :deep(.upload-grid-5 .t-upload__card) {
    display: grid;
    grid-template-columns: repeat(5, 110px);
    gap: 12px;
  }

  :deep(.upload-grid-5 .t-upload__card-item) {
    width: 100% !important;
    height: auto !important;
    aspect-ratio: 1;
    margin: 0 !important;
  }

  :deep(.upload-grid-5 .t-upload__card-container) {
    width: 100% !important;
    height: 100% !important;
  }

  .font-bold {
    font-weight: 700;
    font-size: 16px;
    color: var(--td-text-color-primary);
  }

  .hud-card {
    .countdown-wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .countdown-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      border-left: 1px solid var(--td-component-border);
      border-right: 1px solid var(--td-component-border);
      padding: 0 24px;
    }
    .label {
      font-size: 12px;
      color: var(--td-text-color-secondary);
    }
    .timer {
      font-size: 24px;
      font-weight: bold;
      font-family: monospace;
    }
    .executor-info {
      display: flex;
      align-items: center;
      gap: 12px;
      .info {
        .name {
          font-weight: bold;
        }
      }
    }
  }

  .requirement-list {
    padding-left: 20px;
    margin: 0;
    li {
      color: var(--td-text-color-primary);
      margin-bottom: 4px;
    }
  }

  .special-req-block {
    padding: 0 20px;
    .content {
      white-space: pre-wrap;
      color: var(--td-text-color-primary);
    }
  }
}
</style>
