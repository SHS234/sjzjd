CREATE TABLE IF NOT EXISTS `wallets` (
    `booster_id` bigint NOT NULL,
    `balance` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '可提现余额',
    `frozen_balance` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '冻结中金额',
    `deposit` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '保证金',
    `total_withdrawn` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '累计提现总额',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`booster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='打手钱包表';

CREATE TABLE IF NOT EXISTS `settlements` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `order_no` varchar(64) NOT NULL COMMENT '关联订单号',
    `booster_id` bigint NOT NULL COMMENT '打手ID',
    `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
    `booster_amount` decimal(10, 2) NOT NULL COMMENT '打手应得金额',
    `platform_amount` decimal(10, 2) NOT NULL COMMENT '平台抽成',
    `ratio` decimal(4, 2) NOT NULL DEFAULT '0.80' COMMENT '分成比例',
    `status` varchar(32) NOT NULL DEFAULT 'PENDING' COMMENT '状态: PENDING(冻结), SETTLED(已入账), CANCELLED(已取消), PAUSED(暂停)',
    `settle_time` datetime COMMENT '预计结算时间',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_booster_id` (`booster_id`),
    KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='结算记录表';

CREATE TABLE IF NOT EXISTS `transactions` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `transaction_no` varchar(64) NOT NULL COMMENT '流水号',
    `booster_id` bigint NOT NULL COMMENT '打手ID',
    `type` varchar(32) NOT NULL COMMENT '类型: INCOME(订单收入), WITHDRAWAL(提现), PENALTY(罚款), BONUS(奖励), DEPOSIT(保证金)',
    `amount` decimal(10, 2) NOT NULL COMMENT '变动金额(+/-)',
    `balance_after` decimal(10, 2) NOT NULL COMMENT '变动后余额',
    `related_id` varchar(64) COMMENT '关联ID(订单号/提现单号)',
    `note` varchar(255) COMMENT '备注',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_booster_id` (`booster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资金流水表';

CREATE TABLE IF NOT EXISTS `withdrawals` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `booster_id` bigint NOT NULL COMMENT '打手ID',
    `amount` decimal(10, 2) NOT NULL COMMENT '提现金额',
    `account_info` varchar(255) NOT NULL COMMENT '收款账号信息',
    `status` varchar(32) NOT NULL DEFAULT 'PENDING' COMMENT '状态: PENDING(待审核), APPROVED(已通过), REJECTED(已驳回)',
    `note` varchar(255) COMMENT '备注(驳回理由等)',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_booster_id` (`booster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现申请表';
