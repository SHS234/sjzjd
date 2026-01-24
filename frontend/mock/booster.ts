import Mock from 'mockjs';
import type { MockMethod } from 'vite-plugin-mock';

const mockState = Mock.mock({
  'list|15': [
    {
      'id|+1': 1,
      name: '@cname()',
      nickname: '@ctitle(2, 4)',
      phone: /^1[3-9]\d{9}$/,
      gameUid: /\d{9}/,
      'authStatus|1': ['Unverified', 'Pending', 'Verified'],
      authImage: 'https://tdesign.gtimg.com/site/source/card-demo.png',
      'rank|1': ['钻石', '星钻', '王者', '无敌战神'],
      'regions|1': ['QQ', 'WeChat', 'QQ,WeChat'],
      'device|1': ['PC', 'Mobile'],
      'tags|1-3': ['枪法硬', '全能王', '狙击神', '身法怪', '车队指挥'],
      'banAssocCount|0-3': 0,
      'isBanned|1': [false, false, false, false, true],
      'status|1': ['Online', 'Busy', 'Offline'],
      'currentOrderCount|0-3': 0,
      maxOrderLimit: 3,
      'onTimeRate|80-100': 95,
      'frozenBalance|0-500.2': 0,
      'availableBalance|0-2000.2': 0,
      createTime: '@datetime()',
    },
  ],
});

const list = mockState.list as Record<string, any>[];

const parseBody = (req: any) => {
  const body = req?.body ?? {};
  if (typeof body === 'string') {
    try {
      return JSON.parse(body);
    } catch {
      return {};
    }
  }
  return body;
};

export default [
  {
    url: '/api/booster/list',
    method: 'get',
    response: () => ({
      code: 0,
      message: 'success',
      data: {
        list,
        total: list.length,
      },
    }),
  },
  {
    url: '/api/booster/create',
    method: 'post',
    response: (req: any) => {
      const body = parseBody(req);
      const maxId = list.reduce((max, item) => Math.max(max, Number(item.id) || 0), 0);
      const nextId = maxId + 1;
      const newItem = {
        id: nextId,
        name: body.name,
        nickname: body.nickname,
        phone: body.phone,
        gameUid: body.gameUid,
        authStatus: body.authStatus ?? 'Unverified',
        authImage: body.authImage,
        rank: body.rank,
        regions: body.regions,
        device: body.device,
        tags: body.tags ?? [],
        banAssocCount: body.banAssocCount ?? 0,
        isBanned: body.isBanned ?? false,
        status: body.status ?? 'Online',
        currentOrderCount: body.currentOrderCount ?? 0,
        maxOrderLimit: body.maxOrderLimit ?? 3,
        onTimeRate: body.onTimeRate ?? 100,
        frozenBalance: body.frozenBalance ?? 0,
        availableBalance: body.availableBalance ?? 0,
        createTime: new Date().toISOString(),
      };
      list.unshift(newItem);
      return {
        code: 0,
        message: '创建成功',
        data: null as null,
      };
    },
  },
  {
    url: '/api/booster/update',
    method: 'post',
    response: (req: any) => {
      const body = parseBody(req);
      const id = Number(body.id);
      const index = list.findIndex((item) => Number(item.id) === id);
      if (index >= 0) {
        list[index] = { ...list[index], ...body };
      }
      return {
        code: 0,
        message: '更新成功',
        data: null as null,
      };
    },
  },
  {
    url: '/api/booster/delete',
    method: 'post',
    response: (req: any) => {
      const body = parseBody(req);
      const id = Number(body.id);
      const index = list.findIndex((item) => Number(item.id) === id);
      if (index >= 0) {
        list.splice(index, 1);
      }
      return {
        code: 0,
        message: '删除成功',
        data: null as null,
      };
    },
  },
] as MockMethod[];
