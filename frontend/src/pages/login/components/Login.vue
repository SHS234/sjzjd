<template>
  <t-form
    ref="form"
    class="item-container"
    :class="[`login-${type}`]"
    :data="formData"
    :rules="formRules"
    :show-error-message="false"
    label-width="0"
    @submit="onSubmit"
  >
    <t-tabs v-model="type" class="login-tabs">
      <t-tab-panel
        v-if="settingStore.smsEnabled"
        value="phone"
        :label="t('pages.login.phoneLogin')"
        :destroy-on-hide="false"
      />
      <t-tab-panel
        v-if="settingStore.emailEnabled"
        value="email"
        :label="t('pages.login.emailLogin')"
        :destroy-on-hide="false"
      />
      <t-tab-panel value="password" :label="t('pages.login.accountLogin')" :destroy-on-hide="false" />
    </t-tabs>
    <template v-if="type === 'password'">
      <t-form-item name="account">
        <t-input v-model="formData.account" size="large" :placeholder="t('pages.login.input.account')">
          <template #prefix-icon>
            <t-icon name="user" />
          </template>
        </t-input>
      </t-form-item>

      <t-form-item name="password">
        <t-input
          v-model="formData.password"
          size="large"
          :type="showPsw ? 'text' : 'password'"
          clearable
          :placeholder="`${t('pages.login.input.password')}：123456`"
        >
          <template #prefix-icon>
            <t-icon name="lock-on" />
          </template>
          <template #suffix-icon>
            <t-icon :name="showPsw ? 'browse' : 'browse-off'" @click="showPsw = !showPsw" />
          </template>
        </t-input>
      </t-form-item>
    </template>

    <!-- 手机号登录 -->
    <template v-if="type === 'phone'">
      <t-form-item name="phone">
        <t-input v-model="formData.phone" size="large" :placeholder="t('pages.login.input.phone')">
          <template #prefix-icon>
            <t-icon name="mobile" />
          </template>
        </t-input>
      </t-form-item>

      <t-form-item class="verification-code" name="verifyCode">
        <t-input v-model="formData.verifyCode" size="large" :placeholder="t('pages.login.input.verification')" />
        <t-button size="large" variant="outline" :disabled="countDown > 0" @click="sendCode">
          {{ countDown === 0 ? t('pages.login.sendVerification') : `${countDown}秒后可重发` }}
        </t-button>
      </t-form-item>
    </template>

    <!-- 邮箱登录 -->
    <template v-if="type === 'email'">
      <t-form-item name="email">
        <t-input v-model="formData.email" size="large" :placeholder="t('pages.login.input.email')">
          <template #prefix-icon>
            <t-icon name="mail" />
          </template>
        </t-input>
      </t-form-item>

      <t-form-item class="verification-code" name="verifyCode">
        <t-input v-model="formData.verifyCode" size="large" :placeholder="t('pages.login.input.verification')" />
        <t-button size="large" variant="outline" :disabled="countDown > 0" @click="sendCode">
          {{ countDown === 0 ? t('pages.login.sendVerification') : t('pages.login.resendAfter', [countDown]) }}
        </t-button>
      </t-form-item>
    </template>

    <!-- Protocol -->
    <t-form-item class="check-container" name="agreed">
      <agreement-check v-model="formData.agreed" />
    </t-form-item>

    <!-- Remember Account -->
    <t-form-item v-if="type === 'password'" class="check-container" name="checked">
      <t-checkbox v-model="formData.checked">{{ t('pages.login.remember') }}</t-checkbox>
    </t-form-item>

    <t-form-item class="btn-container">
      <t-button block size="large" type="submit"> {{ t('pages.login.signIn') }} </t-button>
    </t-form-item>

    <div class="switch-container">
      <span class="tip" @click="emit('register')">{{ t('pages.login.createAccount') }}</span>
      <span class="tip" @click="emit('forgot')">{{ t('pages.login.forget') }}</span>
    </div>
  </t-form>
</template>
<script setup lang="ts">
import type { FormInstanceFunctions, FormRule, SubmitContext } from 'tdesign-vue-next';
import { DialogPlugin, MessagePlugin } from 'tdesign-vue-next';
import { computed, onActivated, onBeforeUnmount, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';

import { useCounter } from '@/hooks';
import { t } from '@/locales';
import { useSettingStore, useUserStore } from '@/store';
import { request } from '@/utils/request';
import { buildSseUrl } from '@/utils/sse';
import { setTokenExpireTimer } from '@/utils/tokenExpire';

import AgreementCheck from './AgreementCheck.vue';

const emit = defineEmits(['register', 'forgot']);
const userStore = useUserStore();
const settingStore = useSettingStore();
const INITIAL_DATA = {
  phone: '',
  email: '',
  account: 'admin',
  password: '123456',
  verifyCode: '',
  checked: false,
  agreed: false,
};

const FORM_RULES: Record<string, FormRule[]> = {
  phone: [{ required: true, message: t('pages.login.required.phone'), type: 'error' as const }],
  email: [
    { required: true, message: t('pages.login.required.email'), type: 'error' as const },
    { email: true, message: t('pages.login.invalid.email'), type: 'error' as const },
  ],
  account: [
    { required: true, message: t('pages.login.required.account'), type: 'error' as const },
    { validator: (val) => /^[\w@.-]+$/.test(val), message: t('pages.login.input.account'), type: 'error' as const },
  ],
  password: [{ required: true, message: t('pages.login.required.password'), type: 'error' as const }],
  verifyCode: [{ required: true, message: t('pages.login.required.verification'), type: 'error' as const }],
  agreed: [{ validator: (val) => Boolean(val), message: t('pages.login.agreeTerms'), type: 'error' as const }],
};

const type = ref('password');

const form = ref<FormInstanceFunctions>();
const formData = ref({ ...INITIAL_DATA });
const showPsw = ref(false);

const [countDown, handleCounter] = useCounter();

const resolveLoginType = () => {
  if (type.value === 'phone' && !settingStore.smsEnabled) return;
  if (type.value === 'email' && !settingStore.emailEnabled) return;
  return type.value;
};

const getDefaultLoginType = () => {
  if (settingStore.smsEnabled) return 'phone';
  if (settingStore.emailEnabled) return 'email';
  return 'password';
};

const syncLoginType = () => {
  if (!resolveLoginType()) {
    type.value = getDefaultLoginType();
  }
};

watch(
  () => [settingStore.smsEnabled, settingStore.emailEnabled],
  () => {
    syncLoginType();
  },
  { immediate: true },
);

const router = useRouter();
const route = useRoute();

const resolveLoginRedirect = (redirect?: string) => {
  const fallbackHome = settingStore.defaultHome || '/user/index';
  if (!redirect) return fallbackHome;
  const decoded = decodeURIComponent(redirect);
  if ((decoded === '/' || decoded === '/user/index') && fallbackHome !== '/user/index') {
    return fallbackHome;
  }
  return decoded;
};

/**
 * 发送验证码
 */
const sendCode = async () => {
  const isPhone = type.value === 'phone';
  const isEmail = type.value === 'email';
  if (!isPhone && !isEmail) return;

  const field = isPhone ? 'phone' : 'email';
  const res = await form.value.validate({ fields: [field] });
  if (res !== true) {
    MessagePlugin.error(isPhone ? t('pages.login.invalid.phone') : t('pages.login.invalid.email'));
    return;
  }
  try {
    if (isPhone) {
      await request.post({ url: '/auth/sms/send', data: { phone: formData.value.phone } }, { withToken: false });
    } else {
      await request.post({ url: '/auth/email/send', data: { email: formData.value.email } }, { withToken: false });
    }
    MessagePlugin.success(t('pages.login.verificationSent'));
    handleCounter();
  } catch (err: any) {
    MessagePlugin.error(String(err?.message || t('pages.login.sendingFailed')));
  }
};

const formRules = computed(() => ({
  ...FORM_RULES,
}));

onMounted(() => {
  const savedAccount = localStorage.getItem('remember_account');
  if (savedAccount) {
    formData.value.account = savedAccount;
    formData.value.checked = true;
  }
});
onActivated(() => {});
onBeforeUnmount(() => {
  closePending();
});

let pendingDialog: ReturnType<typeof DialogPlugin.confirm> | null = null;
let pendingSource: EventSource | null = null;

const closePending = () => {
  if (pendingSource) {
    pendingSource.close();
    pendingSource = null;
  }
  if (pendingDialog) {
    pendingDialog.hide();
    pendingDialog = null;
  }
};

const waitForDecision = (requestId: string, requestKey: string) => {
  closePending();
  pendingDialog = DialogPlugin.confirm({
    header: t('pages.login.waitingConfirmation'),
    body: t('pages.login.waitingConfirmationBody'),
    confirmBtn: t('pages.login.cancelWaiting'),
    cancelBtn: null,
    closeOnOverlayClick: false,
    closeOnEscKeydown: false,
    onConfirm: () => {
      closePending();
    },
    onClose: () => {
      closePending();
    },
  });

  pendingSource = new EventSource(buildSseUrl('/auth/login/pending/stream', { requestId, requestKey }));
  pendingSource.addEventListener('decision', async (event: MessageEvent) => {
    let status = '';
    try {
      const data = JSON.parse(event.data || '{}');
      status = data?.status || '';
    } catch {}

    if (status === 'approved') {
      closePending();
      try {
        const confirmRes = await userStore.confirmLogin(requestId, requestKey);
        if (confirmRes?.status === 'ok') {
          // 设置 token 过期定时器
          if (confirmRes.token && confirmRes.expiresIn) {
            setTokenExpireTimer(confirmRes.token, confirmRes.expiresIn);
          }
          await settingStore.loadUiSetting();
          MessagePlugin.success(t('pages.login.loginSuccess'));
          const redirectUrl = resolveLoginRedirect(route.query.redirect as string);
          router.push(redirectUrl);
          return;
        }
        throw new Error(t('pages.login.loginFailed'));
      } catch (err: any) {
        MessagePlugin.error(String(err?.message || t('pages.login.loginFailed')));
      }
      return;
    }

    if (status === 'rejected') {
      closePending();
      MessagePlugin.warning(t('pages.login.loginRejected'));
    }
  });

  pendingSource.onerror = () => {
    MessagePlugin.error(t('pages.login.waitingFailed'));
    closePending();
  };
};

const onSubmit = async (ctx: SubmitContext) => {
  if (ctx.validateResult !== true) {
    MessagePlugin.error(ctx.firstError || '请完善登录信息');
    return;
  }
  try {
    if (type.value === 'phone') {
      const res = await userStore.loginBySms({ phone: formData.value.phone, code: formData.value.verifyCode });
      if (res?.status === 'ok') {
        // 设置 token 过期定时器
        if (res.token && res.expiresIn) {
          setTokenExpireTimer(res.token, res.expiresIn);
        }
        await settingStore.loadUiSetting();
        MessagePlugin.success(t('pages.login.loginSuccess'));
        const redirectUrl = resolveLoginRedirect(route.query.redirect as string);
        router.push(redirectUrl);
        return;
      }
      if (res?.status === 'pending' && res.requestId && res.requestKey) {
        waitForDecision(res.requestId, res.requestKey);
        return;
      }
      throw new Error(t('pages.login.loginFailed'));
    }

    if (type.value === 'email') {
      const res = await userStore.loginByEmail({ email: formData.value.email, code: formData.value.verifyCode });
      if (res?.status === 'ok') {
        // 设置 token 过期定时器
        if (res.token && res.expiresIn) {
          setTokenExpireTimer(res.token, res.expiresIn);
        }
        await settingStore.loadUiSetting();
        MessagePlugin.success(t('pages.login.loginSuccess'));
        const redirectUrl = resolveLoginRedirect(route.query.redirect as string);
        router.push(redirectUrl);
        return;
      }
      if (res?.status === 'pending' && res.requestId && res.requestKey) {
        waitForDecision(res.requestId, res.requestKey);
        return;
      }
      throw new Error(t('pages.login.loginFailed'));
    }

    const payload = { ...formData.value };
    const res = await userStore.login(payload);
    if (res?.status === 'ok') {
      // 设置 token 过期定时器
      if (res.token && res.expiresIn) {
        setTokenExpireTimer(res.token, res.expiresIn);
      }
      await settingStore.loadUiSetting();
      MessagePlugin.success(t('pages.login.loginSuccess'));
      if (formData.value.checked) {
        localStorage.setItem('remember_account', formData.value.account);
      } else {
        localStorage.removeItem('remember_account');
      }
      const redirectUrl = resolveLoginRedirect(route.query.redirect as string);
      router.push(redirectUrl);
      return;
    }
    if (res?.status === 'pending' && res.requestId && res.requestKey) {
      waitForDecision(res.requestId, res.requestKey);
      return;
    }
    throw new Error(t('pages.login.loginFailed'));
  } catch (e: any) {
    MessagePlugin.error(String(e?.message || t('pages.login.loginFailed')));
  }
};
</script>
<style lang="less" scoped>
@import '../index.less';

.login-tabs {
  margin-bottom: 12px;
}
</style>
