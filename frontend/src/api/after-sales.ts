import { request } from '@/utils/request';

export interface AfterSalesApplyRequest {
  orderId: number;
  reasonType: string;
  description: string;
  evidenceImgs: string[];
}

export interface AfterSalesResolveRequest {
  afterSalesId: number;
  refundAmount: number;
  boosterIncome: number;
  penaltyAmount: number;
  adminRemark: string;
}

export interface AfterSalesEntity {
  id: number;
  orderId: number;
  initiatorId: number;
  reasonType: string;
  description: string;
  evidenceImgs: string; // JSON string
  status: string;
  refundAmount: number;
  boosterIncome: number;
  penaltyAmount: number;
  adminRemark: string;
  resolvedAt?: string;
  createdAt: string;
  boosterName?: string;
}

export function applyAfterSales(data: AfterSalesApplyRequest) {
  return request.post({
    url: '/api/after-sales/apply',
    data,
  });
}

export function getAfterSalesDetail(orderId: number) {
  return request.get({
    url: `/api/after-sales/detail/${orderId}`,
  });
}

export function getAfterSalesList(params?: { status?: string; initiatorId?: number }) {
  return request.get({
    url: '/api/after-sales/list',
    params,
  });
}

export function resolveAfterSales(data: AfterSalesResolveRequest) {
  return request.post({
    url: '/api/after-sales/resolve',
    data,
  });
}

export function deleteAfterSales(id: number) {
  return request.delete({
    url: `/api/after-sales/${id}`,
  });
}
