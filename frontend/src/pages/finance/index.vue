<template>
  <div class="finance-page">
    <div class="card-container">
      <t-card :bordered="false" hover-shadow class="finance-card">
        <div class="card-title">
          本月收入
          <span class="date-range">{{ currentMonthRange }}</span>
        </div>
        <div class="card-content">
          <span class="amount">¥0.00</span>
        </div>
      </t-card>
      <t-card :bordered="false" hover-shadow class="finance-card">
        <div class="card-title">总收入</div>
        <div class="card-content">
          <span class="amount">{{ formatAmount(totalIncome) }}</span>
        </div>
      </t-card>
      <t-card :bordered="false" hover-shadow class="finance-card">
        <div class="card-title">退款</div>
        <div class="card-content">
          <span class="amount">{{ formatAmount(refundTotal) }}</span>
        </div>
      </t-card>
    </div>
  </div>
</template>
<script setup lang="ts">
import dayjs from 'dayjs';
import { computed, onMounted, ref } from 'vue';

import { getAfterSalesList } from '@/api/after-sales';
import { getOrderSummary } from '@/api/order';

const totalIncome = ref(0);
const refundTotal = ref(0);

const currentMonthRange = computed(() => {
  const start = dayjs().startOf('month').format('YYYY-MM-DD');
  const end = dayjs().endOf('month').format('YYYY-MM-DD');
  return `(${start} ~ ${end})`;
});

const formatAmount = (value: number) => `¥${value.toFixed(2)}`;

const fetchSummary = async () => {
  const res = await getOrderSummary();
  totalIncome.value = Number(res.totalIncome ?? 0);
  try {
    const list = await getAfterSalesList();
    refundTotal.value = list.reduce((sum: number, item: { refundAmount?: number }) => {
      return sum + Number(item.refundAmount ?? 0);
    }, 0);
  } catch {
    refundTotal.value = Number(res.refundTotal ?? 0);
  }
};

onMounted(() => {
  fetchSummary();
});
</script>
<style lang="less" scoped>
.finance-page {
}

.card-container {
  display: flex;
  gap: 16px;
  width: 100%;
}

.finance-card {
  flex: 1;
  height: 60vh;
  position: relative;

  :deep(.t-card__body) {
    height: 100%;
    display: flex;
    flex-direction: column;
    padding: 24px;
    box-sizing: border-box;
  }
}

.card-title {
  font-size: 16px;
  font-weight: bold;
  color: var(--td-text-color-primary);
  margin-bottom: auto;

  .date-range {
    font-size: 12px;
    font-weight: normal;
    color: var(--td-text-color-secondary);
    margin-left: 8px;
  }
}

.card-content {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;

  .amount {
    font-size: 48px;
    color: var(--td-text-color-primary);
    line-height: 1;
  }
}
</style>
