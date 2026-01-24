DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_no` varchar(64) NOT NULL COMMENT '订单编号',
  `title` varchar(255) NOT NULL COMMENT '订单标题',
  `customer_id` bigint NULL DEFAULT NULL COMMENT '客户ID',
  `booster_id` bigint NULL DEFAULT NULL COMMENT '打手ID',
  `amount` decimal(10,2) NULL DEFAULT NULL COMMENT '订单金额',
  `status` varchar(32) NOT NULL DEFAULT 'PENDING' COMMENT '订单状态',
  `description` text COMMENT '订单描述',
  `region` varchar(64) COMMENT '区服',
  `game_name` varchar(64) COMMENT '游戏名称',
  `game_mode` varchar(64) COMMENT '游戏模式',
  `account_username` varchar(128) COMMENT '游戏账号',
  `account_password` varchar(128) COMMENT '游戏密码',
  `game_meta_data` json COMMENT '游戏元数据',
  `proof_images` json COMMENT '证据图片',
  `deadline_time` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `is_paused` tinyint(1) DEFAULT 0 COMMENT '是否暂停',
  `pause_reason` varchar(255) COMMENT '暂停原因',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

DROP TABLE IF EXISTS `order_timeline`;
CREATE TABLE `order_timeline` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `operator_id` bigint NULL COMMENT '操作人ID',
  `operator_name` varchar(64) COMMENT '操作人名称',
  `action` varchar(32) NOT NULL COMMENT '动作类型',
  `content` varchar(255) NOT NULL COMMENT '显示内容',
  `meta_data` json COMMENT '元数据',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单时间轴/日志';

DROP TABLE IF EXISTS `boosters`;
CREATE TABLE `boosters` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '打手姓名',
  `nickname` varchar(64) DEFAULT NULL COMMENT '打手外号',
  `phone` varchar(32) NOT NULL COMMENT '手机号',
  `game_rank` varchar(64) NOT NULL COMMENT '游戏段位',
  `regions` varchar(255) DEFAULT NULL COMMENT '游戏大区',
  `device` varchar(32) NOT NULL COMMENT '设备类型',
  `auth_image` varchar(255) DEFAULT NULL COMMENT '认证图片',
  `status` varchar(32) DEFAULT 'OFFLINE' COMMENT '状态',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='打手表';
