import { request } from '@/utils/request';

import type { Booster, BoosterListResult } from './model/boosterModel';

const Api = {
  List: '/booster/list',
  Detail: '/booster/detail',
  Create: '/booster/create',
  Update: '/booster/update',
  Delete: '/booster/delete',
};

export function getBoosterList(params?: any) {
  return request.get<BoosterListResult>({
    url: Api.List,
    params,
  });
}

export function getBoosterDetail(id: string) {
  return request.get<Booster>({
    url: Api.Detail,
    params: { id },
  });
}

export function createBooster(data: Partial<Booster>) {
  return request.post({
    url: Api.Create,
    data,
  });
}

export function updateBooster(data: Partial<Booster>) {
  return request.post({
    url: Api.Update,
    data,
  });
}

export function deleteBooster(id: string) {
  return request.post({
    url: Api.Delete,
    data: { id },
  });
}
