<template>
  <div class="booster-page">
    <t-card :bordered="false">
      <!-- Search & Operations -->
      <t-row justify="space-between" class="mb-4">
        <t-col>
          <t-space>
            <t-input v-model="searchKey" placeholder="搜索姓名/手机号" clearable @enter="fetchData" />
            <t-select v-model="filterStatus" placeholder="状态筛选" clearable :options="statusOptions" />
            <t-select v-model="filterRegion" placeholder="大区筛选" clearable multiple :options="regionOptions" />
            <t-button theme="primary" @click="fetchData">查询</t-button>
            <t-button theme="default" @click="resetSearch">刷新</t-button>
          </t-space>
        </t-col>
        <t-col>
          <t-button theme="primary" @click="handleAdd">
            <template #icon><add-icon /></template>
            新增打手
          </t-button>
        </t-col>
      </t-row>

      <!-- Table -->
      <t-table
        :data="data"
        :columns="columns"
        :row-key="rowKey"
        :loading="loading"
        :pagination="pagination"
        @page-change="onPageChange"
      >
        <!-- Info Column -->
        <template #info="{ row }">
          <div class="booster-info">
            <div class="name-row">
              <span class="name">{{ row.name }}</span>
              <span v-if="row.nickname" class="text-secondary text-xs ml-1">({{ row.nickname }})</span>
              <t-tooltip content="实名认证/实力认证">
                <t-icon v-if="row.authStatus === 'Verified'" name="check-circle-filled" class="text-success ml-1" />
              </t-tooltip>
              <t-tooltip v-if="row.authImage" content="查看主页截图">
                <t-image-viewer :images="[row.authImage]">
                  <template #trigger="{ open }">
                    <t-icon name="image" class="text-brand ml-1" style="cursor: pointer" @click.stop="open" />
                  </template>
                </t-image-viewer>
              </t-tooltip>
            </div>
            <div class="contact-row"><t-icon name="mobile" /> {{ row.phone }}</div>
          </div>
        </template>

        <!-- Capability Column -->
        <template #capability="{ row }">
          <div class="capability-info">
            <div class="device-row">
              <t-tag size="small" variant="light">
                <template #icon>
                  <t-icon :name="getDeviceIcon(row.device)" />
                </template>
                {{ getDeviceText(row.device) }}
              </t-tag>
              <span class="rank-text ml-2">{{ row.rank }}</span>
            </div>
            <div v-if="row.tags && row.tags.length" class="tags-row mt-1">
              <t-tag v-for="tag in row.tags.slice(0, 2)" :key="tag" size="small" variant="outline" class="mr-1">{{
                tag
              }}</t-tag>
            </div>
          </div>
        </template>

        <!-- Region Column -->
        <template #region="{ row }">
          <div class="region-info">
            <template v-if="normalizeRegions(row.regions).length">
              <t-tag
                v-for="region in normalizeRegions(row.regions)"
                :key="region"
                theme="primary"
                variant="light"
                size="small"
                class="mr-1"
              >
                {{ region === 'QQ' ? 'QQ区' : region === 'WeChat' ? '微信区' : region }}
              </t-tag>
            </template>
            <span v-else class="text-secondary">-</span>
          </div>
        </template>

        <!-- Status & Load Column -->
        <template #load="{ row }">
          <div class="load-info">
            <div class="mb-1">
              <t-tag :theme="getStatusTheme(row.status)" variant="light-outline" size="small">{{
                getStatusText(row.status)
              }}</t-tag>
            </div>
          </div>
        </template>

        <!-- Operations Column -->
        <template #op="{ row }">
          <t-space size="small">
            <t-button theme="primary" size="small" @click="handleEdit(row)">编辑</t-button>
            <t-popconfirm content="确认删除该打手吗？" @confirm="handleDelete(row)">
              <t-button theme="danger" size="small">删除</t-button>
            </t-popconfirm>
          </t-space>
        </template>
      </t-table>
    </t-card>

    <!-- Create/Edit Dialog -->
    <t-dialog
      v-model:visible="dialogVisible"
      :header="dialogTitle"
      width="700px"
      placement="center"
      @confirm="handleSubmit"
    >
      <t-form :key="formKey" ref="formRef" :data="formData" :rules="rules" label-align="top" reset-type="initial">
        <div class="form-section-title">基础信息</div>
        <t-row :gutter="16">
          <t-col :span="6">
            <t-form-item label="打手姓名" name="name">
              <t-input v-model="formData.name" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="手机号" name="phone">
              <t-input v-model="formData.phone" />
            </t-form-item>
          </t-col>
        </t-row>
        <t-row :gutter="16">
          <t-col :span="6">
            <t-form-item label="打手外号" name="nickname">
              <t-input v-model="formData.nickname" placeholder="请输入打手外号" />
            </t-form-item>
          </t-col>
        </t-row>

        <div class="form-section-title mt-4">能力画像</div>
        <t-row :gutter="16">
          <t-col :span="6">
            <t-form-item label="游戏段位" name="rank">
              <t-select v-model="formData.rank" :options="rankOptions" clearable placeholder="请选择" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="设备类型" name="device">
              <t-radio-group v-model="formData.device">
                <t-radio value="PC">PC端</t-radio>
                <t-radio value="Mobile">移动端</t-radio>
              </t-radio-group>
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="游戏大区" name="regions">
              <t-checkbox-group v-model="formData.regions">
                <t-checkbox value="QQ">QQ区</t-checkbox>
                <t-checkbox value="WeChat">微信区</t-checkbox>
              </t-checkbox-group>
            </t-form-item>
          </t-col>
        </t-row>
        <t-row :gutter="16">
          <t-col :span="12">
            <t-form-item label="主页截图" name="authImage">
              <t-upload
                v-model="authImageFiles"
                action="/api/system/file/upload"
                :headers="uploadHeaders"
                theme="image"
                tips="上传游戏个人主页截图以进行实力认证"
                accept="image/*"
                :locale="{ triggerUploadText: { image: '点击上传' } }"
                :format-response="formatResponse"
                @success="handleUploadSuccess"
                @remove="handleRemove"
              />
            </t-form-item>
          </t-col>
        </t-row>
      </t-form>
    </t-dialog>
  </div>
</template>
<script lang="ts" setup>
import { AddIcon } from 'tdesign-icons-vue-next';
import type { PrimaryTableCol } from 'tdesign-vue-next';
import { MessagePlugin } from 'tdesign-vue-next';
import { computed, onMounted, reactive, ref } from 'vue';

import { createBooster, deleteBooster, getBoosterDetail, getBoosterList, updateBooster } from '@/api/booster';
import type { Booster } from '@/api/model/boosterModel';
import { useUserStore } from '@/store';

type BoosterForm = Partial<Omit<Booster, 'regions'>> & { regions: string[] };

const userStore = useUserStore();
const uploadHeaders = computed(() => ({
  Authorization: userStore.token,
}));

const data = ref<Booster[]>([]);
const loading = ref(false);
const pagination = reactive({
  current: 1,
  pageSize: 10,
  total: 0,
});
const searchKey = ref('');
const filterStatus = ref('');
const filterRegion = ref<string[]>([]);

const columns: PrimaryTableCol[] = [
  { colKey: 'info', title: '打手信息', width: 180, fixed: 'left' },
  { colKey: 'capability', title: '能力画像', width: 200 },
  { colKey: 'region', title: '游戏大区', width: 150 },
  { colKey: 'load', title: '接单状态', width: 150 },
  { colKey: 'op', title: '操作', width: 180, fixed: 'right' },
];
const rowKey = 'id';

const statusOptions = [
  { label: '空闲中', value: 'Online' },
  { label: '接单中', value: 'Busy' },
];
const regionOptions = [
  { label: 'QQ区', value: 'QQ' },
  { label: '微信区', value: 'WeChat' },
];

const rankOptions = [
  { label: '青铜', value: '青铜' },
  { label: '白银', value: '白银' },
  { label: '黄金', value: '黄金' },
  { label: '铂金', value: '铂金' },
  { label: '钻石', value: '钻石' },
  { label: '黑鹰', value: '黑鹰' },
  { label: '巅峰', value: '巅峰' },
];

// Dialog
const dialogVisible = ref(false);
const dialogTitle = ref('新增打手');
const formKey = ref(0);
const formRef = ref<any>(null);
const formData = reactive<BoosterForm>({
  status: 'Online',
  device: 'PC',
  regions: [],
  authStatus: 'Unverified',
});

const rules = {
  name: [{ required: true, message: '请输入打手姓名' }],
  // nickname: [{ required: true, message: '请输入打手外号' }],
  phone: [{ required: true, message: '请输入手机号' }],
  rank: [{ required: true, message: '请输入游戏段位' }],
};

const authImageFiles = ref([]);
const regionsCache = ref<Record<string, string[]>>({});

const normalizeRegions = (regions: unknown) => {
  if (!regions) {
    return [];
  }
  if (Array.isArray(regions)) {
    return regions;
  }
  if (typeof regions === 'string') {
    return regions.split(',').filter(Boolean);
  }
  return [];
};

const formatResponse = (res: any) => {
  return { url: res.data.url };
};

const fetchData = async () => {
  loading.value = true;
  try {
    const res = await getBoosterList({
      page: pagination.current,
      pageSize: pagination.pageSize,
      keyword: searchKey.value,
      status: filterStatus.value,
      region: filterRegion.value.join(','),
    });
    const mapped = res.list.map((item: any) => {
      const normalized = normalizeRegions(item.regions);
      const cached = regionsCache.value[String(item.id)];
      return {
        ...item,
        regions: normalized.length ? normalized : cached || [],
      };
    });
    const filtered = filterRegion.value.length
      ? mapped.filter((item: any) => {
          const regions = normalizeRegions(item.regions);
          return filterRegion.value.some((selected) => regions.includes(selected));
        })
      : mapped;
    data.value = filtered;
    pagination.total = filterRegion.value.length ? filtered.length : res.total;
  } catch (e) {
    console.error(e);
  } finally {
    loading.value = false;
  }
};

const onPageChange = (pageInfo: any) => {
  pagination.current = pageInfo.current;
  pagination.pageSize = pageInfo.pageSize;
  fetchData();
};

const resetSearch = () => {
  searchKey.value = '';
  filterStatus.value = '';
  filterRegion.value = [];
  fetchData();
};

const handleAdd = () => {
  dialogTitle.value = '新增打手';
  formKey.value += 1;
  Object.assign(formData, {
    id: undefined,
    name: '',
    nickname: '',
    phone: '',
    rank: '',
    regions: [],
    device: 'PC',
    authStatus: 'Unverified',
    authImage: '',
    maxOrderLimit: 3,
    banAssocCount: 0,
    isBanned: false,
    status: 'Online',
    currentOrderCount: 0,
    onTimeRate: 100,
  });
  authImageFiles.value = [];
  dialogVisible.value = true;
};

const handleEdit = async (row: Booster) => {
  dialogTitle.value = '编辑打手';
  formKey.value += 1;
  formData.authImage = '';
  dialogVisible.value = true;
  try {
    const detail = await getBoosterDetail(String(row.id));
    Object.assign(formData, detail || row);
  } catch {
    Object.assign(formData, row);
  }
  formData.regions = normalizeRegions(formData.regions);
  if (formData.authImage) {
    authImageFiles.value = [{ url: formData.authImage, name: '主页截图' }];
  } else {
    authImageFiles.value = [];
  }
};

const handleUploadSuccess = (context: any) => {
  const responseUrl =
    context?.response?.data?.url ||
    context?.response?.url ||
    context?.file?.url ||
    context?.file?.response?.url ||
    context?.file?.response?.data?.url;
  const hasSuccessCode = context?.response?.code === 0 || context?.response?.code == null;
  if (responseUrl && hasSuccessCode) {
    formData.authImage = responseUrl;
    MessagePlugin.success('上传成功');
  } else {
    MessagePlugin.error(`上传失败: ${context.response?.message || '未知错误'}`);
  }
};

const handleRemove = () => {
  formData.authImage = '';
};

const handleSubmit = async () => {
  try {
    const valid = await formRef.value?.validate?.();
    if (valid === true) {
      if (!formData.authImage && authImageFiles.value?.length) {
        const [firstFile] = authImageFiles.value as any[];
        if (firstFile?.url) {
          formData.authImage = firstFile.url;
        }
      }
      const payload: Partial<Booster> = { ...formData, regions: formData.regions };
      if (Array.isArray(payload.regions)) {
        payload.regions = payload.regions.join(',');
      }

      if (formData.id) {
        const updated = await updateBooster(payload);
        const normalized = normalizeRegions((updated as any)?.regions ?? payload.regions ?? formData.regions);
        regionsCache.value[String(formData.id)] = normalized;
        data.value = data.value.map((item: any) =>
          String(item.id) === String(formData.id) ? { ...(updated as any), regions: normalized } : item,
        );
        MessagePlugin.success('更新成功');
      } else {
        const created = await createBooster(payload);
        const createdId = (created as any)?.id;
        const normalized = normalizeRegions((created as any)?.regions ?? payload.regions ?? formData.regions);
        if (createdId != null) {
          regionsCache.value[String(createdId)] = normalized;
        }
        MessagePlugin.success('创建成功');
      }
      dialogVisible.value = false;
      fetchData();
    } else {
      console.warn('表单验证失败', valid);
    }
  } catch (e: any) {
    console.error('提交失败', e);
    MessagePlugin.error(e.message || '提交失败');
  }
};

const handleDelete = async (row: Booster) => {
  try {
    await deleteBooster(row.id);
    MessagePlugin.success('删除成功');
    fetchData();
  } catch (e: any) {
    MessagePlugin.error(e.message || '删除失败');
  }
};

const getStatusTheme = (status: string) => {
  if (!status) return 'default';
  const s = status.toLowerCase();
  switch (s) {
    case 'online':
      return 'success';
    case 'busy':
      return 'warning';
    case 'offline':
      return 'success';
    default:
      return 'default';
  }
};

const getStatusText = (status: string) => {
  if (!status) return '';
  const s = status.toLowerCase();
  switch (s) {
    case 'online':
      return '空闲中';
    case 'busy':
      return '接单中';
    case 'offline':
      return '空闲中';
    default:
      return status;
  }
};

const getDeviceText = (device?: string) => {
  if (!device) return '';
  const d = device.toLowerCase();
  switch (d) {
    case 'pc':
      return 'PC端';
    case 'mobile':
      return '移动端';
    default:
      return device;
  }
};

const getDeviceIcon = (device?: string) => {
  const d = (device || '').toLowerCase();
  return d === 'pc' ? 'desktop' : 'mobile';
};

onMounted(() => {
  fetchData();
});
</script>
<style scoped lang="less">
.booster-page {
  padding: 24px;
}
.mb-4 {
  margin-bottom: 16px;
}
.mb-1 {
  margin-bottom: 4px;
}
.ml-1 {
  margin-left: 4px;
}
.ml-2 {
  margin-left: 8px;
}
.mr-1 {
  margin-right: 4px;
}
.mt-1 {
  margin-top: 4px;
}
.mt-4 {
  margin-top: 16px;
}

.text-success {
  color: var(--td-success-color);
}
.text-brand {
  color: var(--td-brand-color);
}
.text-warning {
  color: var(--td-warning-color);
}
.text-error {
  color: var(--td-error-color);
}
.text-secondary {
  color: var(--td-text-color-secondary);
}
.text-xs {
  font-size: 12px;
}
.font-bold {
  font-weight: 600;
}

.booster-info {
  .name-row {
    display: flex;
    align-items: center;
    font-weight: 500;
  }
  .contact-row {
    font-size: 13px;
    color: var(--td-text-color-secondary);
    margin-top: 4px;
  }
}

.capability-info {
  .device-row {
    display: flex;
    align-items: center;
  }
  .rank-text {
    font-size: 13px;
  }
}

.form-section-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 12px;
  border-left: 4px solid var(--td-brand-color);
  padding-left: 8px;
}
</style>
