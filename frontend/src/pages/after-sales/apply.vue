<template>
  <div class="after-sales-apply">
    <t-card title="申请售后" :bordered="false">
      <t-form :data="formData" :rules="rules" @submit="onSubmit">
        <t-form-item label="关联订单" name="orderId">
          <div style="display: flex; align-items: center; width: 100%">
            <div style="display: flex; gap: 16px; width: 50%">
              <t-input
                v-model="orderNo"
                :readonly="!!route.query.orderId"
                :disabled="!!route.query.orderId"
                placeholder="请输入订单编号"
                style="flex: 1"
                @blur="onOrderNoBlur"
              />
              <t-button v-if="!route.query.orderId" theme="primary" style="width: 120px" @click="onOrderNoBlur">
                <template #icon><t-icon name="search" /></template>
                验证
              </t-button>
            </div>
            <div v-if="orderInfo" class="order-info-preview">
              {{ orderInfo.title }} (金额: {{ orderInfo.amount }}元)
            </div>
          </div>
        </t-form-item>

        <t-form-item label="投诉类型" name="reasonType">
          <t-select v-model="formData.reasonType" placeholder="请选择投诉原因">
            <t-option label="卡保底" value="GUARANTEE_STUCK" />
            <t-option label="超时" value="TIMEOUT" />
            <t-option label="态度恶劣" value="ATTITUDE" />
            <t-option label="账号封禁" value="BAN" />
            <t-option label="追缴" value="RECOVERY" />
            <t-option label="仓库物资丢失" value="LOSS" />
          </t-select>
        </t-form-item>

        <t-form-item label="详细描述" name="description">
          <t-textarea
            v-model="formData.description"
            placeholder="请详细描述发生的问题，以便管理员快速处理"
            :autosize="{ minRows: 3, maxRows: 6 }"
          />
        </t-form-item>

        <t-form-item label="举证图片" name="evidenceImgs">
          <t-upload
            v-model="formData.evidenceImgs"
            class="upload-grid-5"
            action="/api/system/file/upload?page=after-sales"
            name="file"
            :headers="uploadHeaders"
            :format-response="formatUploadResponse"
            theme="image"
            accept="image/*"
            multiple
            :max="6"
            @fail="handleUploadFail"
          />
          <div class="t-upload__tips">请上传相关截图证据，最多6张</div>
        </t-form-item>

        <t-form-item>
          <t-button theme="primary" type="submit">提交申请</t-button>
          <t-button theme="default" variant="base" @click="$router.back()">取消</t-button>
        </t-form-item>
      </t-form>
    </t-card>
  </div>
</template>
<script lang="ts" setup>
import type { FormRules } from 'tdesign-vue-next';
import { MessagePlugin } from 'tdesign-vue-next';
import { computed, onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

import { applyAfterSales } from '@/api/after-sales';
import { getOrder, getOrderByNo } from '@/api/order';
import { useUserStore } from '@/store';

const route = useRoute();
const router = useRouter();
const userStore = useUserStore();

const uploadHeaders = computed(() => ({
  Authorization: userStore.token, // SaToken might accept raw token or handle Bearer internally. Keeping it as is since logs showed success.
}));

const formatUploadResponse = (res: any) => {
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

const handleUploadFail = ({ file }: any) => {
  MessagePlugin.error(`文件 ${file.name} 上传失败`);
  const index = formData.value.evidenceImgs.findIndex((item: any) => item.uid === file.uid);
  if (index > -1) {
    formData.value.evidenceImgs.splice(index, 1);
  }
};

interface AfterSalesForm {
  orderId: number;
  reasonType: string;
  description: string;
  evidenceImgs: any[];
}

const orderNo = ref('');
const orderInfo = ref<any>(null);
const formData = ref<AfterSalesForm>({
  orderId: 0,
  reasonType: '',
  description: '',
  evidenceImgs: [],
});

const rules: FormRules<AfterSalesForm> = {
  orderId: [{ required: true, message: '请关联有效订单', type: 'error', trigger: 'change' as const }],
  reasonType: [{ required: true, message: '请选择投诉类型' }],
  description: [{ required: true, message: '请填写详细描述' }],
  evidenceImgs: [{ required: true, message: '请上传至少一张证据图片' }],
};

onMounted(async () => {
  const { orderId } = route.query;
  if (orderId) {
    formData.value.orderId = Number(orderId);
    try {
      const res = await getOrder(Number(orderId));
      orderNo.value = res.orderNo;
      orderInfo.value = res;
    } catch (e) {
      console.error(e);
      MessagePlugin.error('加载订单信息失败');
    }
  }
});

const onOrderNoBlur = async () => {
  if (!orderNo.value) return;
  try {
    const res = await getOrderByNo(orderNo.value);
    if (res) {
      formData.value.orderId = Number(res.id); // Ensure ID is set
      orderInfo.value = res;
      MessagePlugin.success('订单关联成功');
    } else {
      MessagePlugin.error('未找到该订单');
      formData.value.orderId = 0;
      orderInfo.value = null;
    }
  } catch (e) {
    console.error(e);
    MessagePlugin.error('查询订单失败');
  }
};

const onSubmit = async ({ validateResult, firstError }: any) => {
  if (validateResult === true) {
    try {
      // Extract URLs from upload component
      const evidenceUrls = formData.value.evidenceImgs
        .map((file: any) => file.url || file.response?.url)
        .filter(Boolean);

      await applyAfterSales({
        ...formData.value,
        evidenceImgs: evidenceUrls,
      });
      MessagePlugin.success('售后申请已提交，资金已冻结');
      router.push(`/after-sales/detail?orderId=${formData.value.orderId}`);
    } catch {
      MessagePlugin.error('提交失败');
    }
  } else {
    MessagePlugin.warning(firstError);
  }
};
</script>
<style scoped>
.after-sales-apply {
  padding: 24px;
}
.order-info-preview {
  margin-left: 16px;
  padding: 8px 12px;
  border: 1px solid var(--td-component-border);
  border-radius: var(--td-radius-default);
  background-color: var(--td-bg-color-container);
  color: var(--td-text-color-primary);
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
</style>
