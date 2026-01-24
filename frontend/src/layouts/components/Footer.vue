<template>
  <div :class="`${prefix}-footer`">
    Copyright © {{ startYear }}-{{ new Date().getFullYear() }} {{ company }}. All Rights Reserved
    <br v-if="icp" />
    <span v-if="icp">
      <a href="https://beian.miit.gov.cn/" target="_blank">{{ icp }}</a>
    </span>
  </div>
</template>
<script setup lang="ts">
import { computed } from 'vue';

import { prefix } from '@/config/global';
import { useSettingStore } from '@/store';

const setting = useSettingStore();
const company = computed(() => setting.footerCompany || 'Tencent');
const icp = computed(() => setting.footerIcp || '');
const startYear = computed(() => setting.copyrightStartYear || '2021');
</script>
<style lang="less" scoped>
.@{starter-prefix}-footer {
  color: var(--td-text-color-placeholder);
  line-height: 20px;
  text-align: center;

  a {
    color: var(--td-text-color-placeholder);
    text-decoration: none;
    cursor: auto;
  }
}
</style>
