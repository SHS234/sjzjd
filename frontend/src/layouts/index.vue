<template>
  <div>
    <template v-if="setting.layout.value === 'side'">
      <t-layout key="side" :class="mainLayoutCls">
        <t-aside><layout-side-nav /></t-aside>
        <t-layout>
          <t-header><layout-header /></t-header>
          <t-content><layout-content /></t-content>
        </t-layout>
      </t-layout>
    </template>

    <template v-else>
      <t-layout key="no-side">
        <t-header><layout-header /> </t-header>
        <t-layout :class="mainLayoutCls">
          <layout-side-nav />
          <layout-content />
        </t-layout>
      </t-layout>
    </template>
  </div>
</template>
<script setup lang="ts">
import '@/style/layout.less';

import { storeToRefs } from 'pinia';
import { computed, watch } from 'vue';
import { useRoute } from 'vue-router';

import { prefix } from '@/config/global';
import { useSettingStore } from '@/store';

import LayoutContent from './components/LayoutContent.vue';
import LayoutHeader from './components/LayoutHeader.vue';
import LayoutSideNav from './components/LayoutSideNav.vue';

const route = useRoute();
const settingStore = useSettingStore();
const setting = storeToRefs(settingStore);

const mainLayoutCls = computed(() => [
  {
    't-layout--with-sider': settingStore.showSidebar,
  },
]);

watch(
  () => route.fullPath,
  (newFullPath, oldFullPath) => {
    const newPath = String(newFullPath || '').split(/[?#]/)[0];
    const oldPath = String(oldFullPath || '').split(/[?#]/)[0];
    if (newPath === oldPath) return;

    const layoutEl = document.querySelector(`.${prefix}-layout`) as HTMLElement | null;
    layoutEl?.scrollTo({ top: 0, behavior: 'smooth' });
  },
);
</script>
<style lang="less" scoped></style>
