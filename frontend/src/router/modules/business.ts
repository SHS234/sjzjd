import type { RouteRecordRaw } from 'vue-router';

import Layout from '@/layouts/index.vue';

export default [
  {
    path: '/booster',
    component: Layout,
    redirect: '/booster/index',
    name: 'BoosterRoot',
    meta: { title: '打手管理', icon: 'usergroup', single: true },
    children: [
      {
        path: 'index',
        name: 'Booster',
        component: () => import('@/pages/booster/index.vue'),
        meta: { title: '打手管理' },
      },
    ],
  },
  {
    path: '/order',
    component: Layout,
    redirect: '/order/index',
    name: 'OrderRoot',
    meta: { title: '订单管理', icon: 'file', single: true },
    children: [
      {
        path: 'index',
        name: 'Order',
        component: () => import('@/pages/order/index.vue'),
        meta: { title: '订单管理' },
      },

      {
        path: 'detail/:id',
        name: 'OrderDetail',
        component: () => import('@/pages/order/detail.vue'),
        meta: { title: '订单详情', hidden: true },
      },
    ],
  },

  {
    path: '/after-sales',
    component: Layout,
    redirect: '/after-sales/index',
    name: 'AfterSalesRoot',
    meta: { title: '售后管理', icon: 'service', single: true },
    children: [
      {
        path: 'index',
        name: 'AfterSales',
        component: () => import('@/pages/after-sales/index.vue'),
        meta: { title: '售后管理' },
      },
      {
        path: 'apply',
        name: 'AfterSalesApply',
        component: () => import('@/pages/after-sales/apply.vue'),
        meta: { title: '申请售后', hidden: true },
      },
      {
        path: 'detail',
        name: 'AfterSalesDetail',
        component: () => import('@/pages/after-sales/detail.vue'),
        meta: { title: '售后详情', hidden: true },
      },
    ],
  },
  {
    path: '/finance',
    component: Layout,
    redirect: '/finance/index',
    name: 'FinanceRoot',
    meta: { title: '财务管理', icon: 'chart-bar', single: true },
    children: [
      {
        path: 'index',
        name: 'Finance',
        component: () => import('@/pages/finance/index.vue'),
        meta: { title: '财务管理' },
      },
    ],
  },
] satisfies RouteRecordRaw[];
