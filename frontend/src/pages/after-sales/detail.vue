<template>
  <div class="after-sales-detail">
    <t-row :gutter="24">
      <!-- Left: Evidence Wall -->
      <t-col :span="8">
        <t-card title="证据墙" :bordered="false" class="evidence-card">
          <t-list :split="true">
            <t-list-item>
              <t-list-item-meta title="1. 上号前截图 (系统存档)" description="接单时上传的初始状态" />
              <template #action>
                <t-image-viewer :images="[order.gameMetaData?.startImage || '']">
                  <template #trigger="{ open }">
                    <t-image :src="order.gameMetaData?.startImage" class="evidence-img" @click="open" />
                  </template>
                </t-image-viewer>
              </template>
            </t-list-item>
            <t-list-item>
              <t-list-item-meta title="2. 完单截图 (系统存档)" description="打手提交的完成状态" />
              <template #action>
                <t-image-viewer :images="proofImages">
                  <template #trigger="{ open }">
                    <t-image :src="proofImages[0]" class="evidence-img" @click="open" />
                  </template>
                </t-image-viewer>
              </template>
            </t-list-item>
            <t-list-item>
              <t-list-item-meta title="3. 售后举证 (本次提交)" :description="afterSales.description" />
              <template #action>
                <div class="evidence-gallery">
                  <t-image-viewer :images="evidenceImgs">
                    <template #trigger="{ open }">
                      <t-image
                        v-for="(img, index) in evidenceImgs"
                        :key="index"
                        :src="img"
                        class="evidence-img small"
                        @click="open"
                      />
                    </template>
                  </t-image-viewer>
                </div>
              </template>
            </t-list-item>
          </t-list>
        </t-card>
      </t-col>

      <!-- Right: Verdict Calculator -->
      <t-col :span="4">
        <t-card title="判决计算器" :bordered="false">
          <t-form :data="verdictData" label-align="top" @submit="onResolve">
            <t-form-item label="订单总额">
              <t-input :value="order.amount" readonly suffix="元" />
            </t-form-item>

            <t-divider />

            <t-form-item label="退还客户" name="refundAmount">
              <t-input-number
                v-model="verdictData.refundAmount"
                :max="order.amount"
                theme="normal"
                suffix="元"
                @change="recalc"
              />
            </t-form-item>

            <t-form-item>
              <t-space direction="vertical" style="width: 100%">
                <t-button theme="warning" variant="outline" block @click="handleChangeBooster"> 更换打手 </t-button>
                <div v-if="currentBooster" class="booster-info">
                  当前: {{ currentBooster.name }}
                  <span v-if="currentBooster.nickname" class="text-secondary">({{ currentBooster.nickname }})</span>
                </div>
              </t-space>
            </t-form-item>

            <t-form-item label="管理员判决词" name="adminRemark">
              <t-textarea v-model="verdictData.adminRemark" placeholder="请输入判决理由..." />
            </t-form-item>

            <t-form-item>
              <t-button
                theme="danger"
                block
                size="large"
                :disabled="afterSales.status === 'RESOLVED'"
                @click="handleConfirm"
              >
                {{ afterSales.status === 'RESOLVED' ? '已判决' : '判决生效' }}
              </t-button>
            </t-form-item>
          </t-form>
        </t-card>
      </t-col>
    </t-row>

    <!-- Assign Dialog -->
    <t-dialog v-model:visible="assignVisible" title="更换打手" width="400px" @confirm="handleAssignSubmit">
      <t-space direction="vertical" style="width: 100%">
        <p class="text-secondary">这将把订单重新分配给新打手，当前打手将被移除。</p>
        <t-select v-model="assignBoosterId" :options="boosterOptions" placeholder="请选择新打手" filterable clearable />
      </t-space>
    </t-dialog>
  </div>
</template>
<script lang="ts" setup>
import { MessagePlugin } from 'tdesign-vue-next';
import { computed, onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';

import { getAfterSalesDetail, resolveAfterSales } from '@/api/after-sales';
import { getBoosterDetail, getBoosterList } from '@/api/booster';
import { assignOrder, getOrder } from '@/api/order';

const route = useRoute();
const order = ref<any>({});
const afterSales = ref<any>({});
const currentBooster = ref<any>(null);
const verdictData = ref({
  afterSalesId: 0,
  refundAmount: 0,
  boosterIncome: 0,
  penaltyAmount: 0,
  adminRemark: '',
});

const proofImages = computed(() => {
  try {
    return JSON.parse(order.value.proofImages || '[]');
  } catch {
    return [];
  }
});

const evidenceImgs = computed(() => {
  try {
    return JSON.parse(afterSales.value.evidenceImgs || '[]');
  } catch {
    return [];
  }
});

onMounted(async () => {
  const { orderId } = route.query;
  if (orderId) {
    try {
      const orderRes = await getOrder(Number(orderId));
      order.value = orderRes;
      if (orderRes.boosterId) {
        try {
          currentBooster.value = await getBoosterDetail(orderRes.boosterId);
        } catch {
          console.error('Failed to load booster detail');
        }
      }

      const asRes = await getAfterSalesDetail(Number(orderId));
      afterSales.value = asRes;
      verdictData.value.afterSalesId = asRes.id;

      // Init calculator with defaults if pending
      if (asRes.status === 'PENDING') {
        verdictData.value.refundAmount = 0;
        // verdictData.value.boosterIncome = 0;
      } else {
        verdictData.value.refundAmount = asRes.refundAmount;
        // verdictData.value.boosterIncome = asRes.boosterIncome;
        verdictData.value.adminRemark = asRes.adminRemark;
      }
    } catch (error) {
      console.error(error);
      MessagePlugin.error('加载数据失败');
    }
  }
});

const recalc = () => {
  // Optional: Add logic to auto-balance or warn
};

const handleConfirm = async () => {
  try {
    await resolveAfterSales(verdictData.value);
    MessagePlugin.success('判决已生效');
    // Refresh
    const asRes = await getAfterSalesDetail(Number(order.value.id));
    afterSales.value = asRes;
  } catch {
    MessagePlugin.error('判决执行失败');
  }
};

const onResolve = async () => {
  await handleConfirm();
};

const assignVisible = ref(false);
const assignBoosterId = ref('');
const boosterOptions = ref<{ label: string; value: string }[]>([]);

const handleChangeBooster = async () => {
  assignBoosterId.value = '';
  assignVisible.value = true;
  try {
    const res = await getBoosterList({ page: 1, pageSize: 100, status: 'Online' });
    boosterOptions.value = res.list.map((b: any) => ({
      label: `${b.name} (${b.rank})`,
      value: b.id,
    }));
  } catch {
    MessagePlugin.error('获取打手列表失败');
  }
};

const handleAssignSubmit = async () => {
  if (!assignBoosterId.value) {
    MessagePlugin.warning('请选择打手');
    return;
  }

  try {
    await assignOrder(String(order.value.id), assignBoosterId.value);
    MessagePlugin.success('更换成功');
    assignVisible.value = false;
    // Refresh order info
    const orderRes = await getOrder(Number(route.query.orderId));
    order.value = orderRes;
    if (orderRes.boosterId) {
      try {
        currentBooster.value = await getBoosterDetail(orderRes.boosterId);
      } catch {}
    } else {
      currentBooster.value = null;
    }
  } catch (e: any) {
    MessagePlugin.error(e.message || '更换失败');
  }
};
</script>
<style scoped>
.after-sales-detail {
  padding: 24px;
}
.evidence-img {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 4px;
  cursor: pointer;
  border: 1px solid #eee;
  margin-right: 8px;
}
.evidence-gallery {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}
.tip {
  font-size: 12px;
  color: #999;
  margin-left: 8px;
}
.booster-info {
  font-size: 16px;
  font-weight: bold;
  color: #333;
  text-align: center;
  margin-top: 8px;
}
.text-secondary {
  color: #333;
  font-weight: bold;
  font-size: 16px;
  margin-left: 4px;
}
</style>
