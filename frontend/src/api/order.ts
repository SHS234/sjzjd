import { request } from '@/utils/request';

import type { Order, OrderListResult, OrderSummary, OrderTimeline } from './model/orderModel';

const Api = {
  Base: '/order',
};

export function getOrderList(params?: any) {
  return request.get<OrderListResult>({
    url: Api.Base,
    params,
  });
}

export function getOrderSummary() {
  return request.get<OrderSummary>({
    url: `${Api.Base}/summary`,
  });
}

export function getOrder(id: number | string) {
  return request.get<Order>({
    url: `${Api.Base}/${id}`,
  });
}

export function getOrderDetail(id: number | string) {
  return request.get<Order>({
    url: `${Api.Base}/${id}`,
  });
}

export function getOrderByNo(orderNo: string) {
  return request.get<Order>({
    url: `${Api.Base}/no/${orderNo}`,
  });
}

export function getOrderTimeline(id: string) {
  return request.get<OrderTimeline[]>({
    url: `${Api.Base}/${id}/timeline`,
  });
}

export function createOrder(data: Partial<Order>) {
  return request.post<Order>({
    url: Api.Base,
    data,
  });
}

export function updateOrder(id: string, data: Partial<Order>) {
  return request.put<Order>({
    url: `${Api.Base}/${id}`,
    data,
  });
}

export function completeOrder(id: string) {
  return request.post<void>({
    url: `${Api.Base}/${id}/complete`,
  });
}

export function deleteOrder(id: string | number) {
  return request.delete<void>({
    url: `${Api.Base}/${id}`,
  });
}

export function assignOrder(id: string, boosterId: string) {
  return request.post<void>({
    url: `${Api.Base}/${id}/assign`,
    data: { boosterId },
  });
}
