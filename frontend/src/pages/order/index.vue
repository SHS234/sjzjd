<template>
  <div class="order-page">
    <t-card :bordered="false">
      <div
        class="header-row"
        style="
          display: flex;
          justify-content: center;
          align-items: center;
          margin-bottom: 16px;
          position: relative;
          min-height: 48px;
        "
      >
        <div class="sp-title" style="position: absolute; left: 0">订单管理</div>
        <div class="order-stats">
          <t-space size="large">
            <div
              class="stat-item"
              style="text-align: center; min-width: 80px; cursor: pointer"
              @click="quickFilter('PENDING')"
            >
              <div style="font-size: 14px; color: var(--td-text-color-secondary)">待接单</div>
              <div style="font-size: 20px; font-weight: bold; color: var(--td-brand-color)">{{ stats.pending }}</div>
            </div>
            <div
              class="stat-item"
              style="text-align: center; min-width: 80px; cursor: pointer"
              @click="quickFilter('PROCESSING')"
            >
              <div style="font-size: 14px; color: var(--td-text-color-secondary)">进行中</div>
              <div style="font-size: 20px; font-weight: bold; color: var(--td-warning-color)">
                {{ stats.processing }}
              </div>
            </div>
            <div
              class="stat-item"
              style="text-align: center; min-width: 80px; cursor: pointer"
              @click="quickFilter('COMPLETED')"
            >
              <div style="font-size: 14px; color: var(--td-text-color-secondary)">已结单</div>
              <div style="font-size: 20px; font-weight: bold; color: var(--td-success-color)">
                {{ stats.completed }}
              </div>
            </div>
            <div
              class="stat-item"
              style="text-align: center; min-width: 80px; cursor: pointer"
              @click="quickFilter('CLOSED')"
            >
              <div style="font-size: 14px; color: var(--td-text-color-secondary)">补单中</div>
              <div style="font-size: 20px; font-weight: bold; color: var(--td-warning-color)">{{ stats.closed }}</div>
            </div>
          </t-space>
        </div>
      </div>

      <!-- Order Toolbar -->
      <t-row justify="space-between" class="mb-4">
        <t-col>
          <t-button theme="primary" @click="handleAdd">
            <template #icon><t-icon name="add" /></template>
            新建订单
          </t-button>
        </t-col>
        <t-col>
          <t-input
            v-model="searchKeyword"
            placeholder="搜索订单号/闲鱼订单号"
            style="width: 300px"
            @enter="handleSearch"
          >
            <template #suffix-icon>
              <t-icon name="search" @click="handleSearch" />
            </template>
          </t-input>
        </t-col>
      </t-row>

      <!-- Order Table -->
      <t-table
        :data="data"
        :columns="columns"
        :row-key="rowKey"
        :pagination="pagination"
        :loading="loading"
        @page-change="onPageChange"
      >
        <template #xianyuOrderNo="{ row }">
          <t-button
            v-if="row.xianyuOrderNo"
            theme="primary"
            variant="text"
            size="small"
            style="margin-right: 8px"
            @click="handleCopy(row.xianyuOrderNo)"
          >
            复制
          </t-button>
          <span>{{ row.xianyuOrderNo }}</span>
        </template>
        <template #status="{ row }">
          <t-tag :theme="getStatusTheme(row.status)" variant="light-outline">
            {{ getStatusText(row.status) }}
          </t-tag>
        </template>
        <template #op="{ row }">
          <t-space>
            <t-button theme="primary" size="small" @click="handleDetail(row)">详情</t-button>
            <t-button
              v-if="row.status !== 'PROCESSING' && row.status !== 'COMPLETED' && row.status !== 'CLOSED'"
              theme="warning"
              size="small"
              @click="handleAssign(row)"
              >分配打手</t-button
            >
            <t-button theme="default" size="small" @click="handleEdit(row)">编辑</t-button>
            <t-button theme="danger" size="small" @click="handleDelete(row)">删除</t-button>
          </t-space>
        </template>
      </t-table>
    </t-card>

    <!-- Order Dialog -->
    <t-dialog v-model:visible="visible" :header="formTitle" :on-confirm="onSubmit" width="800px">
      <t-form ref="formRef" :data="formData" :rules="rules" :label-width="100">
        <t-divider align="left"><b>基础信息</b></t-divider>
        <t-row :gutter="16">
          <t-col :span="6">
            <t-form-item label="订单金额" name="amount">
              <t-input-number v-model="formData.amount" :min="0" :precision="2" suffix="元" style="width: 100%" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="手机号" name="customerPhone">
              <t-input v-model="formData.customerPhone" placeholder="请输入手机号" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="微信号" name="customerWechat">
              <t-input v-model="formData.customerWechat" placeholder="请输入微信号" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="QQ号" name="customerQq">
              <t-input v-model="formData.customerQq" placeholder="请输入QQ号" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="客户来源" name="customerSource">
              <t-select v-model="formData.customerSource" placeholder="请选择来源">
                <t-option value="闲鱼" label="闲鱼" />
                <t-option value="抖音" label="抖音" />
                <t-option value="小红书" label="小红书" />
                <t-option value="老客推荐" label="老客推荐" />
                <t-option value="其他" label="其他" />
              </t-select>
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="闲鱼订单编号" name="xianyuOrderNo">
              <t-input v-model="formData.xianyuOrderNo" placeholder="请输入闲鱼订单编号" />
            </t-form-item>
          </t-col>
        </t-row>

        <t-divider align="left"><b>游戏档案</b></t-divider>
        <t-row :gutter="16">
          <t-col :span="6">
            <t-form-item label="游戏需求" name="gameName">
              <t-select v-model="formData.gameName" placeholder="请选择游戏需求">
                <t-option value="跑刀" label="跑刀" />
                <t-option value="护航" label="护航" />
              </t-select>
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="区服" name="region">
              <t-select v-model="formData.region">
                <t-option value="QQ区" label="QQ区" />
                <t-option value="微信区" label="微信区" />
              </t-select>
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="游戏UID" name="gameUid">
              <t-input v-model="formData.gameUid" placeholder="请输入UID" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="当前哈弗币" name="gameRank">
              <t-input v-model="gameRankProxy" placeholder="请输入哈弗币数量" suffix="w" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="目标哈弗币" name="targetAssets">
              <t-input v-model="targetAssetsProxy" placeholder="请输入目标哈弗币" suffix="w" />
            </t-form-item>
          </t-col>
        </t-row>

        <t-divider align="left"><b>账号信息</b></t-divider>
        <t-row :gutter="16">
          <t-col :span="6">
            <t-form-item label="游戏账号" name="accountUsername">
              <t-input v-model="formData.accountUsername" placeholder="请输入账号" />
            </t-form-item>
          </t-col>
          <t-col :span="6">
            <t-form-item label="游戏密码" name="accountPassword">
              <t-input v-model="formData.accountPassword" type="password" placeholder="请输入密码" />
            </t-form-item>
          </t-col>
        </t-row>

        <t-divider align="left"><b>其他备注</b></t-divider>
        <t-form-item label="封号记录" name="banRecord">
          <t-select v-model="formData.banRecord" placeholder="请选择封号次数">
            <t-option v-for="n in 11" :key="n - 1" :label="`${n - 1}次`" :value="String(n - 1)" />
          </t-select>
        </t-form-item>
        <t-form-item label="订单备注" name="description">
          <t-textarea v-model="formData.description" placeholder="请输入订单备注" :maxlength="100" />
        </t-form-item>
      </t-form>
    </t-dialog>

    <!-- Assign Dialog -->
    <t-dialog v-model:visible="assignVisible" title="分配打手" width="400px" @confirm="handleAssignSubmit">
      <t-space direction="vertical" style="width: 100%">
        <p>当前订单: {{ currentOrderForAssign?.xianyuOrderNo || currentOrderForAssign?.orderNo }}</p>
        <t-select v-model="assignBoosterId" :options="boosterOptions" placeholder="请选择打手" filterable clearable />
      </t-space>
    </t-dialog>
  </div>
</template>
<script lang="ts">
import type { PrimaryTableCol } from 'tdesign-vue-next';
import { DialogPlugin, MessagePlugin } from 'tdesign-vue-next';
import { computed, defineComponent, nextTick, onMounted, reactive, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

import { getBoosterList } from '@/api/booster';
import type { Order } from '@/api/model/orderModel';
import { assignOrder, completeOrder, createOrder, deleteOrder, getOrderList, updateOrder } from '@/api/order';

export default defineComponent({
  name: 'OrderPage',
  setup() {
    const router = useRouter();
    const route = useRoute();

    // --- Order Logic ---
    const loading = ref(false);
    const data = ref<Order[]>([]);
    const searchKeyword = ref((route.query.keyword as string) || '');
    const pagination = reactive({
      current: Number(route.query.page) || 1,
      pageSize: Number(route.query.pageSize) || 10,
      total: 0,
    });

    const columns: PrimaryTableCol[] = [
      { colKey: 'xianyuOrderNo', title: '闲鱼订单编号', width: 180 },
      { colKey: 'gameName', title: '游戏需求', width: 120 },
      { colKey: 'amount', title: '金额', width: 100, cell: (_h, { row }) => `¥${row.amount}` },
      { colKey: 'status', title: '状态', width: 100 },
      { colKey: 'createdAt', title: '创建时间', width: 180 },
      { colKey: 'op', title: '操作', width: 260, fixed: 'right' },
    ];

    const rowKey = 'id';
    const visible = ref(false);
    const formRef = ref(null);
    const isEdit = ref(false);
    const currentId = ref<string | number>('');
    const formTitle = ref('新建订单');
    const currentGameMetaData = ref<any>({});

    const formData = reactive({
      title: '',
      amount: 0,
      gameName: '跑刀',
      gameMode: '烽火地带',
      region: 'QQ区',
      accountUsername: '',
      accountPassword: '',
      description: '',
      customerName: '',
      customerPhone: '',
      customerWechat: '',
      customerQq: '',
      customerSource: '',
      xianyuOrderNo: '',
      gameUid: '',
      gameRank: '',
      banRecord: '',
      specialRequirements: '',
      targetAssets: '',
    });

    const gameRankProxy = computed({
      get: () => formData.gameRank,
      set: (val) => {
        const clean = String(val || '').replace(/\D/g, '');
        if (clean !== String(val || '')) {
          formData.gameRank = String(val || '');
          nextTick(() => {
            formData.gameRank = clean;
          });
        } else {
          formData.gameRank = clean;
        }
      },
    });

    const targetAssetsProxy = computed({
      get: () => formData.targetAssets,
      set: (val) => {
        const clean = String(val || '').replace(/\D/g, '');
        if (clean !== String(val || '')) {
          formData.targetAssets = String(val || '');
          nextTick(() => {
            formData.targetAssets = clean;
          });
        } else {
          formData.targetAssets = clean;
        }
      },
    });

    const rules = {
      amount: [{ required: true, message: '请输入金额' }],
      gameName: [{ required: true, message: '请选择游戏需求' }],
      region: [{ required: true, message: '请选择区服' }],
      banRecord: [{ max: 100, message: '封号记录最多只能写100字' }],
      description: [{ max: 100, message: '订单备注最多只能写100字' }],
    };

    const filterStatus = ref((route.query.status as string) || '');
    const stats = reactive({
      pending: 0,
      processing: 0,
      completed: 0,
      closed: 0,
    });

    const fetchStats = async () => {
      try {
        const [pendingRes, processingRes, completedRes, closedRes] = await Promise.all([
          getOrderList({ page: 1, size: 1, status: 'PENDING' }),
          getOrderList({ page: 1, size: 1, status: 'PROCESSING' }),
          getOrderList({ page: 1, size: 1, status: 'COMPLETED' }),
          getOrderList({ page: 1, size: 1, status: 'CLOSED' }),
        ]);
        stats.pending = pendingRes.total;
        stats.processing = processingRes.total;
        stats.completed = completedRes.total;
        stats.closed = closedRes.total;
      } catch (e) {
        console.error('Failed to fetch stats', e);
      }
    };

    const updateRouterQuery = () => {
      router.replace({
        query: {
          ...route.query,
          status: filterStatus.value || undefined,
          page: pagination.current,
          pageSize: pagination.pageSize,
          keyword: searchKeyword.value || undefined,
        },
      });
    };

    const quickFilter = (status: string) => {
      if (filterStatus.value === status) {
        filterStatus.value = '';
      } else {
        filterStatus.value = status;
      }
      pagination.current = 1;
      updateRouterQuery();
      fetchData();
    };

    const fetchData = async () => {
      loading.value = true;
      try {
        const res = await getOrderList({
          page: pagination.current,
          size: pagination.pageSize,
          keyword: searchKeyword.value,
          status: filterStatus.value || undefined,
        });
        const sorted = [...res.list].sort((a, b) => {
          const aTime = a.updatedAt || a.createdAt ? new Date(a.updatedAt || a.createdAt || '').getTime() : 0;
          const bTime = b.updatedAt || b.createdAt ? new Date(b.updatedAt || b.createdAt || '').getTime() : 0;
          return bTime - aTime;
        });
        data.value = sorted;
        pagination.total = res.total;
        fetchStats();
      } catch (e) {
        console.error(e);
      } finally {
        loading.value = false;
      }
    };

    const onPageChange = (pageInfo: any) => {
      pagination.current = pageInfo.current;
      pagination.pageSize = pageInfo.pageSize;
      updateRouterQuery();
      fetchData();
    };

    const handleSearch = () => {
      pagination.current = 1;
      updateRouterQuery();
      fetchData();
    };

    const handleAdd = () => {
      isEdit.value = false;
      formTitle.value = '新建订单';
      currentId.value = '';
      currentGameMetaData.value = {};
      Object.assign(formData, {
        title: '',
        amount: 0,
        gameName: '跑刀',
        gameMode: '烽火地带',
        region: 'QQ区',
        accountUsername: '',
        accountPassword: '',
        description: '',
        customerName: '',
        customerPhone: '',
        customerWechat: '',
        customerQq: '',
        customerSource: '',
        xianyuOrderNo: '',
        gameUid: '',
        gameRank: '',
        banRecord: '',
        specialRequirements: '',
        targetAssets: '',
      });
      visible.value = true;
    };

    const handleEdit = (row: Order) => {
      isEdit.value = true;
      formTitle.value = '编辑订单';
      currentId.value = row.id;

      let targetAssets = '';
      if (row.gameMetaData) {
        try {
          const meta = JSON.parse(row.gameMetaData);
          currentGameMetaData.value = meta;
          targetAssets = meta.targetAssets || '';
        } catch (e) {
          console.error('Failed to parse gameMetaData', e);
          currentGameMetaData.value = {};
        }
      } else {
        currentGameMetaData.value = {};
      }

      Object.assign(formData, {
        title: row.title,
        amount: row.amount,
        gameName: row.gameName,
        region: row.region,
        accountUsername: row.accountUsername,
        accountPassword: row.accountPassword,
        description: row.description,
        customerName: row.customerName,
        customerPhone: row.customerPhone,
        customerWechat: row.customerWechat,
        customerQq: row.customerQq,
        customerSource: row.customerSource,
        xianyuOrderNo: row.xianyuOrderNo,
        gameUid: row.gameUid,
        gameRank: row.gameRank,
        banRecord: row.banRecord,
        specialRequirements: row.specialRequirements,
        targetAssets,
      });
      visible.value = true;
    };

    const handleDetail = (row: Order) => {
      router.push(`/order/detail/${row.id}`);
    };

    // --- Assign Logic ---
    const assignVisible = ref(false);
    const assignBoosterId = ref('');
    const boosterOptions = ref<{ label: string; value: string }[]>([]);
    const currentOrderForAssign = ref<Order | null>(null);

    const handleAssign = async (row: Order) => {
      currentOrderForAssign.value = row;
      assignBoosterId.value = row.boosterId || '';
      assignVisible.value = true;
      try {
        const res = await getBoosterList({ page: 1, pageSize: 100, status: 'Online' });
        boosterOptions.value = res.list.map((b: any) => ({
          label: `${b.name} (${b.rank})`,
          value: b.id,
        }));
      } catch (e) {
        console.error(e);
        MessagePlugin.error('获取打手列表失败');
      }
    };

    const handleAssignSubmit = async () => {
      if (!assignBoosterId.value) {
        MessagePlugin.warning('请选择打手');
        return;
      }
      if (!currentOrderForAssign.value) return;

      try {
        await assignOrder(currentOrderForAssign.value.id, assignBoosterId.value);
        MessagePlugin.success('分配成功');
        assignVisible.value = false;
        fetchData();
      } catch (e: any) {
        MessagePlugin.error(e.message || '分配失败');
      }
    };

    const handleDelete = async (row: Order) => {
      const confirmDia = DialogPlugin.confirm({
        header: '确认删除',
        body: '确定要删除该订单吗？删除后不可恢复。',
        onConfirm: async () => {
          try {
            await deleteOrder(row.id);
            MessagePlugin.success('删除成功');
            fetchData();
            confirmDia.hide();
          } catch {
            MessagePlugin.error('删除失败');
          }
        },
        onClose: () => {
          confirmDia.hide();
        },
      });
    };

    const onSubmit = async () => {
      const form = formRef.value as any;
      const validateResult = await form.validate();
      if (validateResult === true) {
        try {
          const meta = {
            ...currentGameMetaData.value,
            targetAssets: formData.targetAssets,
          };
          const payload = {
            ...formData,
            gameMetaData: JSON.stringify(meta),
          };

          if (isEdit.value) {
            await updateOrder(String(currentId.value), payload);
            MessagePlugin.success('更新成功');
          } else {
            await createOrder(payload);
            MessagePlugin.success('创建成功');
          }
          visible.value = false;
          fetchData();
        } catch (e) {
          console.error(e);
          MessagePlugin.error(isEdit.value ? '更新失败' : '创建失败');
        }
      }
    };

    const handleComplete = async (row: Order) => {
      if (!row.boosterId) {
        MessagePlugin.warning('请先分配打手，否则无法结单');
        return;
      }
      try {
        // Clear countdown first
        const payload: any = {
          region: row.region,
          gameName: row.gameName,
          amount: row.amount,
          title: row.title,
          gameMode: row.gameMode,
          accountUsername: row.accountUsername,
          deadlineTime: null,
          isPaused: false,
        };

        let meta = {};
        try {
          meta = JSON.parse(row.gameMetaData || '{}');
          if ((meta as any).pausedRemainingMs) {
            delete (meta as any).pausedRemainingMs;
            payload.gameMetaData = JSON.stringify(meta);
          }
        } catch {}

        await updateOrder(row.id, payload);

        await completeOrder(row.id);
        MessagePlugin.success('订单已完成，结算记录已生成');
        fetchData();
      } catch (e: any) {
        console.error(e);
        MessagePlugin.error(e.message || '操作失败');
      }
    };

    const getStatusText = (status: string) => {
      const map: Record<string, string> = {
        PENDING: '待接单',
        PROCESSING: '进行中',
        COMPLETED: '已完成',
        CANCELLED: '已取消',
        LOCKED: '已锁定',
        CLOSED: '补单中',
      };
      return map[status] || status;
    };

    const getStatusTheme = (status: string): 'success' | 'default' | 'primary' | 'warning' | 'danger' => {
      const map: Record<string, 'success' | 'default' | 'primary' | 'warning' | 'danger'> = {
        PENDING: 'default',
        PROCESSING: 'primary',
        COMPLETED: 'success',
        CANCELLED: 'warning',
        LOCKED: 'danger',
        CLOSED: 'warning',
      };
      return map[status] || 'default';
    };

    const handleCopy = (text: string) => {
      if (!text) return;
      navigator.clipboard
        .writeText(text)
        .then(() => {
          MessagePlugin.success('复制成功');
        })
        .catch(() => {
          MessagePlugin.error('复制失败');
        });
    };

    onMounted(() => {
      fetchData();
    });

    return {
      handleCopy,
      data,
      columns,
      rowKey,
      pagination,
      loading,
      searchKeyword,
      visible,
      formTitle,
      formData,
      rules,
      formRef,
      fetchData,
      onPageChange,
      handleAdd,
      handleEdit,
      handleDetail,
      handleDelete,
      handleSearch,
      handleAssign,
      handleAssignSubmit,
      assignVisible,
      assignBoosterId,
      boosterOptions,
      currentOrderForAssign,
      onSubmit,
      handleComplete,
      getStatusText,
      getStatusTheme,
      stats,
      quickFilter,
      gameRankProxy,
      targetAssetsProxy,
    };
  },
});
</script>
<style lang="less" scoped>
.order-page {
  .mb-4 {
    margin-bottom: 16px;
  }
}
.header-row {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 16px;
  margin-bottom: 16px;

  .sp-title {
    font-size: 20px;
    font-weight: bold;
  }
}
.mt-4 {
  margin-top: 16px;
}
.ml-2 {
  margin-left: 8px;
}
</style>
