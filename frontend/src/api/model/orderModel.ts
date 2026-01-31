export interface Order {
  id: string;
  orderNo: string;
  title: string;
  amount: number;
  status: string;
  description?: string;
  region: string;
  gameName: string;
  gameMode: string;
  accountUsername: string;
  accountPassword?: string;
  gameMetaData?: string;
  proofImages?: string;
  deadlineTime?: string;
  isPaused?: boolean;
  pauseReason?: string;
  createdAt?: string;
  updatedAt?: string;

  customerName?: string;
  customerPhone?: string;
  customerWechat?: string;
  customerQq?: string;
  xianyuOrderNo?: string;
  gameUid?: string;
  gameRank?: string;
  specialRequirements?: string;
  boosterId?: string;
  boosterName?: string;
}

export interface OrderTimeline {
  id: string;
  orderId: string;
  operatorId?: string;
  operatorName?: string;
  action: string;
  content?: string;
  metaData?: string;
  createdAt: string;
}

export interface OrderListResult {
  list: Order[];
  total: number;
}

export interface OrderSummary {
  totalIncome: number;
  refundTotal: number;
}
