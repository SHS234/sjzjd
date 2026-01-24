export interface Booster {
  id: string;
  name: string;
  nickname: string;
  phone: string;
  gameUid?: string; // Game ID for verification

  // Capability Profiling
  authStatus: 'Unverified' | 'Pending' | 'Verified';
  authImage?: string; // Rank screenshot URL
  rank: string; // e.g., "Diamond IV"
  regions?: string[] | string; // Game regions: 'QQ', 'WeChat'
  device: 'PC' | 'Mobile';
  tags: string[]; // Skill tags

  // Risk Management
  banAssocCount: number; // 封号连带记录
  isBanned: boolean; // System blacklist

  // Status & Load
  status: 'Online' | 'Busy' | 'Offline';
  currentOrderCount: number;
  maxOrderLimit: number;
  onTimeRate: number; // Percentage 0-100

  // Finance
  frozenBalance: number;
  availableBalance: number;

  createTime: string;
}

export interface BoosterListResult {
  list: Booster[];
  total: number;
}
