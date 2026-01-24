<template>
  <div class="after-sales-list">
    <t-card title="售后申请列表" :bordered="false">
      <t-table :data="data" :columns="columns" row-key="id" :pagination="pagination" @page-change="onPageChange">
        <template #boosterName="{ row }">
          {{ formatBoosterLabel(row) }}
        </template>
        <template #reasonType="{ row }">
          {{ reasonTypeMap[row.reasonType] || row.reasonType }}
        </template>
        <template #status="{ row }">
          <t-tag v-if="row.status === 'PENDING'" theme="warning">待处理</t-tag>
          <t-tag v-if="row.status === 'RESOLVED'" theme="success">已判决</t-tag>
          <t-tag v-if="row.status === 'CLOSED'" theme="default">已关闭</t-tag>
        </template>
        <template #op="{ row }">
          <t-space>
            <t-button theme="primary" size="small" @click="$router.push(`/after-sales/detail?orderId=${row.orderId}`)">
              查看详情
            </t-button>
            <t-popconfirm content="确认删除该申请吗？" @confirm="handleDelete(row)">
              <t-button theme="danger" size="small">删除</t-button>
            </t-popconfirm>
          </t-space>
        </template>
      </t-table>
    </t-card>
  </div>
</template>
<script lang="ts" setup>
import type { PrimaryTableCol, TableRowData } from 'tdesign-vue-next';
import { MessagePlugin } from 'tdesign-vue-next';
import { onMounted, ref } from 'vue';

import { deleteAfterSales, getAfterSalesList } from '@/api/after-sales';
import { getBoosterDetail } from '@/api/booster';
import { getOrder } from '@/api/order';

const data = ref([]);
const pagination = ref({
  current: 1,
  pageSize: 10,
  total: 0,
});

const reasonTypeMap: Record<string, string> = {
  GUARANTEE_STUCK: '卡保底',
  TIMEOUT: '超时',
  ATTITUDE: '态度恶劣',
  BAN: '账号封禁',
  RECOVERY: '追缴',
  LOSS: '仓库物资丢失',
  EFFICIENCY: '效率问题',
};

const columns: PrimaryTableCol<TableRowData>[] = [
  { colKey: 'id', title: 'ID', width: 80 },
  { colKey: 'orderId', title: '订单ID' },
  { colKey: 'boosterName', title: '打手姓名', cell: 'boosterName' },
  { colKey: 'reasonType', title: '投诉类型', cell: 'reasonType' },
  { colKey: 'status', title: '状态', cell: 'status' },
  { colKey: 'createdAt', title: '申请时间' },
  { colKey: 'op', title: '操作', cell: 'op', fixed: 'right' },
];

const fetchData = async () => {
  try {
    const res = await getAfterSalesList();
    const list = Array.isArray(res) ? res : [];
    const updated = await Promise.all(
      list.map(async (item: any) => {
        if (item.boosterName && item.boosterNickname) return item;
        try {
          const orderRes = await getOrder(item.orderId);
          if (!orderRes?.boosterId) return item;
          const booster = await getBoosterDetail(orderRes.boosterId);
          return {
            ...item,
            boosterName: booster?.name || item.boosterName,
            boosterNickname: booster?.nickname || item.boosterNickname,
          };
        } catch {
          return item;
        }
      }),
    );
    data.value = updated;
  } catch (e) {
    console.error(e);
  }
};

const onPageChange = (pageInfo: any) => {
  pagination.value.current = pageInfo.current;
  pagination.value.pageSize = pageInfo.pageSize;
  fetchData();
};

const handleDelete = async (row: any) => {
  await deleteAfterSales(row.id);
  MessagePlugin.success('删除成功');
  fetchData();
};

onMounted(() => {
  fetchData();
});

const formatBoosterLabel = (row: any) => {
  if (row.boosterName && row.boosterNickname) {
    return `${row.boosterName}（${row.boosterNickname}）`;
  }
  return row.boosterName || '';
};
</script>
