<template>
  <div class="login-wrapper">
    <login-header />

    <div class="login-left-container">
      <div class="title-container">
        <h1 class="title margin-no">{{ t('pages.login.loginTitle') }}</h1>
        <h1 class="title">{{ settingStore.websiteName }}</h1>
        <div v-if="type === 'register'" class="sub-title">
          <p class="tip">{{ t('pages.login.existAccount') }}</p>
          <p class="tip" @click="switchType('login')">
            {{ t('pages.login.signIn') }}
          </p>
        </div>
        <div v-else-if="type === 'forgot'" class="sub-title">
          <p class="tip">想起密码了?</p>
          <p class="tip" @click="switchType('login')">返回登录</p>
        </div>
      </div>

      <login v-if="type === 'login'" @register="switchType('register')" @forgot="switchType('forgot')" />
      <register v-else-if="type === 'register'" @register-success="switchType('login')" />
      <forgot-password v-else @back="switchType('login')" @reset-success="switchType('login')" />
      <tdesign-setting />
      <footer class="copyright">
        <div>Copyright © {{ copyrightDate }} {{ settingStore.footerCompany }}. All Rights Reserved</div>
        <div v-if="settingStore.footerIcp">
          <a href="https://beian.miit.gov.cn/" target="_blank">{{ settingStore.footerIcp }}</a>
        </div>
      </footer>
    </div>

    <div class="login-right-container">
      <div class="login-bg-image" :style="bgStyle"></div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { DialogPlugin } from 'tdesign-vue-next';
import { computed, onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

import TdesignSetting from '@/layouts/setting.vue';
import { t } from '@/locales';
import { useSettingStore } from '@/store';

import ForgotPassword from './components/ForgotPassword.vue';
import LoginHeader from './components/Header.vue';
import Login from './components/Login.vue';
import Register from './components/Register.vue';

defineOptions({
  name: 'LoginIndex',
});
const route = useRoute();
const router = useRouter();
const type = computed(() => {
  if (route.path === '/register') return 'register';
  if (route.path === '/forgot') return 'forgot';
  return 'login';
});
const settingStore = useSettingStore();
const maintenanceDialogShown = ref(false);

onMounted(async () => {
  await settingStore.loadUiSetting();
  if (settingStore.maintenanceEnabled && !maintenanceDialogShown.value) {
    maintenanceDialogShown.value = true;
    const message = settingStore.maintenanceMessage?.trim() || '系统正在维护中，具体恢复时间请关注通知。';
    DialogPlugin.alert({
      header: '维护提示',
      body: message,
      confirmBtn: '我知道了',
    });
  }
});

const switchType = (val: 'login' | 'register' | 'forgot') => {
  const target = val === 'register' ? '/register' : val === 'forgot' ? '/forgot' : '/login';
  if (route.path !== target) {
    router.push({ path: target, query: route.query });
  }
};

const bgStyle = computed(() => {
  if (settingStore.loginBgUrl) {
    return {
      backgroundImage: `url(${settingStore.loginBgUrl})`,
      backgroundSize: 'cover',
      backgroundPosition: 'center',
    };
  }
  return {
    backgroundImage: 'url(https://tdesign.gtimg.com/site/source/login-bg.png)',
    backgroundSize: 'cover',
    backgroundPosition: 'center',
  };
});

const copyrightDate = computed(() => {
  const startYear = settingStore.copyrightStartYear || new Date().getFullYear();
  const currentYear = new Date().getFullYear();
  if (Number(startYear) === currentYear) {
    return `${currentYear}`;
  }
  return `${startYear}-${currentYear}`;
});
</script>
<style lang="less" scoped>
@import './index.less';
</style>
