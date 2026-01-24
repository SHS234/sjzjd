import Mock from 'mockjs';
import type { MockMethod } from 'vite-plugin-mock';

export default [
  {
    url: '/api/customer/list',
    method: 'get',
    response: () => ({
      code: 0,
      message: 'success',
      data: {
        ...Mock.mock({
          'list|15': [
            {
              'id|+1': 1,
              name: '@cname()',
              phone: /^1[3-9]\d{9}$/,
              'wechat|1': [null, /wx_[a-z0-9]{6}/],
              'qq|1': [null, /\d{9,10}/],
              'source|1': ['淘宝', '闲鱼', '私域流量', '老客推荐', '其他'],

              gameUid: /\d{9}/,
              'region|1': ['微信区', 'QQ区', '服务器1', '服务器2'],
              'currentRank|1': ['青铜', '白银', '黄金', '铂金', '钻石', '星钻', '王者'],

              account: /[a-z0-9]{6,12}/i,
              password: /[a-z0-9!@#$%]{8,12}/i,

              'ltv|100-5000': 100,
              'vipLevel|1': ['Bronze', 'Gold', 'Diamond', 'Normal'],
              'balance|0-1000': 0,
              'orderCount|1-20': 1,

              'status|1': ['Normal', 'Normal', 'Normal', 'Blacklist'], // 25% chance of Blacklist
              'banHistory|1': [null, null, '2023-10封号3天'],
              'specialRequirements|1': [null, '不准动点券', '指定干员', 'KD要求2.0+'],

              createTime: '@datetime()',
              lastOrderTime: '@datetime()',
            },
          ],
          total: 100,
        }),
      },
    }),
  },
  {
    url: '/api/customer/create',
    method: 'post',
    response: () => ({
      code: 0,
      message: '创建成功',
      data: null as null,
    }),
  },
  {
    url: '/api/customer/update',
    method: 'post',
    response: () => ({
      code: 0,
      message: '更新成功',
      data: null as null,
    }),
  },
  {
    url: '/api/customer/delete',
    method: 'post',
    response: () => ({
      code: 0,
      message: '删除成功',
      data: null as null,
    }),
  },
] as MockMethod[];
