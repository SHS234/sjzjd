/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : tdesign

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 25/01/2026 03:11:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for after_sales
-- ----------------------------
DROP TABLE IF EXISTS `after_sales`;
CREATE TABLE `after_sales`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `initiator_id` bigint NOT NULL,
  `reason_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `evidence_imgs` json NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PENDING',
  `refund_amount` decimal(10, 2) NULL DEFAULT 0.00,
  `booster_income` decimal(10, 2) NULL DEFAULT 0.00,
  `penalty_amount` decimal(10, 2) NULL DEFAULT 0.00,
  `admin_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `resolved_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `booster_id` bigint NULL DEFAULT NULL COMMENT '被投诉打手ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_initiator_id`(`initiator_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of after_sales
-- ----------------------------
INSERT INTO `after_sales` VALUES (2, 12, 1, 'GUARANTEE_STUCK', 'hhhhh', '[\"/api/files/AUwnGcsavxxcEtnPoPU5iRV-nI7-JAQ0khMp93N1IclRWAvQ3lk2zVPINsKan26lXu-DWl4BcRIPOmjxrTe07xymveNwR9pK99DMEPBhbHKD1u1cncSrqK5GPmEjHnNNai72stsbmy5XOGGxfLY9HE2msCPHhmq_foUwVnp5uWeF\"]', 'RESOLVED', 6.00, 0.00, 0.00, '', '2026-01-24 21:12:58', '2026-01-24 21:12:46', '2026-01-24 21:12:58', NULL);

-- ----------------------------
-- Table structure for ai_provider_settings
-- ----------------------------
DROP TABLE IF EXISTS `ai_provider_settings`;
CREATE TABLE `ai_provider_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `vendor` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `base_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `endpoint_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `model` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `api_key` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `api_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `temperature` double NULL DEFAULT NULL,
  `max_tokens` int NULL DEFAULT NULL,
  `is_default` tinyint NULL DEFAULT NULL,
  `enabled` tinyint NULL DEFAULT NULL,
  `extra_headers` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remark` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_test_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_test_message` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_tested_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ai_provider_settings
-- ----------------------------
INSERT INTO `ai_provider_settings` VALUES (2, 'free', 'OPENAI', 'https://free.v36.cm', '/v1/chat/completions', 'gpt-4o-mini', 'sk-mY7HClYdrZSLSIYwC83437B5E58c4162B97c14B215E7D2B4', NULL, 0.7, NULL, 0, 1, NULL, NULL, 'SUCCESS', '连接成功，返回: 健康检查已完成，配置测试已成功保存。如需进一步帮助，请告知具体需求。', '2026-01-08 23:47:03', '2026-01-08 23:09:59', '2026-01-08 23:21:44');

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `summary` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `priority` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `publish_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `created_by_id` bigint NULL DEFAULT NULL,
  `created_by_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachment_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_broadcasted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of announcements
-- ----------------------------
INSERT INTO `announcements` VALUES (2, '大数据分析助力企业决策的实践案例', '通过实际案例分析，阐述了企业如何利用大数据分析工具挖掘数据价值，优化业务流程，提升决策效率和市场竞争力。', '<p>在数字化转型的浪潮中，数据已成为企业最宝贵的资产之一。如何从海量数据中提取有价值的信息...</p>', '技术', 'middle', 'published', NULL, '2026-01-08 04:56:09', '2026-01-07 00:10:13', '2026-01-09 01:28:44', NULL, 'Admin', NULL, NULL, 1);
INSERT INTO `announcements` VALUES (3, '区块链技术在供应链管理中的应用', '介绍了区块链技术去中心化、不可篡改的特性在供应链追溯、物流透明化和供应链金融等场景中的应用优势和实施路径。', '<p>供应链管理的痛点在于信息不对称和信任缺失。区块链技术通过分布式账本...</p>', '科技', 'low', 'published', 'https://tdesign.gtimg.com/site/source/card-demo.png', '2026-01-07 01:09:19', '2026-01-07 00:10:13', '2026-01-07 01:09:19', NULL, 'Admin', NULL, NULL, 0);
INSERT INTO `announcements` VALUES (4, '云计算技术发展趋势与未来展望', '深入分析了云计算技术的演进历程，探讨了混合云、边缘计算和云原生等新兴技术趋势，展望了云计算对数字经济的推动作用。', '<p>云计算作为数字经济的基石，正在进入一个新的发展阶段。企业上云已成为常态...</p>', 'announcement', 'high', 'published', NULL, '2026-01-09 04:03:19', '2026-01-07 00:10:13', '2026-01-09 04:03:53', NULL, 'Admin', NULL, NULL, 1);

-- ----------------------------
-- Table structure for boosters
-- ----------------------------
DROP TABLE IF EXISTS `boosters`;
CREATE TABLE `boosters`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '打手姓名',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '打手外号',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `game_rank` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '游戏段位',
  `regions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏大区',
  `device` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备类型',
  `auth_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '认证图片',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'OFFLINE' COMMENT '状态',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '打手表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of boosters
-- ----------------------------
INSERT INTO `boosters` VALUES (10, '小都', '嘟嘟', '13556578907', '铂金', 'WeChat,QQ', 'PC', '/api/files/ASF_qDTtJ0rpXxV2H3xMxV23ftJfVDitkFdlGIkvvL-lUtK5CKT3_NW8FYvhxC9PEZiGLMKMMIQEfl4-bSSp7KZzP68QGkAerrN9Ka9W2zgjZhi-J6_x3LMKVwtzqwCRLBteCKzxzl0jww_cM6dV3Sglxz-j8s6ZtBM8hw', 'Online', '2026-01-23 15:56:43', '2026-01-24 01:20:37');
INSERT INTO `boosters` VALUES (11, '小红', '水水', '13676654367', '铂金', 'QQ', 'PC', NULL, 'Online', '2026-01-23 16:15:42', '2026-01-24 21:43:27');
INSERT INTO `boosters` VALUES (12, '小绿', '哈哈', '132444444444', '黑鹰', 'QQ,WeChat', 'PC', '/api/files/AQtN-1FktED4GAiKlEvY0uA1zjjMDCbNrkjkqnFY_x4pIfDHA5JbwSiwtOmZPN1WmRCBb4I9WT1iUz2Yr2hENcun5ffy7WoyvQMGyV8tqWJmg3XDBBcV5NHIoW6UCmpdU9XBxPV-KOCeonzpzATgXW5fgzjStlfgawCjaw', 'Online', '2026-01-23 16:21:59', '2026-01-24 01:40:00');
INSERT INTO `boosters` VALUES (13, '小看', '帆帆', '134534337678', '铂金', 'QQ', 'PC', '/api/files/AfiS6VB62PMAuPc0dXZ2aG588Zl7CSln2cI3m-Ewu610G8taZqMWfBe7ic06fupGTnnv4anwdw62P8bSi9-8-JhWkJzzd9W_h-ehDwFbtYzcGn0b7GqwWJLl3GI6MLUHon9-e3oYBwY3f-KmSUupn-25AdOCeRv_mn7wIg', 'Online', '2026-01-23 22:11:13', '2026-01-24 22:14:33');
INSERT INTO `boosters` VALUES (14, '小高', '等等', '13998966777', '钻石', 'QQ', 'Mobile', '/api/files/AZZ4fM8Dj3isTVAqUkeCATUYmqD7gs4Nq1uphbA2eL5wTDtWLZdxN5N0QCK6_izJvNSfsrs_CJScvQEjAwOyN8H7ugnBj8bmWTGCDR7HF0qhNT8DWQrMKi4AgMCsEMXBbE76Es45oPvWJubStdanjA7GcmBdACgicPIN3w', 'Online', '2026-01-23 22:11:36', '2026-01-24 22:14:38');

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户姓名',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `wechat` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信号',
  `qq` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'QQ号',
  `source` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户来源',
  `game_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏UID',
  `region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属大区',
  `current_rank` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '当前段位',
  `account` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏账号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏密码',
  `ltv` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '累计消费',
  `vip_level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Normal' COMMENT 'VIP等级',
  `balance` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '余额',
  `order_count` int NULL DEFAULT 0 COMMENT '订单数量',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Normal' COMMENT '状态',
  `ban_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '封号记录',
  `special_requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '特殊要求',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `last_order_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (5, '小松', '1377777777', '234345566', NULL, '抖音', 'aaaaa', 'QQ区', '', '', '', 0.00, 'Normal', 0.00, 0, 'Normal', '', '', '2026-01-19 14:31:53', NULL);

-- ----------------------------
-- Table structure for file_download_history
-- ----------------------------
DROP TABLE IF EXISTS `file_download_history`;
CREATE TABLE `file_download_history`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `file_id` bigint NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `size_bytes` bigint NOT NULL DEFAULT 0,
  `downloaded_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_file_download_history_user_time`(`user_id` ASC, `downloaded_at` ASC) USING BTREE,
  INDEX `idx_file_download_history_file_time`(`file_id` ASC, `downloaded_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_download_history
-- ----------------------------
INSERT INTO `file_download_history` VALUES (1, 1, 1, 'TDesign设计规范.pdf', 5242880, '2026-01-13 22:45:31');
INSERT INTO `file_download_history` VALUES (2, 1, 2, '系统架构图.png', 2097152, '2026-01-13 23:10:58');

-- ----------------------------
-- Table structure for file_resources
-- ----------------------------
DROP TABLE IF EXISTS `file_resources`;
CREATE TABLE `file_resources`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `suffix` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `file_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_by_id` bigint NULL DEFAULT NULL,
  `created_by_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_resources
-- ----------------------------

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `to_user_id` bigint NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL,
  `collected` tinyint NOT NULL,
  `quality` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_messages_user_time`(`to_user_id` ASC, `created_at` ASC) USING BTREE,
  CONSTRAINT `fk_messages_user` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES ('a06fe751-8ab7-4e41-b898-8a7717306e0a', 1, '【公告】云计算技术发展趋势与未来展望：深入分析了云计算技术的演进历程，探讨了混合云、边缘计算和云原生等新兴技术趋势，展望了云计算对数字经济的推动作用。', 'announcement', 1, 0, 'high', '2026-01-09 04:03:19');

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `summary` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `priority` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `publish_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `created_by_id` bigint NULL DEFAULT NULL,
  `created_by_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachment_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notifications
-- ----------------------------

-- ----------------------------
-- Table structure for operation_logs
-- ----------------------------
DROP TABLE IF EXISTS `operation_logs`;
CREATE TABLE `operation_logs`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `module` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `detail` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ip_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `device_model` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `os` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `browser` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `user_guid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 371 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operation_logs
-- ----------------------------
INSERT INTO `operation_logs` VALUES (1, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 13:37:43', NULL);
INSERT INTO `operation_logs` VALUES (2, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:00:32', NULL);
INSERT INTO `operation_logs` VALUES (3, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:14:52', NULL);
INSERT INTO `operation_logs` VALUES (4, 'CREATE', '菜单管理', '创建菜单: 操作日志 (index)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:21:56', NULL);
INSERT INTO `operation_logs` VALUES (5, 'UPDATE', '菜单管理', '更新菜单: 页面管理 (SystemMenu)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:23:42', NULL);
INSERT INTO `operation_logs` VALUES (6, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:55:28', NULL);
INSERT INTO `operation_logs` VALUES (7, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:55:47', NULL);
INSERT INTO `operation_logs` VALUES (8, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 14:56:02', NULL);
INSERT INTO `operation_logs` VALUES (9, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 15:08:44', NULL);
INSERT INTO `operation_logs` VALUES (10, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 16:30:24', NULL);
INSERT INTO `operation_logs` VALUES (11, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 19:15:31', NULL);
INSERT INTO `operation_logs` VALUES (12, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:04:03', NULL);
INSERT INTO `operation_logs` VALUES (13, 'UPDATE', '菜单管理', '更新菜单: Redis监控 (SystemMonitorRedis)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:04:35', NULL);
INSERT INTO `operation_logs` VALUES (14, 'CREATE', '菜单管理', '创建菜单: 用户设置 (MenuMjr5ig79)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:45:20', NULL);
INSERT INTO `operation_logs` VALUES (15, 'UPDATE', '菜单管理', '更新菜单: 用户设置 (MenuMjr5j12j)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:45:47', NULL);
INSERT INTO `operation_logs` VALUES (16, 'UPDATE', '菜单管理', '更新菜单: 用户管理 (SystemUser)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:46:02', NULL);
INSERT INTO `operation_logs` VALUES (17, 'UPDATE', '菜单管理', '更新菜单: 角色管理 (SystemRole)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:46:08', NULL);
INSERT INTO `operation_logs` VALUES (18, 'UPDATE', '菜单管理', '更新菜单: 操作日志 (SystemLog)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:46:19', NULL);
INSERT INTO `operation_logs` VALUES (19, 'UPDATE', '菜单管理', '更新菜单: 用户设置 (users)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 20:46:58', NULL);
INSERT INTO `operation_logs` VALUES (20, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 21:54:21', NULL);
INSERT INTO `operation_logs` VALUES (21, 'UPDATE', '角色管理', '更新角色: admin', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 22:42:01', NULL);
INSERT INTO `operation_logs` VALUES (22, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 22:42:07', NULL);
INSERT INTO `operation_logs` VALUES (23, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 22:42:43', NULL);
INSERT INTO `operation_logs` VALUES (24, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 22:53:11', NULL);
INSERT INTO `operation_logs` VALUES (25, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 22:54:26', NULL);
INSERT INTO `operation_logs` VALUES (26, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 23:16:01', NULL);
INSERT INTO `operation_logs` VALUES (27, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 23:16:35', NULL);
INSERT INTO `operation_logs` VALUES (28, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 23:28:16', NULL);
INSERT INTO `operation_logs` VALUES (29, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 23:28:30', NULL);
INSERT INTO `operation_logs` VALUES (30, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-29 23:28:56', NULL);
INSERT INTO `operation_logs` VALUES (31, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:04:37', NULL);
INSERT INTO `operation_logs` VALUES (32, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:04:42', NULL);
INSERT INTO `operation_logs` VALUES (33, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:05:05', NULL);
INSERT INTO `operation_logs` VALUES (34, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:05:20', NULL);
INSERT INTO `operation_logs` VALUES (35, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:30:11', NULL);
INSERT INTO `operation_logs` VALUES (36, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:30:44', NULL);
INSERT INTO `operation_logs` VALUES (37, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:30:54', NULL);
INSERT INTO `operation_logs` VALUES (38, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:31:14', NULL);
INSERT INTO `operation_logs` VALUES (39, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 00:38:34', NULL);
INSERT INTO `operation_logs` VALUES (40, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 01:04:39', NULL);
INSERT INTO `operation_logs` VALUES (41, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 02:02:34', NULL);
INSERT INTO `operation_logs` VALUES (42, 'UPDATE', '角色管理', '更新角色: admin', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 02:57:02', NULL);
INSERT INTO `operation_logs` VALUES (43, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:06:30', NULL);
INSERT INTO `operation_logs` VALUES (44, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:31:18', NULL);
INSERT INTO `operation_logs` VALUES (45, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:33:51', NULL);
INSERT INTO `operation_logs` VALUES (46, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:36:51', NULL);
INSERT INTO `operation_logs` VALUES (47, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:37:00', NULL);
INSERT INTO `operation_logs` VALUES (48, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:37:24', NULL);
INSERT INTO `operation_logs` VALUES (49, 'UPDATE', '系统设置', '更新系统个性化设置', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:37:46', NULL);
INSERT INTO `operation_logs` VALUES (50, 'UPDATE', '系统设置', '更新系统个性化设置', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:37:49', NULL);
INSERT INTO `operation_logs` VALUES (51, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:37:55', NULL);
INSERT INTO `operation_logs` VALUES (52, 'UPDATE', '系统设置', '更新系统个性化设置', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:37:56', NULL);
INSERT INTO `operation_logs` VALUES (53, 'UPDATE', '系统设置', '更新系统个性化设置', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:38:01', NULL);
INSERT INTO `operation_logs` VALUES (54, 'UPDATE', '系统设置', '更新系统个性化设置', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:38:03', NULL);
INSERT INTO `operation_logs` VALUES (55, 'DELETE', '菜单管理', '删除菜单: 版本号 (SystemVersion)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:55:06', NULL);
INSERT INTO `operation_logs` VALUES (56, 'DELETE', '菜单管理', '删除菜单: 版权设置 (SystemCopyright)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:55:11', NULL);
INSERT INTO `operation_logs` VALUES (57, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:55:28', NULL);
INSERT INTO `operation_logs` VALUES (58, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:55:36', NULL);
INSERT INTO `operation_logs` VALUES (59, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 03:55:51', NULL);
INSERT INTO `operation_logs` VALUES (60, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 04:31:15', NULL);
INSERT INTO `operation_logs` VALUES (61, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:11:09', NULL);
INSERT INTO `operation_logs` VALUES (62, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:11:22', NULL);
INSERT INTO `operation_logs` VALUES (63, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:11:26', NULL);
INSERT INTO `operation_logs` VALUES (64, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:11:30', NULL);
INSERT INTO `operation_logs` VALUES (65, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:11:39', NULL);
INSERT INTO `operation_logs` VALUES (66, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:22:26', NULL);
INSERT INTO `operation_logs` VALUES (67, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:22:41', NULL);
INSERT INTO `operation_logs` VALUES (68, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:23:22', NULL);
INSERT INTO `operation_logs` VALUES (69, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 21:41:59', NULL);
INSERT INTO `operation_logs` VALUES (70, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 22:08:41', NULL);
INSERT INTO `operation_logs` VALUES (71, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 22:09:04', NULL);
INSERT INTO `operation_logs` VALUES (72, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 22:21:58', NULL);
INSERT INTO `operation_logs` VALUES (73, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 22:41:29', NULL);
INSERT INTO `operation_logs` VALUES (74, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 22:51:53', NULL);
INSERT INTO `operation_logs` VALUES (75, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 22:52:13', NULL);
INSERT INTO `operation_logs` VALUES (76, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 23:28:55', NULL);
INSERT INTO `operation_logs` VALUES (77, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 23:38:31', NULL);
INSERT INTO `operation_logs` VALUES (78, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 23:52:14', NULL);
INSERT INTO `operation_logs` VALUES (79, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-30 23:58:42', NULL);
INSERT INTO `operation_logs` VALUES (80, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 00:00:00', NULL);
INSERT INTO `operation_logs` VALUES (81, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 00:10:55', NULL);
INSERT INTO `operation_logs` VALUES (82, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 01:08:03', NULL);
INSERT INTO `operation_logs` VALUES (83, 'UPDATE', '水印设置', '更新水印配置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 01:09:46', NULL);
INSERT INTO `operation_logs` VALUES (84, 'UPDATE', '菜单管理', '初始化默认菜单: 9项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 01:10:18', NULL);
INSERT INTO `operation_logs` VALUES (85, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 01:47:51', NULL);
INSERT INTO `operation_logs` VALUES (86, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 01:50:57', NULL);
INSERT INTO `operation_logs` VALUES (87, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 01:58:40', NULL);
INSERT INTO `operation_logs` VALUES (88, 'UPDATE', '菜单管理', '更新菜单: 用户管理 (SystemUser)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 02:18:00', NULL);
INSERT INTO `operation_logs` VALUES (89, 'UPDATE', '菜单管理', '更新菜单: 角色管理 (SystemRole)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 02:18:07', NULL);
INSERT INTO `operation_logs` VALUES (90, 'UPDATE', '菜单管理', '更新菜单: 系统监控 (SystemMonitor)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 02:30:04', NULL);
INSERT INTO `operation_logs` VALUES (91, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:19:05', NULL);
INSERT INTO `operation_logs` VALUES (92, 'UPDATE', '菜单管理', '调整菜单顺序', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:19:46', NULL);
INSERT INTO `operation_logs` VALUES (93, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:23:17', NULL);
INSERT INTO `operation_logs` VALUES (94, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:43:04', NULL);
INSERT INTO `operation_logs` VALUES (95, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:45:40', NULL);
INSERT INTO `operation_logs` VALUES (96, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:46:17', NULL);
INSERT INTO `operation_logs` VALUES (97, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:46:56', NULL);
INSERT INTO `operation_logs` VALUES (98, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:47:10', NULL);
INSERT INTO `operation_logs` VALUES (99, 'UPDATE', '菜单管理', '初始化默认菜单: 9项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:50:58', NULL);
INSERT INTO `operation_logs` VALUES (100, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:56:41', NULL);
INSERT INTO `operation_logs` VALUES (101, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 03:57:55', NULL);
INSERT INTO `operation_logs` VALUES (102, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:03:04', NULL);
INSERT INTO `operation_logs` VALUES (103, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:03:22', NULL);
INSERT INTO `operation_logs` VALUES (104, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:09:42', NULL);
INSERT INTO `operation_logs` VALUES (105, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:09:58', NULL);
INSERT INTO `operation_logs` VALUES (106, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:11:43', NULL);
INSERT INTO `operation_logs` VALUES (107, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:58:23', NULL);
INSERT INTO `operation_logs` VALUES (108, 'UPDATE', '菜单管理', '更新菜单: Redis监控 (SystemMonitorRedis)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 04:59:50', NULL);
INSERT INTO `operation_logs` VALUES (109, 'UPDATE', '菜单管理', '更新菜单: 个人中心 (UserIndex)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 05:00:44', NULL);
INSERT INTO `operation_logs` VALUES (110, 'UPDATE', '菜单管理', '更新菜单: 个人中心 (user)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2025-12-31 05:01:28', NULL);
INSERT INTO `operation_logs` VALUES (111, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:21:44', NULL);
INSERT INTO `operation_logs` VALUES (112, 'UPDATE', '菜单管理', '初始化默认菜单: 11项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:24:28', NULL);
INSERT INTO `operation_logs` VALUES (113, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:25:03', NULL);
INSERT INTO `operation_logs` VALUES (114, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:25:24', NULL);
INSERT INTO `operation_logs` VALUES (115, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:26:09', NULL);
INSERT INTO `operation_logs` VALUES (116, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:26:46', NULL);
INSERT INTO `operation_logs` VALUES (117, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:30:11', NULL);
INSERT INTO `operation_logs` VALUES (118, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:43:00', NULL);
INSERT INTO `operation_logs` VALUES (119, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 15:55:16', NULL);
INSERT INTO `operation_logs` VALUES (120, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-05 16:40:05', NULL);
INSERT INTO `operation_logs` VALUES (121, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:18:50', NULL);
INSERT INTO `operation_logs` VALUES (122, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:20:14', NULL);
INSERT INTO `operation_logs` VALUES (123, 'DELETE', '菜单管理', '删除菜单: 仪表盘 (dashboard)（含子节点）', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:21:37', NULL);
INSERT INTO `operation_logs` VALUES (124, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:27:35', NULL);
INSERT INTO `operation_logs` VALUES (125, 'UPDATE', '菜单管理', '调整菜单顺序', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:27:43', NULL);
INSERT INTO `operation_logs` VALUES (126, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:31:59', NULL);
INSERT INTO `operation_logs` VALUES (127, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:33:40', NULL);
INSERT INTO `operation_logs` VALUES (128, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:34:40', NULL);
INSERT INTO `operation_logs` VALUES (129, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:34:58', NULL);
INSERT INTO `operation_logs` VALUES (130, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:38:05', NULL);
INSERT INTO `operation_logs` VALUES (131, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:40:37', NULL);
INSERT INTO `operation_logs` VALUES (132, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:40:59', NULL);
INSERT INTO `operation_logs` VALUES (133, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:41:23', NULL);
INSERT INTO `operation_logs` VALUES (134, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:41:25', NULL);
INSERT INTO `operation_logs` VALUES (135, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:42:52', NULL);
INSERT INTO `operation_logs` VALUES (136, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:43:29', NULL);
INSERT INTO `operation_logs` VALUES (137, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:45:08', NULL);
INSERT INTO `operation_logs` VALUES (138, 'UPDATE', '角色管理', '更新角色: admin', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:45:16', NULL);
INSERT INTO `operation_logs` VALUES (139, 'UPDATE', '角色管理', '更新角色: admin', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:46:11', NULL);
INSERT INTO `operation_logs` VALUES (140, 'UPDATE', '角色管理', '更新角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:46:49', NULL);
INSERT INTO `operation_logs` VALUES (141, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:47:02', NULL);
INSERT INTO `operation_logs` VALUES (142, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:48:33', NULL);
INSERT INTO `operation_logs` VALUES (143, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:48:53', NULL);
INSERT INTO `operation_logs` VALUES (144, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 02:55:03', NULL);
INSERT INTO `operation_logs` VALUES (145, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 03:07:41', NULL);
INSERT INTO `operation_logs` VALUES (146, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-06 03:09:17', NULL);
INSERT INTO `operation_logs` VALUES (147, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-06 03:15:40', NULL);
INSERT INTO `operation_logs` VALUES (148, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-06 03:15:41', NULL);
INSERT INTO `operation_logs` VALUES (149, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 03:16:04', NULL);
INSERT INTO `operation_logs` VALUES (150, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 03:23:53', NULL);
INSERT INTO `operation_logs` VALUES (151, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-06 03:53:43', NULL);
INSERT INTO `operation_logs` VALUES (152, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-06 04:12:03', NULL);
INSERT INTO `operation_logs` VALUES (153, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:35:01', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (154, 'DELETE', '菜单管理', '删除菜单: 水印设置 (SystemWatermark)（含子节点）', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:35:01', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (155, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:37:34', '700e0805-c571-4e6a-873b-00899a32ede2');
INSERT INTO `operation_logs` VALUES (156, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:38:32', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (157, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:43:07', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (158, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:44:32', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (159, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 20:49:57', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (160, 'LOGIN', '登录', '用户登录', 3, 'bob', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:16:26', '700e0805-c571-4e6a-873b-00899a32ede2');
INSERT INTO `operation_logs` VALUES (161, 'DELETE', '在线用户', '强制下线: admin', NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2026-01-08 21:17:21', NULL);
INSERT INTO `operation_logs` VALUES (162, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:20:21', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (163, 'UPDATE', '菜单管理', '初始化默认菜单: 20项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:22:11', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (164, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:36:14', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (165, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:38:20', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (166, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:38:28', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (167, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:38:57', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (168, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:39:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (169, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:39:26', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (170, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:41:57', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (171, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:42:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (172, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:42:54', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (173, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:44:34', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (174, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:44:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (175, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:45:39', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (176, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 21:53:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (177, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 22:29:47', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (178, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 22:34:37', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (179, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 22:44:49', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (180, 'UPDATE', '菜单管理', '初始化默认菜单: 23项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 23:28:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (181, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 23:48:13', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (182, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-08 23:49:46', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (183, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:04:09', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (184, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:09:55', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (185, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:12:01', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (186, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:13:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (187, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:32:19', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (188, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:32:39', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (189, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:32:54', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (190, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:33:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (191, 'LOGIN', '登录', '用户登录', 147, '13405825198', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 00:33:31', 'fffbdd25-3209-4245-9d19-116e37e2a4da');
INSERT INTO `operation_logs` VALUES (192, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:27:57', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (193, 'UPDATE', '公告管理', '更新公告: 大数据分析助力企业决策的实践案例', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:28:22', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (194, 'UPDATE', '公告管理', '更新公告: 大数据分析助力企业决策的实践案例', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:28:44', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (195, 'DELETE', '公告管理', '删除公告: AI技术在医疗领域的创新应用与发展前景', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:28:54', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (196, 'WITHDRAW', '公告管理', '更改公告状态: 云计算技术发展趋势与未来展望', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:28:59', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (197, 'DELETE', '用户管理', '删除用户: henry', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:31:44', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (198, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:33:03', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (199, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:33:25', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (200, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:33:49', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (201, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:42:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (202, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:48:45', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (203, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 01:48:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (204, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:19:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (205, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:20:14', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (206, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:27:36', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (207, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:27:51', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (208, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:28:06', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (209, 'IMPORT', '敏感词设置', '导入敏感词 0 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:33:35', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (210, 'IMPORT', '敏感词设置', '导入敏感词 5749 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:33:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (211, 'IMPORT', '敏感词设置', '导入敏感词 139 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:34:03', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (212, 'IMPORT', '敏感词设置', '导入敏感词 933 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:34:09', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (213, 'IMPORT', '敏感词设置', '导入敏感词 464 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:34:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (214, 'IMPORT', '敏感词设置', '导入敏感词 14592 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:34:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (215, 'IMPORT', '敏感词设置', '导入敏感词 94 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:35:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (216, 'IMPORT', '敏感词设置', '导入敏感词 21122 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:36:04', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (217, 'IMPORT', '敏感词设置', '导入敏感词 0 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:36:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (218, 'IMPORT', '敏感词设置', '导入敏感词 0 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:36:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (219, 'IMPORT', '敏感词设置', '导入敏感词 167 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:36:35', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (220, 'IMPORT', '敏感词设置', '导入敏感词 7147 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:36:58', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (221, 'IMPORT', '敏感词设置', '导入敏感词 14 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:37:14', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (222, 'IMPORT', '敏感词设置', '导入敏感词 7 条', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:37:20', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (223, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:43:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (224, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:49:01', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (225, 'LOGIN', '登录', '用户登录', 147, '13405825198', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:54:25', 'fffbdd25-3209-4245-9d19-116e37e2a4da');
INSERT INTO `operation_logs` VALUES (226, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:57:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (227, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:58:18', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (228, 'UPDATE', '敏感词设置', '更新敏感词拦截配置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:58:38', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (229, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:58:45', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (230, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:58:51', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (231, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 03:59:20', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (232, 'UPDATE', '公告管理', '更新公告: 云计算技术发展趋势与未来展望', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:01:40', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (233, 'PUBLISH', '公告管理', '更改公告状态: 云计算技术发展趋势与未来展望', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:03:19', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (234, 'UPDATE', '公告管理', '更新公告: 云计算技术发展趋势与未来展望', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:03:49', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (235, 'WITHDRAW', '公告管理', '更改公告状态: 云计算技术发展趋势与未来展望', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:03:53', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (236, 'PUBLISH', '公告管理', '更改公告状态: 云计算技术发展趋势与未来展望', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:03:53', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (237, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:08:52', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (238, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 04:09:05', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (239, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 13:32:40', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (240, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 14:15:51', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (241, 'LOGIN', '登录', '用户登录', 147, '13405825198', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 17:06:49', 'fffbdd25-3209-4245-9d19-116e37e2a4da');
INSERT INTO `operation_logs` VALUES (242, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 17:13:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (243, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 21:43:14', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (244, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 21:43:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (245, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:20:45', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (246, 'UPDATE', '敏感词设置', '更新敏感词拦截配置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:20:58', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (247, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:21:12', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (248, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:21:23', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (249, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:29:41', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (250, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:31:31', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (251, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:31:39', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (252, 'UPDATE', '敏感词设置', '更新敏感词拦截配置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:32:28', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (253, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:32:39', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (254, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:48:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (255, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:48:30', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (256, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:48:35', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (257, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:49:23', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (258, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:54:12', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (259, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:54:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (260, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-09 22:54:20', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (261, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-13 00:17:12', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (262, 'UPDATE', '菜单管理', '初始化默认菜单: 27项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-13 00:17:37', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (263, 'UPDATE', '菜单管理', '更新菜单: 在线用户 (SystemMonitorOnlineUser)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-13 00:17:55', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (271, 'UPDATE', '菜单管理', '调整菜单顺序', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-13 00:20:30', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (272, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:21:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (273, 'DELETE', '菜单管理', '删除菜单: 打印模板 (ExamplePrint)（含子节点）', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:21:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (274, 'DELETE', '用户管理', '删除用户: 13405825198', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:21:42', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (275, 'DELETE', '用户管理', '删除用户: grace', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:21:46', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (276, 'DELETE', '用户管理', '删除用户: frank', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:21:51', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (277, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:23:32', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (278, 'DELETE', '文件下载', '删除文件: 学历证明（模板）', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:32:10', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (279, 'DELETE', '文件下载', '删除文件: 南京市劳动合同书（2015修订版）', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:32:12', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (280, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 15:44:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (281, 'CREATE', '用户管理', '创建用户: 11111', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 16:12:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (282, 'DELETE', '用户管理', '删除用户: 11111', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 16:19:15', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (283, 'UPDATE', '菜单管理', '调整菜单顺序', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 16:22:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (284, 'CREATE', '文件下载', '新增文件: aaa', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Edge', '2026-01-17 16:22:47', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (285, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:15:48', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (286, 'DELETE', '文件下载', '删除文件: aaa', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:16:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (287, 'UPDATE', '菜单管理', '更新菜单: Redis监控 (SystemMonitorRedis)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:18:49', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (288, 'UPDATE', '菜单管理', '更新菜单: 示例页面 (example)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:19:11', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (289, 'DELETE', '用户管理', '删除用户: alice', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:20:19', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (290, 'DELETE', '用户管理', '删除用户: bob', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:20:21', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (291, 'DELETE', '用户管理', '删除用户: carol', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:20:22', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (292, 'DELETE', '用户管理', '删除用户: david', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:20:24', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (293, 'DELETE', '用户管理', '删除用户: emma', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:20:26', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (294, 'DELETE', '角色管理', '删除角色: user', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:20:41', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (295, 'UPDATE', '水印设置', '更新水印配置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-17 17:27:04', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (296, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 14:25:31', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (297, 'UPDATE', '菜单管理', '更新菜单: 文件下载 (console)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:38:30', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (298, 'UPDATE', '菜单管理', '更新菜单: 公告管理 (announcement)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:38:40', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (299, 'UPDATE', '菜单管理', '更新菜单: 敏感词拦截 (SystemSensitive)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:38:47', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (300, 'UPDATE', '菜单管理', '更新菜单: AI设置 (SystemAi)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:38:55', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (301, 'UPDATE', '菜单管理', '更新菜单: 接口文档 (SwaggerUI)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:39:50', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (302, 'UPDATE', '菜单管理', '更新菜单: 验证设置 (SystemVerification)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:40:36', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (303, 'UPDATE', '菜单管理', '更新菜单: 安全设置 (SystemSecurity)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:41:04', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (304, 'UPDATE', '菜单管理', '更新菜单: 对象存储 (SystemStorage)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:41:35', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (305, 'UPDATE', '个人资料', '更新个人资料', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 15:43:42', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (306, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 22:33:41', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (307, 'UPDATE', '菜单管理', '更新菜单: 验证设置 (SystemVerification)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 22:36:25', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (308, 'UPDATE', '菜单管理', '更新菜单: 验证设置 (SystemVerification)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 22:36:35', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (309, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:32:04', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (310, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:36:30', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (311, 'UPDATE', '菜单管理', '更新菜单: 示例页面 (example)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:37:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (312, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:37:08', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (313, 'UPDATE', '菜单管理', '更新菜单: 示例页面 (example)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:37:10', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (314, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:43:30', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (315, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:44:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (316, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:49:01', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (317, 'UPDATE', '菜单管理', '初始化默认菜单: 26项', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-18 23:53:33', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (318, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 00:42:15', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (319, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 10:47:51', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (320, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 10:57:55', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (321, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 11:04:27', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (322, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 11:24:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (323, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 11:59:50', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (324, 'UPDATE', '菜单管理', '更新菜单: 系统监控 (SystemMonitor)', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 12:08:33', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (325, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 12:12:34', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (326, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 12:17:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (327, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Unknown', '2026-01-19 12:28:06', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (328, 'LOGIN', '登录', '用户登录', 148, 'admin3', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Unknown', '2026-01-19 12:29:48', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');
INSERT INTO `operation_logs` VALUES (329, 'LOGIN', '登录', '用户登录', 148, 'admin3', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Unknown', '2026-01-19 12:31:34', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');
INSERT INTO `operation_logs` VALUES (330, 'LOGIN', '登录', '用户登录', 148, 'admin3', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Unknown', '2026-01-19 12:32:16', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');
INSERT INTO `operation_logs` VALUES (331, 'LOGIN', '登录', '用户登录', 148, 'admin3', '127.0.0.1', '未知设备', 'Unknown', 'Unknown', '2026-01-19 12:36:35', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');
INSERT INTO `operation_logs` VALUES (332, 'LOGIN', '登录', '用户登录', 148, 'admin3', '127.0.0.1', '未知设备', 'Unknown', 'Unknown', '2026-01-19 12:39:58', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');
INSERT INTO `operation_logs` VALUES (333, 'LOGIN', '登录', '用户登录', 148, 'admin3', '127.0.0.1', '未知设备', 'Unknown', 'Unknown', '2026-01-19 12:43:18', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');
INSERT INTO `operation_logs` VALUES (334, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 12:47:03', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (335, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Unknown', '2026-01-19 15:38:11', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (336, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Unknown', '2026-01-19 15:45:53', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (337, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 15:50:15', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (338, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 16:15:41', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (339, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 16:39:47', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (340, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 17:14:01', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (341, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 18:36:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (342, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 20:13:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (343, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 20:20:57', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (344, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-19 20:25:40', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (345, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 13:03:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (346, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 17:23:52', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (347, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 18:28:41', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (348, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 18:30:52', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (349, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 18:37:46', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (350, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 18:37:52', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (351, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 18:37:53', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (352, 'UPDATE', '系统设置', '更新系统个性化设置', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-21 18:38:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (353, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-22 01:48:44', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (354, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-22 02:11:57', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (355, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-22 02:24:50', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (356, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-22 02:31:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (357, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-22 13:48:28', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (358, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 01:56:22', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (359, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 12:18:16', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (360, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 12:27:49', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (361, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 12:28:54', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (362, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 12:39:02', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (363, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 12:45:56', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (364, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 13:02:20', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (365, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 13:42:05', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (366, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-23 22:34:00', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (367, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-24 01:37:34', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (368, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-24 20:20:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (369, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-24 21:41:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `operation_logs` VALUES (370, 'LOGIN', '登录', '用户登录', 1, 'admin', '127.0.0.1', 'Windows 设备', 'Windows 10', 'Chrome', '2026-01-25 01:21:29', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');

-- ----------------------------
-- Table structure for order_timelines
-- ----------------------------
DROP TABLE IF EXISTS `order_timelines`;
CREATE TABLE `order_timelines`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作人ID',
  `operator_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人名称',
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '动作类型',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '显示内容',
  `meta_data` json NULL COMMENT '元数据',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单时间轴/日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_timelines
-- ----------------------------
INSERT INTO `order_timelines` VALUES (1, 1, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-19 16:16:44');
INSERT INTO `order_timelines` VALUES (2, 2, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-19 16:40:06');
INSERT INTO `order_timelines` VALUES (3, 3, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-19 16:52:46');
INSERT INTO `order_timelines` VALUES (4, 4, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-19 18:42:25');
INSERT INTO `order_timelines` VALUES (5, 5, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-19 18:43:23');
INSERT INTO `order_timelines` VALUES (6, 6, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-21 18:52:50');
INSERT INTO `order_timelines` VALUES (7, 7, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-21 19:39:09');
INSERT INTO `order_timelines` VALUES (8, 8, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-21 19:39:49');
INSERT INTO `order_timelines` VALUES (9, 9, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-21 23:52:04');
INSERT INTO `order_timelines` VALUES (10, 9, 1, '系统/管理员', '分配打手', '已分配给打手: 小放', NULL, '2026-01-22 02:31:33');
INSERT INTO `order_timelines` VALUES (11, 9, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-22 14:00:53');
INSERT INTO `order_timelines` VALUES (12, 9, 1, '系统/管理员', '分配打手', '已分配给打手: 小等', NULL, '2026-01-22 14:40:19');
INSERT INTO `order_timelines` VALUES (13, 9, 1, '系统/管理员', '分配打手', '已分配给打手: 小放', NULL, '2026-01-22 14:43:23');
INSERT INTO `order_timelines` VALUES (14, 9, 1, '系统/管理员', '分配打手', '已分配给打手: 小果', NULL, '2026-01-22 14:50:23');
INSERT INTO `order_timelines` VALUES (15, 9, 1, '系统/管理员', '分配打手', '已分配给打手: 小等', NULL, '2026-01-22 15:05:13');
INSERT INTO `order_timelines` VALUES (16, 9, 1, '系统/管理员', '分配打手', '已分配给打手: 小结', NULL, '2026-01-22 15:05:49');
INSERT INTO `order_timelines` VALUES (17, 9, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-22 16:40:52');
INSERT INTO `order_timelines` VALUES (18, 8, 1, '系统/管理员', '分配打手', '已分配给打手: 小果', NULL, '2026-01-22 16:49:34');
INSERT INTO `order_timelines` VALUES (19, 8, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-22 17:12:54');
INSERT INTO `order_timelines` VALUES (20, 7, 1, '系统/管理员', '分配打手', '已分配给打手: 小等', NULL, '2026-01-22 17:39:59');
INSERT INTO `order_timelines` VALUES (21, 7, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-22 18:17:46');
INSERT INTO `order_timelines` VALUES (22, 6, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-22 19:18:44');
INSERT INTO `order_timelines` VALUES (23, 10, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-22 20:12:14');
INSERT INTO `order_timelines` VALUES (24, 6, 1, '用户/打手', '申请售后', '发起售后申请，资金已冻结', NULL, '2026-01-22 20:50:43');
INSERT INTO `order_timelines` VALUES (25, 6, 1, '系统/管理员', '分配打手', '已分配给打手: 小果', NULL, '2026-01-22 22:47:26');
INSERT INTO `order_timelines` VALUES (26, 6, 1, '系统/管理员', '分配打手', '已分配给打手: 小松', NULL, '2026-01-22 23:04:53');
INSERT INTO `order_timelines` VALUES (27, 6, 1, '管理员', '售后判决', '售后已判决，资金已分配', NULL, '2026-01-22 23:08:00');
INSERT INTO `order_timelines` VALUES (28, 6, 1, '系统/管理员', '分配打手', '已分配给打手: 小放', NULL, '2026-01-23 00:19:32');
INSERT INTO `order_timelines` VALUES (29, 6, 1, '系统/管理员', '分配打手', '已分配给打手: 小果', NULL, '2026-01-23 01:29:01');
INSERT INTO `order_timelines` VALUES (30, 6, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-23 01:49:11');
INSERT INTO `order_timelines` VALUES (31, 10, 1, '系统/管理员', '分配打手', '已分配给打手: 小松 (白白)', '{\"name\": \"小松\", \"nickname\": \"白白\", \"boosterId\": 4}', '2026-01-23 01:58:40');
INSERT INTO `order_timelines` VALUES (32, 10, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-23 01:59:08');
INSERT INTO `order_timelines` VALUES (33, 6, 1, '系统/管理员', '更换打手', '新打手：小结 (而非)', '{\"name\": \"小结\", \"nickname\": \"而非\", \"boosterId\": 6}', '2026-01-23 13:58:02');
INSERT INTO `order_timelines` VALUES (34, 11, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-23 22:12:34');
INSERT INTO `order_timelines` VALUES (35, 12, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-23 22:26:51');
INSERT INTO `order_timelines` VALUES (36, 13, 1, '系统', '订单创建', '客户已下单，等待接单', NULL, '2026-01-23 22:27:32');
INSERT INTO `order_timelines` VALUES (37, 13, 1, '系统/管理员', '分配打手', '已分配给打手: 小高 (等等)', '{\"name\": \"小高\", \"nickname\": \"等等\", \"boosterId\": 14}', '2026-01-23 22:34:50');
INSERT INTO `order_timelines` VALUES (38, 13, 1, '系统/管理员', '更换打手', '新打手：小高 (等等)', '{\"name\": \"小高\", \"nickname\": \"等等\", \"boosterId\": 14}', '2026-01-24 01:09:02');
INSERT INTO `order_timelines` VALUES (39, 13, 1, '系统/管理员', '更换打手', '新打手：小红 (水水)', '{\"name\": \"小红\", \"nickname\": \"水水\", \"boosterId\": 11}', '2026-01-24 01:09:14');
INSERT INTO `order_timelines` VALUES (40, 13, 1, '系统/管理员', '更换打手', '新打手：小都 (嘟嘟)', '{\"name\": \"小都\", \"nickname\": \"嘟嘟\", \"boosterId\": 10}', '2026-01-24 01:09:18');
INSERT INTO `order_timelines` VALUES (41, 13, 1, '系统/管理员', '更换打手', '新打手：小看 (帆帆)', '{\"name\": \"小看\", \"nickname\": \"帆帆\", \"boosterId\": 13}', '2026-01-24 01:20:38');
INSERT INTO `order_timelines` VALUES (42, 13, 1, '系统/管理员', '更换打手', '新打手：小绿 (哈哈)', '{\"name\": \"小绿\", \"nickname\": \"哈哈\", \"boosterId\": 12}', '2026-01-24 01:24:44');
INSERT INTO `order_timelines` VALUES (43, 13, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-24 01:40:01');
INSERT INTO `order_timelines` VALUES (44, 12, 1, '系统/管理员', '分配打手', '已分配给打手: 小看 (帆帆)', '{\"name\": \"小看\", \"nickname\": \"帆帆\", \"boosterId\": 13}', '2026-01-24 21:12:13');
INSERT INTO `order_timelines` VALUES (45, 12, 1, '用户/打手', '申请售后', '发起售后申请，资金已冻结', NULL, '2026-01-24 21:12:46');
INSERT INTO `order_timelines` VALUES (46, 12, 1, '管理员', '售后判决', '售后已判决，资金已分配', NULL, '2026-01-24 21:12:58');
INSERT INTO `order_timelines` VALUES (47, 11, 1, '系统/管理员', '分配打手', '已分配给打手: 小红 (水水)', '{\"name\": \"小红\", \"nickname\": \"水水\", \"boosterId\": 11}', '2026-01-24 21:42:50');
INSERT INTO `order_timelines` VALUES (48, 11, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-24 21:43:28');
INSERT INTO `order_timelines` VALUES (49, 12, 1, '系统/管理员', '更换打手', '新打手：小高 (等等)', '{\"name\": \"小高\", \"nickname\": \"等等\", \"boosterId\": 14}', '2026-01-24 22:14:33');
INSERT INTO `order_timelines` VALUES (50, 12, 1, '系统/管理员', '订单完成', '订单已完成，系统自动生成结算', NULL, '2026-01-24 22:14:39');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单标题',
  `customer_id` bigint NULL DEFAULT NULL COMMENT '客户ID',
  `booster_id` bigint NULL DEFAULT NULL COMMENT '打手ID',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单金额',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING' COMMENT '订单状态',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '订单描述',
  `region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区服',
  `game_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_mode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏模式',
  `account_username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏账号',
  `account_password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏密码',
  `game_meta_data` json NULL COMMENT '游戏元数据',
  `proof_images` json NULL COMMENT '证据图片',
  `deadline_time` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `is_paused` tinyint(1) NULL DEFAULT 0 COMMENT '是否暂停',
  `pause_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '暂停原因',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `customer_phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户手机号',
  `customer_wechat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户微信号',
  `customer_qq` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户QQ号',
  `customer_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户来源',
  `xianyu_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `game_uid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '游戏UID',
  `game_rank` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '当前段位',
  `ban_record` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '封号记录',
  `special_requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '特殊要求',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (11, 'ORD20260123221234532', '订单 20260123221234', 1, 11, 228.00, 'COMPLETED', '上的公使馆升格', 'QQ区', '跑刀', '烽火地带', 'aaaaaa', '1234567', '{\"targetAssets\": \"44444w\"}', NULL, NULL, 0, NULL, '', '13448887993', '3343332', '33444444', '抖音', '443646457474', '上的广告', '55w', '0', '', '2026-01-23 22:12:34', '2026-01-24 21:43:27');
INSERT INTO `orders` VALUES (12, 'ORD20260123222650426', '订单 20260123222650', 1, 14, 88.00, 'COMPLETED', '我无法是各个', 'QQ区', '跑刀', '烽火地带', 'aaaaaa', '111111', '{\"targetAssets\": \"4444444\"}', NULL, NULL, 0, NULL, '', '13444555566', '2442421113', '4353434', '抖音', '3452345636464', '返回小孩子的', '44', '', '', '2026-01-23 22:26:51', '2026-01-24 22:14:38');
INSERT INTO `orders` VALUES (13, 'ORD20260123222732910', '订单 20260123222732', 1, 12, 788.00, 'COMPLETED', '', 'QQ区', '跑刀', '烽火地带', 'aaaaaa', 'ssssssss', '{\"targetAssets\": \"44555\"}', '[\"/api/files/AXRuWTFyGcKTwhrLraflY5tV9jfQRo0e5bpxvIkh0w90EFhrihmarEghs98Fpb8vYASPO_ip7t4Q3gZAlf0TTHChJ1t68NL7syY_jHNZGEFDlzBGxNXni_shBFHQmMf4PmNMYyZ-v4La1tvTj1lU-2NhtWextYjY4nx0tg\"]', NULL, 0, NULL, '', '132222222222', 'sdgzdb', '2443435433', '抖音', '4536536535', '公司的各个', '44', '', '', '2026-01-23 22:27:32', '2026-01-24 01:40:00');

-- ----------------------------
-- Table structure for role_menus
-- ----------------------------
DROP TABLE IF EXISTS `role_menus`;
CREATE TABLE `role_menus`  (
  `role_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_menus
-- ----------------------------
INSERT INTO `role_menus` VALUES (1, 910);
INSERT INTO `role_menus` VALUES (1, 911);
INSERT INTO `role_menus` VALUES (1, 1000);
INSERT INTO `role_menus` VALUES (1, 1001);
INSERT INTO `role_menus` VALUES (1, 1002);
INSERT INTO `role_menus` VALUES (1, 1003);
INSERT INTO `role_menus` VALUES (1, 1004);
INSERT INTO `role_menus` VALUES (1, 1005);
INSERT INTO `role_menus` VALUES (1, 1006);
INSERT INTO `role_menus` VALUES (1, 1007);
INSERT INTO `role_menus` VALUES (1, 1013);
INSERT INTO `role_menus` VALUES (1, 1018);
INSERT INTO `role_menus` VALUES (1, 1019);
INSERT INTO `role_menus` VALUES (1, 1020);
INSERT INTO `role_menus` VALUES (1, 1021);
INSERT INTO `role_menus` VALUES (1, 1022);
INSERT INTO `role_menus` VALUES (1, 1023);
INSERT INTO `role_menus` VALUES (1, 1030);
INSERT INTO `role_menus` VALUES (1, 1031);
INSERT INTO `role_menus` VALUES (1, 1032);
INSERT INTO `role_menus` VALUES (1, 1034);
INSERT INTO `role_menus` VALUES (1, 1035);
INSERT INTO `role_menus` VALUES (1, 1036);
INSERT INTO `role_menus` VALUES (1, 1037);
INSERT INTO `role_menus` VALUES (1, 1038);
INSERT INTO `role_menus` VALUES (1, 1039);
INSERT INTO `role_menus` VALUES (1, 1040);
INSERT INTO `role_menus` VALUES (1, 1041);
INSERT INTO `role_menus` VALUES (2, 911);
INSERT INTO `role_menus` VALUES (2, 1018);
INSERT INTO `role_menus` VALUES (2, 1031);
INSERT INTO `role_menus` VALUES (2, 1032);

-- ----------------------------
-- Table structure for role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions`  (
  `role_id` bigint NOT NULL,
  `permission` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`role_id`, `permission`) USING BTREE,
  CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_permissions
-- ----------------------------
INSERT INTO `role_permissions` VALUES (1, 'system:announcement:create');
INSERT INTO `role_permissions` VALUES (1, 'system:announcement:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:announcement:query');
INSERT INTO `role_permissions` VALUES (1, 'system:announcement:update');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementCards:create');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementCards:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementCards:query');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementCards:update');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementTable:create');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementTable:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementTable:query');
INSERT INTO `role_permissions` VALUES (1, 'system:AnnouncementTable:update');
INSERT INTO `role_permissions` VALUES (1, 'system:ConsoleDownload:create');
INSERT INTO `role_permissions` VALUES (1, 'system:ConsoleDownload:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:ConsoleDownload:query');
INSERT INTO `role_permissions` VALUES (1, 'system:ConsoleDownload:update');
INSERT INTO `role_permissions` VALUES (1, 'system:example:create');
INSERT INTO `role_permissions` VALUES (1, 'system:example:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:example:query');
INSERT INTO `role_permissions` VALUES (1, 'system:example:update');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleGoods:create');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleGoods:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleGoods:query');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleGoods:update');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleOrder:create');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleOrder:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleOrder:query');
INSERT INTO `role_permissions` VALUES (1, 'system:ExampleOrder:update');
INSERT INTO `role_permissions` VALUES (1, 'system:ExamplePrint:query');
INSERT INTO `role_permissions` VALUES (1, 'system:MessageSend:create');
INSERT INTO `role_permissions` VALUES (1, 'system:MessageSend:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:MessageSend:query');
INSERT INTO `role_permissions` VALUES (1, 'system:MessageSend:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SwaggerUI:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SwaggerUI:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SwaggerUI:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SwaggerUI:update');
INSERT INTO `role_permissions` VALUES (1, 'system:system:create');
INSERT INTO `role_permissions` VALUES (1, 'system:system:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:system:query');
INSERT INTO `role_permissions` VALUES (1, 'system:system:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemAi:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemAi:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemAi:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemAi:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemLog:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemLog:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemLog:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemLog:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMenu:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMenu:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMenu:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMenu:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitor:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitor:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitor:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitor:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorDruid:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorOnlineUser:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorOnlineUser:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorOnlineUser:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorOnlineUser:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorRedis:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorRedis:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorRedis:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorRedis:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorServer:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorServer:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorServer:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemMonitorServer:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemPersonalize:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemPersonalize:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemPersonalize:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemPersonalize:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemRole:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemRole:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemRole:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemRole:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemSecurity:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemSecurity:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemSensitive:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemSensitive:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemSensitive:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemSensitive:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemStorage:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemStorage:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemUser:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemUser:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemUser:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemUser:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemVerification:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemVerification:update');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemWatermark:create');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemWatermark:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemWatermark:query');
INSERT INTO `role_permissions` VALUES (1, 'system:SystemWatermark:update');
INSERT INTO `role_permissions` VALUES (1, 'system:user:create');
INSERT INTO `role_permissions` VALUES (1, 'system:user:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:user:query');
INSERT INTO `role_permissions` VALUES (1, 'system:user:update');
INSERT INTO `role_permissions` VALUES (1, 'system:UserIndex:create');
INSERT INTO `role_permissions` VALUES (1, 'system:UserIndex:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:UserIndex:query');
INSERT INTO `role_permissions` VALUES (1, 'system:UserIndex:update');
INSERT INTO `role_permissions` VALUES (1, 'system:users:create');
INSERT INTO `role_permissions` VALUES (1, 'system:users:delete');
INSERT INTO `role_permissions` VALUES (1, 'system:users:query');
INSERT INTO `role_permissions` VALUES (1, 'system:users:update');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'admin', '管理员 - 拥有所有权限');

-- ----------------------------
-- Table structure for security_captcha_settings
-- ----------------------------
DROP TABLE IF EXISTS `security_captcha_settings`;
CREATE TABLE `security_captcha_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `captcha_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `drag_captcha_width` int NULL DEFAULT NULL,
  `drag_captcha_height` int NULL DEFAULT NULL,
  `drag_captcha_threshold` int NULL DEFAULT NULL,
  `image_captcha_length` int NULL DEFAULT NULL,
  `image_captcha_noise_lines` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of security_captcha_settings
-- ----------------------------
INSERT INTO `security_captcha_settings` VALUES (1, 'drag', 350, 200, 98, 5, 8);

-- ----------------------------
-- Table structure for security_password_policy
-- ----------------------------
DROP TABLE IF EXISTS `security_password_policy`;
CREATE TABLE `security_password_policy`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password_min_length` int NULL DEFAULT NULL,
  `password_require_uppercase` tinyint NULL DEFAULT NULL,
  `password_require_lowercase` tinyint NULL DEFAULT NULL,
  `password_require_special` tinyint NULL DEFAULT NULL,
  `password_allow_sequential` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of security_password_policy
-- ----------------------------
INSERT INTO `security_password_policy` VALUES (1, 6, 1, 1, 1, 1);

-- ----------------------------
-- Table structure for security_settings
-- ----------------------------
DROP TABLE IF EXISTS `security_settings`;
CREATE TABLE `security_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_timeout_minutes` int NULL DEFAULT NULL,
  `token_timeout_minutes` int NULL DEFAULT NULL,
  `token_refresh_grace_minutes` int NULL DEFAULT NULL,
  `captcha_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `drag_captcha_width` int NULL DEFAULT NULL,
  `drag_captcha_height` int NULL DEFAULT NULL,
  `drag_captcha_threshold` int NULL DEFAULT NULL,
  `image_captcha_length` int NULL DEFAULT NULL,
  `image_captcha_noise_lines` int NULL DEFAULT NULL,
  `password_min_length` int NULL DEFAULT NULL,
  `password_require_uppercase` tinyint NULL DEFAULT NULL,
  `password_require_lowercase` tinyint NULL DEFAULT NULL,
  `password_require_special` tinyint NULL DEFAULT NULL,
  `password_allow_sequential` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of security_settings
-- ----------------------------
INSERT INTO `security_settings` VALUES (1, 1440, 1440, 60, 'drag', 350, 200, 98, 5, 8, 6, 1, 1, 1, 1);

-- ----------------------------
-- Table structure for security_token_settings
-- ----------------------------
DROP TABLE IF EXISTS `security_token_settings`;
CREATE TABLE `security_token_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_timeout_minutes` int NULL DEFAULT NULL,
  `token_timeout_minutes` int NULL DEFAULT NULL,
  `token_refresh_grace_minutes` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of security_token_settings
-- ----------------------------
INSERT INTO `security_token_settings` VALUES (1, 1440, 1440, 60);

-- ----------------------------
-- Table structure for sensitive_page_settings
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_page_settings`;
CREATE TABLE `sensitive_page_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `page_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `page_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `page_key`(`page_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sensitive_page_settings
-- ----------------------------
INSERT INTO `sensitive_page_settings` VALUES (1, 'goods', '示例页面 / 商品管理', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (2, 'order', '示例页面 / 订单管理', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (3, 'online-user', '系统监控 / 在线用户', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (4, 'server', '系统监控 / 服务监控', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (5, 'redis', '系统监控 / Redis监控', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (6, 'index', '个人中心 / 个人中心', 1, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (7, 'menu', '系统设置 / 目录/页面管理', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (8, 'personalize', '系统设置 / 个性化设置', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (9, 'storage', '系统设置 / 对象存储', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (10, 'verification', '系统设置 / 验证设置', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (11, 'security', '系统设置 / 安全设置', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (12, 'sensitive', '系统设置 / 敏感词拦截', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (13, 'ai', '系统设置 / AI设置', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (14, 'user', '用户设置 / 用户管理', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (15, 'role', '用户设置 / 角色管理', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (16, 'log', '用户设置 / 操作日志', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (17, 'table', '公告管理 / 公告列表', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (18, 'cards', '公告管理 / 公告卡片', 0, '2026-01-09 03:58:38', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (19, '/example/goods', '示例页面 / 商品管理', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (20, '/example/order', '示例页面 / 订单管理', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (21, '/monitor/online-user', '系统监控 / 在线用户', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (22, '/monitor/server', '系统监控 / 服务监控', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (23, '/monitor/redis', '系统监控 / Redis监控', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (24, '/user/index', '个人中心 / 个人中心', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (25, '/system/menu', '系统设置 / 目录/页面管理', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (26, '/system/personalize', '系统设置 / 个性化设置', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (27, '/system/storage', '系统设置 / 对象存储', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (28, '/system/verification', '系统设置 / 验证设置', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (29, '/system/security', '系统设置 / 安全设置', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (30, '/system/sensitive', '系统设置 / 敏感词拦截', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (31, '/system/ai', '系统设置 / AI设置', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (32, '/user-settings/user', '用户设置 / 用户管理', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (33, '/user-settings/role', '用户设置 / 角色管理', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (34, '/user-settings/log', '用户设置 / 操作日志', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (35, '/announcement/table', '公告管理 / 公告列表', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');
INSERT INTO `sensitive_page_settings` VALUES (36, '/announcement/cards', '公告管理 / 公告卡片', 0, '2026-01-09 22:20:58', '2026-01-09 22:32:28');

-- ----------------------------
-- Table structure for sensitive_settings
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_settings`;
CREATE TABLE `sensitive_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `enabled` tinyint NOT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sensitive_settings
-- ----------------------------
INSERT INTO `sensitive_settings` VALUES (1, 0, '2026-01-09 22:32:28');

-- ----------------------------
-- Table structure for sensitive_words
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_words`;
CREATE TABLE `sensitive_words`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `word` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `enabled` tinyint NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `word`(`word` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sensitive_words
-- ----------------------------

-- ----------------------------
-- Table structure for settlements
-- ----------------------------
DROP TABLE IF EXISTS `settlements`;
CREATE TABLE `settlements`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联订单号',
  `booster_id` bigint NOT NULL COMMENT '打手ID',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `booster_amount` decimal(10, 2) NOT NULL COMMENT '打手应得金额',
  `platform_amount` decimal(10, 2) NOT NULL COMMENT '平台抽成',
  `ratio` decimal(4, 2) NOT NULL DEFAULT 0.80 COMMENT '分成比例',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING' COMMENT '状态: PENDING(冻结), SETTLED(已入账), CANCELLED(已取消), PAUSED(暂停)',
  `settle_time` datetime NULL DEFAULT NULL COMMENT '预计结算时间',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_booster_id`(`booster_id` ASC) USING BTREE,
  INDEX `idx_order_no`(`order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '结算记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settlements
-- ----------------------------
INSERT INTO `settlements` VALUES (1, 'ORD20260121235203448', 8, 555.00, 444.00, 111.00, 0.80, 'PENDING', '2026-01-29 14:00:53', '2026-01-22 14:00:53', '2026-01-22 14:00:53');
INSERT INTO `settlements` VALUES (2, 'ORD20260121235203448', 6, 555.00, 444.00, 111.00, 0.80, 'PENDING', '2026-01-29 16:40:52', '2026-01-22 16:40:52', '2026-01-22 16:40:52');
INSERT INTO `settlements` VALUES (3, 'ORD20260121193949811', 7, 88.00, 70.40, 17.60, 0.80, 'PENDING', '2026-01-29 17:12:54', '2026-01-22 17:12:54', '2026-01-22 17:12:54');
INSERT INTO `settlements` VALUES (4, 'ORD20260121193909085', 5, 56.00, 44.80, 11.20, 0.80, 'PENDING', '2026-01-29 18:17:46', '2026-01-22 18:17:46', '2026-01-22 18:17:46');
INSERT INTO `settlements` VALUES (5, 'ORD20260121185249495', 7, 49.00, 39.20, 9.80, 0.80, 'PENDING', '2026-01-30 01:49:11', '2026-01-23 01:49:11', '2026-01-23 01:49:11');
INSERT INTO `settlements` VALUES (6, 'ORD20260122201214696', 4, 66.00, 52.80, 13.20, 0.80, 'PENDING', '2026-01-30 01:59:08', '2026-01-23 01:59:08', '2026-01-23 01:59:08');
INSERT INTO `settlements` VALUES (7, 'ORD20260123222732910', 12, 788.00, 630.40, 157.60, 0.80, 'PENDING', '2026-01-31 01:40:01', '2026-01-24 01:40:01', '2026-01-24 01:40:01');
INSERT INTO `settlements` VALUES (8, 'ORD20260123221234532', 11, 228.00, 182.40, 45.60, 0.80, 'PENDING', '2026-01-31 21:43:28', '2026-01-24 21:43:28', '2026-01-24 21:43:28');
INSERT INTO `settlements` VALUES (9, 'ORD20260123222650426', 14, 88.00, 70.40, 17.60, 0.80, 'PENDING', '2026-01-31 22:14:39', '2026-01-24 22:14:39', '2026-01-24 22:14:39');

-- ----------------------------
-- Table structure for storage_settings
-- ----------------------------
DROP TABLE IF EXISTS `storage_settings`;
CREATE TABLE `storage_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `bucket` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `region` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `access_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `secret_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `custom_domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `path_prefix` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `public_read` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storage_settings
-- ----------------------------
INSERT INTO `storage_settings` VALUES (1, 'LOCAL', NULL, NULL, NULL, NULL, 'zz', NULL, NULL, 1);

-- ----------------------------
-- Table structure for sys_menu_items
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_items`;
CREATE TABLE `sys_menu_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NULL DEFAULT NULL,
  `node_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `route_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title_zh_cn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title_en_us` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hidden` tinyint NOT NULL DEFAULT 0,
  `keep_alive` tinyint NOT NULL DEFAULT 1,
  `frame_src` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `frame_blank` tinyint NOT NULL DEFAULT 0,
  `enabled` tinyint NOT NULL DEFAULT 1,
  `require_role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `require_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `order_no` int NOT NULL DEFAULT 0,
  `version` int NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `actions` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_sys_menu_route_name`(`route_name` ASC) USING BTREE,
  INDEX `idx_sys_menu_parent_order`(`parent_id` ASC, `order_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1045 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu_items
-- ----------------------------
INSERT INTO `sys_menu_items` VALUES (910, NULL, 'DIR', '/user', 'user', 'LAYOUT', '/user/index', '个人中心', 'User Center', 'user-safety-filled', 0, 1, NULL, 0, 1, NULL, NULL, 3, 5, '2025-12-30 23:58:19', '2026-01-17 16:22:02', 'query,create,update,delete');
INSERT INTO `sys_menu_items` VALUES (911, 910, 'PAGE', 'index', 'UserIndex', '/user/index', NULL, '个人中心', 'User Center', 'user', 0, 1, NULL, 0, 1, NULL, NULL, 0, 4, '2025-12-30 23:58:19', '2026-01-17 16:22:02', 'query,create,update,delete');
INSERT INTO `sys_menu_items` VALUES (1000, NULL, 'DIR', '/system', 'system', 'LAYOUT', NULL, '系统设置', 'System', 'setting', 0, 1, NULL, 0, 1, NULL, NULL, 6, 6, '2025-12-14 03:19:00', '2026-01-17 16:22:02', NULL);
INSERT INTO `sys_menu_items` VALUES (1001, 1019, 'PAGE', 'user', 'SystemUser', '/system/user/index', NULL, '用户管理', 'Users', 'user', 0, 1, NULL, 0, 1, 'admin', NULL, 0, 15, '2025-12-14 03:19:00', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1002, 1019, 'PAGE', 'role', 'SystemRole', '/system/role/index', NULL, '角色管理', 'Roles', 'usergroup', 0, 1, NULL, 0, 1, 'admin', NULL, 1, 11, '2025-12-14 03:19:00', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1003, 1000, 'PAGE', 'menu', 'SystemMenu', '/system/menu/index', NULL, '目录/页面管理', 'Menu Manager', 'tree-round-dot-vertical', 0, 1, NULL, 0, 1, 'admin', NULL, 0, 6, '2025-12-14 03:19:00', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1004, NULL, 'DIR', '/monitor', 'SystemMonitor', 'LAYOUT', NULL, '系统监控', 'Monitor', 'chart-bar', 0, 1, NULL, 0, 0, 'admin', NULL, 5, 14, '2025-12-16 01:38:31', '2026-01-19 12:08:32', 'query,create,update,delete');
INSERT INTO `sys_menu_items` VALUES (1005, 1000, 'PAGE', 'online-user', 'SystemMonitorOnlineUser', '/system/monitor/online-user/index', NULL, '在线用户', 'Online User', 'usergroup-add', 0, 1, NULL, 0, 1, 'admin', NULL, 7, 4, '2025-12-16 01:38:31', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1006, 1004, 'PAGE', 'server', 'SystemMonitorServer', '/system/monitor/server/index', NULL, '服务监控', 'Server Monitor', 'server', 0, 1, NULL, 0, 1, 'admin', NULL, 0, 3, '2025-12-16 03:21:37', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1007, 1004, 'PAGE', 'redis', 'SystemMonitorRedis', '/system/monitor/redis/index', NULL, 'Redis监控', 'Redis Monitor', 'chart-3d', 0, 1, NULL, 0, 0, 'admin', NULL, 1, 9, '2025-12-16 03:28:05', '2026-01-17 17:18:49', 'query,create,update,delete');
INSERT INTO `sys_menu_items` VALUES (1013, 1000, 'PAGE', 'personalize', 'SystemPersonalize', '/system/personalize/index', NULL, '个性化设置', 'Personalize', 'setting-1', 0, 1, NULL, 0, 1, NULL, NULL, 1, 6, '2025-12-14 03:19:00', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1018, 1019, 'PAGE', 'log', 'SystemLog', '/system/log/index', NULL, '操作日志', 'Operation Logs', 'file', 0, 1, NULL, 0, 1, 'admin', NULL, 2, 5, '2025-12-29 14:21:55', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1019, NULL, 'DIR', '/user-settings', 'users', 'LAYOUT', NULL, '用户设置', NULL, 'usergroup', 0, 1, NULL, 0, 1, NULL, NULL, 4, 6, '2025-12-29 20:45:20', '2026-01-17 16:22:02', NULL);
INSERT INTO `sys_menu_items` VALUES (1020, 1004, 'PAGE', 'swagger', 'SwaggerUI', 'IFRAME', NULL, '接口文档', 'API Docs', 'api', 0, 1, '/api/swagger-ui/index.html', 0, 0, NULL, NULL, 2, 5, '2025-12-29 21:40:49', '2026-01-18 15:39:49', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1021, 1000, 'PAGE', 'storage', 'SystemStorage', '/system/storage/index', NULL, '对象存储', 'Object Storage', 'cloud-upload', 0, 1, NULL, 0, 0, NULL, NULL, 2, 5, '2025-12-31 05:05:00', '2026-01-18 15:41:34', 'update,query');
INSERT INTO `sys_menu_items` VALUES (1022, 1000, 'PAGE', 'verification', 'SystemVerification', '/system/verification/index', NULL, '验证设置', 'Verification', 'check-circle', 0, 1, NULL, 0, 0, NULL, NULL, 3, 7, '2026-01-05 15:24:28', '2026-01-18 22:36:34', 'update,query');
INSERT INTO `sys_menu_items` VALUES (1023, 1000, 'PAGE', 'security', 'SystemSecurity', '/system/security/index', NULL, '安全设置', 'Security', 'lock-on', 0, 1, NULL, 0, 0, NULL, NULL, 4, 5, '2026-01-06 02:27:43', '2026-01-18 15:41:03', 'update,query');
INSERT INTO `sys_menu_items` VALUES (1030, NULL, 'DIR', '/example', 'example', 'LAYOUT', '/example/goods', '示例页面', 'Examples', 'file', 0, 1, NULL, 0, 0, 'admin', NULL, 0, 7, '2026-01-05 15:49:43', '2026-01-18 23:37:09', NULL);
INSERT INTO `sys_menu_items` VALUES (1031, 1030, 'PAGE', 'goods', 'ExampleGoods', '/example/goods/index', NULL, '商品管理', 'Goods', NULL, 0, 1, NULL, 0, 1, 'admin', NULL, 0, 3, '2026-01-05 15:49:43', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1032, 1030, 'PAGE', 'order', 'ExampleOrder', '/example/order/index', NULL, '订单管理', 'Orders', NULL, 0, 1, NULL, 0, 1, 'admin', NULL, 1, 3, '2026-01-05 15:49:43', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1034, 1000, 'PAGE', 'sensitive', 'SystemSensitive', '/system/sensitive/index', NULL, '敏感词拦截', 'Sensitive Words', 'filter', 0, 1, NULL, 0, 0, NULL, NULL, 5, 4, '2026-01-08 21:22:11', '2026-01-18 15:38:47', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1035, NULL, 'DIR', '/announcement', 'announcement', 'LAYOUT', '/announcement/table', '公告管理', 'Announcements', 'notification', 0, 1, NULL, 0, 0, NULL, NULL, 2, 4, '2026-01-08 22:43:08', '2026-01-18 15:38:39', NULL);
INSERT INTO `sys_menu_items` VALUES (1036, 1035, 'PAGE', 'table', 'AnnouncementTable', '/announcement/table/index', NULL, '公告列表', 'Announcement Table', NULL, 0, 1, NULL, 0, 1, NULL, NULL, 1, 3, '2026-01-08 22:43:20', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1037, 1035, 'PAGE', 'cards', 'AnnouncementCards', '/announcement/cards/index', NULL, '公告卡片', 'Announcement Cards', NULL, 0, 1, NULL, 0, 1, NULL, NULL, 2, 3, '2026-01-08 22:43:25', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1038, 1000, 'PAGE', 'ai', 'SystemAi', '/system/ai/index', NULL, 'AI设置', 'AI Settings', 'chat', 0, 1, NULL, 0, 0, NULL, NULL, 6, 4, '2026-01-08 22:45:58', '2026-01-18 15:38:55', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1039, 1035, 'PAGE', 'send', 'MessageSend', '/message/send/index', NULL, '消息发送', 'Message Send', NULL, 0, 1, NULL, 0, 1, NULL, NULL, 0, 3, '2026-01-08 22:43:25', '2026-01-17 16:22:02', 'create,update,delete,query');
INSERT INTO `sys_menu_items` VALUES (1040, NULL, 'DIR', '/console', 'console', 'LAYOUT', '/console/download', '文件下载', 'Console', 'download', 0, 1, NULL, 0, 0, NULL, NULL, 1, 4, '2026-01-14 02:30:00', '2026-01-18 15:38:30', NULL);
INSERT INTO `sys_menu_items` VALUES (1041, 1040, 'PAGE', 'download', 'ConsoleDownload', '/console/download/index', NULL, '文件下载', 'File Download', 'download', 0, 1, NULL, 0, 1, NULL, NULL, 0, 2, '2026-01-14 02:30:00', '2026-01-17 16:22:02', 'create,update,delete,query');

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '流水号',
  `booster_id` bigint NOT NULL COMMENT '打手ID',
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型: INCOME(订单收入), WITHDRAWAL(提现), PENALTY(罚款), BONUS(奖励), DEPOSIT(保证金)',
  `amount` decimal(10, 2) NOT NULL COMMENT '变动金额(+/-)',
  `balance_after` decimal(10, 2) NOT NULL COMMENT '变动后余额',
  `related_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联ID(订单号/提现单号)',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_booster_id`(`booster_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资金流水表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transactions
-- ----------------------------

-- ----------------------------
-- Table structure for ui_brand_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_brand_settings`;
CREATE TABLE `ui_brand_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `website_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `app_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `logo_expanded_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `logo_collapsed_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `favicon_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qr_code_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_brand_settings
-- ----------------------------
INSERT INTO `ui_brand_settings` VALUES (1, '三角洲代练接单管理系统', '1.0', '/api/files/AX5UAnw5OjGAw1k0Oh5EFK4dw-diqjp7LEU5axcjemgPtIsLoVmDh80Q-EYJx2JUn6Xj0ziSdJ5hrqpnQVsL9IiwQMbyvbC5AciSonZJ-taBF6_QSsCsURvuSzvrzkTi_cBez-Q7cTkbiomz0bvua5RB6XcUA3kezxMtldY5cB6R5R0XcRZ1Pg', '/api/files/AdaYk_j-A2ARRI_Cc5Dx3WnZZ3OvUGyfuHwqhhWag2I2EIhn0wJ_ZnhgRGsqFu7v8CpL_uhe5v_TGCV7JcLZdhUbmgmKNNdGj6L2jUaj-frej5NDsKZlUZpS5ZCbkkumZ2avMo3qPGZ6pCdUtEpe6eyGyqM4SWPzjMGEJrWcytZyYv6x2qsk6w', NULL, '/api/files/AW2kZzhbP7MhEjvI-x1xwb5hec-HBuUwVYpcwcVh5Cozaj-r6d-IuZ17TkTFAy07yj27nwOu6G3hOfS0PNTtjUxCOZv80OC8GJvKbKhZvAqzuD7XTjieVBCzabQ2cnFfpTn4VPloU3MtSNmKH_J4qF-jrxKlbVv_tfaQS2r2md2cjP09dztUMA');

-- ----------------------------
-- Table structure for ui_footer_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_footer_settings`;
CREATE TABLE `ui_footer_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `footer_company` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `footer_icp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `copyright_start_year` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_footer_settings
-- ----------------------------
INSERT INTO `ui_footer_settings` VALUES (1, 'Elexvx Inc', '苏ICP备2025160017号', '2026');

-- ----------------------------
-- Table structure for ui_layout_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_layout_settings`;
CREATE TABLE `ui_layout_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `default_home` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `show_footer` tinyint NULL DEFAULT NULL,
  `is_sidebar_compact` tinyint NULL DEFAULT NULL,
  `show_breadcrumb` tinyint NULL DEFAULT NULL,
  `menu_auto_collapsed` tinyint NULL DEFAULT NULL,
  `layout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `split_menu` tinyint NULL DEFAULT NULL,
  `side_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_footer_aside` tinyint NULL DEFAULT NULL,
  `is_sidebar_fixed` tinyint NULL DEFAULT NULL,
  `is_header_fixed` tinyint NULL DEFAULT NULL,
  `is_use_tabs_router` tinyint NULL DEFAULT NULL,
  `show_header` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_layout_settings
-- ----------------------------
INSERT INTO `ui_layout_settings` VALUES (1, '/example/goods', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ui_legal_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_legal_settings`;
CREATE TABLE `ui_legal_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_agreement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `privacy_agreement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_legal_settings
-- ----------------------------
INSERT INTO `ui_legal_settings` VALUES (1, '<h1 style=\"text-align: start;\">用户协议</h1><p style=\"text-align: start;\"><em>宏翔商道（南京）科技发展有限公司（Elexvx Inc）</em>（以下简称“我们”）依据本协议为用户（以下简称“你”）提供<em>Elexvx 脚手架系统</em>服务。本协议对你和我们均具有法律约束力。</p><h2 style=\"text-align: start;\">一、本服务的功能</h2><p style=\"text-align: start;\">你可以使用本服务企业底层脚手架系统。</p><p style=\"text-align: start;\"><br></p><h2 style=\"text-align: start;\">二、责任范围及限制</h2><p style=\"text-align: start;\">你使用本服务得到的结果仅供参考，实际情况以官方为准。</p><p style=\"text-align: start;\"><br></p><h2 style=\"text-align: start;\">三、隐私保护</h2><p style=\"text-align: start;\">我们重视对你隐私的保护，你的个人隐私信息将根据《隐私政策》受到保护与规范，详情请参阅《隐私政策》。</p><p style=\"text-align: start;\"><br></p><h2 style=\"text-align: start;\">四、其他条款</h2><p style=\"text-align: start;\">4.1 本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义解释的依据。</p><p style=\"text-align: start;\">4.2 本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有约束力。</p>', '<h1 style=\"text-align: start;\">隐私政策</h1><p>更新日期：<strong>2026/1/8</strong></p><p>生效日期：<strong>2026/1/8</strong></p><h1 style=\"text-align: start;\">导言</h1><p style=\"text-align: start;\"><em>Elexvx 脚手架系统</em> 是一款由 <em>宏翔商道（南京）科技发展有限公司（Elexvx Inc）</em> （以下简称“我们”）提供的产品。 您在使用我们的服务时，我们可能会收集和使用您的相关信息。我们希望通过本《隐私政策》向您说明，在使用我们的服务时，我们如何收集、使用、储存和分享这些信息，以及我们为您提供的访问、更新、控制和保护这些信息的方式。 本《隐私政策》与您所使用的 <em>Elexvx 脚手架系统</em> 服务息息相关，希望您仔细阅读，在需要时，按照本《隐私政策》的指引，作出您认为适当的选择。本《隐私政策》中涉及的相关技术词汇，我们尽量以简明扼要的表述，并提供进一步说明的链接，以便您的理解。</p><p style=\"text-align: start;\"><strong>您使用或继续使用我们的服务，即意味着同意我们按照本《隐私政策》收集、使用、储存和分享您的相关信息。</strong></p><p style=\"text-align: start;\">如对本《隐私政策》或相关事宜有任何问题，请通过 <strong>elexvx@elexvx.com</strong> 与我们联系。</p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">1. 我们收集的信息</h1><p style=\"text-align: start;\">我们或我们的第三方合作伙伴提供服务时，可能会收集、储存和使用下列与您有关的信息。如果您不提供相关信息，可能无法注册成为我们的用户或无法享受我们提供的某些服务，或者无法达到相关服务拟达到的效果。</p><ul><li style=\"text-align: start;\"><strong>个人信息</strong>，您在注册账户或使用我们的服务时，向我们提供的相关个人信息，例如电话号码、电子邮件等。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">2. 信息的存储</h1><h2 style=\"text-align: start;\">2.1 信息存储的方式和期限</h2><ul><li style=\"text-align: start;\">我们会通过安全的方式存储您的信息，包括本地存储（例如利用APP进行数据缓存）、数据库和服务器日志。</li><li style=\"text-align: start;\">一般情况下，我们只会在为实现服务目的所必需的时间内或法律法规规定的条件下存储您的个人信息。</li></ul><h2 style=\"text-align: start;\">2.2 信息存储的地域</h2><ul><li style=\"text-align: start;\">我们会按照法律法规规定，将境内收集的用户个人信息存储于中国境内。</li><li style=\"text-align: start;\">目前我们不会跨境传输或存储您的个人信息。将来如需跨境传输或存储的，我们会向您告知信息出境的目的、接收方、安全保证措施和安全风险，并征得您的同意。</li></ul><h2 style=\"text-align: start;\">2.3 产品或服务停止运营时的通知</h2><ul><li style=\"text-align: start;\">当我们的产品或服务发生停止运营的情况时，我们将以推送通知、公告等形式通知您，并在合理期限内删除您的个人信息或进行匿名化处理，法律法规另有规定的除外。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">3. 信息安全</h1><p style=\"text-align: start;\">我们使用各种安全技术和程序，以防信息的丢失、不当使用、未经授权阅览或披露。例如，在某些服务中，我们将利用加密技术（例如SSL）来保护您提供的个人信息。但请您理解，由于技术的限制以及可能存在的各种恶意手段，在互联网行业，即便竭尽所能加强安全措施，也不可能始终保证信息百分之百的安全。您需要了解，您接入我们的服务所用的系统和通讯网络，有可能因我们可控范围外的因素而出现问题。</p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">4. 我们如何使用信息</h1><p style=\"text-align: start;\">我们可能将在向您提供服务的过程之中所收集的信息用作下列用途：</p><ul><li style=\"text-align: start;\">向您提供服务；</li><li style=\"text-align: start;\">在我们提供服务时，用于身份验证、客户服务、安全防范、诈骗监测、存档和备份用途，确保我们向您提供的产品和服务的安全性；</li><li style=\"text-align: start;\">帮助我们设计新服务，改善我们现有服务；</li><li style=\"text-align: start;\">使我们更加了解您如何接入和使用我们的服务，从而针对性地回应您的个性化需求，例如语言设定、位置设定、个性化的帮助服务和指示，或对您和其他用户作出其他方面的回应；</li><li style=\"text-align: start;\">向您提供与您更加相关的广告以替代普遍投放的广告；</li><li style=\"text-align: start;\">评估我们服务中的广告和其他促销及推广活动的效果，并加以改善；</li><li style=\"text-align: start;\">软件认证或管理软件升级；</li><li style=\"text-align: start;\">让您参与有关我们产品和服务的调查。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">5. 信息共享</h1><p style=\"text-align: start;\">目前，我们不会主动共享或转让您的个人信息至第三方，如存在其他共享或转让您的个人信息或您需要我们将您的个人信息共享或转让至第三方情形时，我们会直接或确认第三方征得您对上述行为的明示同意。</p><p style=\"text-align: start;\">为了投放广告，评估、优化广告投放效果等目的，我们需要向广告主及其代理商等第三方合作伙伴共享您的部分数据，要求其严格遵守我们关于数据隐私保护的措施与要求，包括但不限于根据数据保护协议、承诺书及相关数据处理政策进行处理，避免识别出个人身份，保障隐私安全。</p><p style=\"text-align: start;\">我们不会向合作伙伴分享可用于识别您个人身份的信息（例如您的姓名或电子邮件地址），除非您明确授权。</p><p style=\"text-align: start;\">我们不会对外公开披露所收集的个人信息，如必须公开披露时，我们会向您告知此次公开披露的目的、披露信息的类型及可能涉及的敏感信息，并征得您的明示同意。</p><p style=\"text-align: start;\">随着我们业务的持续发展，我们有可能进行合并、收购、资产转让等交易，我们将告知您相关情形，按照法律法规及不低于本《隐私政策》所要求的标准继续保护或要求新的控制者继续保护您的个人信息。</p><p style=\"text-align: start;\">另外，根据相关法律法规及国家标准，以下情形中，我们可能会共享、转让、公开披露个人信息无需事先征得您的授权同意：</p><ul><li style=\"text-align: start;\">与国家安全、国防安全直接相关的；</li><li style=\"text-align: start;\">与公共安全、公共卫生、重大公共利益直接相关的；</li><li style=\"text-align: start;\">犯罪侦查、起诉、审判和判决执行等直接相关的；</li><li style=\"text-align: start;\">出于维护个人信息主体或其他个人的生命、财产等重大合法权益但又很难得到本人同意的；</li><li style=\"text-align: start;\">个人信息主体自行向社会公众公开个人信息的；</li><li style=\"text-align: start;\">从合法公开披露的信息中收集个人信息的，如合法的新闻报道、政府信息公开等渠道。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">6. 您的权利</h1><p style=\"text-align: start;\">在您使用我们的服务期间，我们可能会视产品具体情况为您提供相应的操作设置，以便您可以查询、删除、更正或撤回您的相关个人信息，您可参考相应的具体指引进行操作。此外，我们还设置了投诉举报渠道，您的意见将会得到及时的处理。如果您无法通过上述途径和方式行使您的个人信息主体权利，您可以通过本《隐私政策》中提供的联系方式提出您的请求，我们会按照法律法规的规定予以反馈。</p><p style=\"text-align: start;\">当您决定不再使用我们的产品或服务时，可以申请注销账户。注销账户后，除法律法规另有规定外，我们将删除或匿名化处理您的个人信息。</p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">7. 变更</h1><p style=\"text-align: start;\">我们可能适时修订本《隐私政策》的条款。当变更发生时，我们会在版本更新时向您提示新的《隐私政策》，并向您说明生效日期。请您仔细阅读变更后的《隐私政策》内容，<strong>若您继续使用我们的服务，即表示您同意我们按照更新后的《隐私政策》处理您的个人信息。</strong></p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">8. 未成年人保护</h1><p style=\"text-align: start;\">我们鼓励父母或监护人指导未满十八岁的未成年人使用我们的服务。我们建议未成年人鼓励他们的父母或监护人阅读本《隐私政策》，并建议未成年人在提交的个人信息之前寻求父母或监护人的同意和指导。</p>');

-- ----------------------------
-- Table structure for ui_login_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_login_settings`;
CREATE TABLE `ui_login_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `login_bg_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `allow_multi_device_login` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_login_settings
-- ----------------------------
INSERT INTO `ui_login_settings` VALUES (1, '/api/files/ASEKxrkL3Eyntni2xRg_DV22A3AesVeuj88o5WbIucYgX4flHrqFOyedklljKs0MVJPDqZkTwe4b3f8aK6h7mrMUkg-1fVExjmvUllNmYaqH36UjAnJzFtxvKr7VmwJj2EVg6oD7md1qsgWiFHbHwDicf4Un_cu2zgzSXaTv4Nbe4QWW8t_G4w', 0);

-- ----------------------------
-- Table structure for ui_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_settings`;
CREATE TABLE `ui_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `footer_company` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `footer_icp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `app_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `logo_header_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `logo_expanded_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `logo_collapsed_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `allow_multi_device_login` tinyint NULL DEFAULT NULL,
  `log_retention_days` int NULL DEFAULT NULL,
  `default_home` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `auto_theme` tinyint NULL DEFAULT NULL,
  `light_start_time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dark_start_time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `show_footer` tinyint NULL DEFAULT NULL,
  `is_sidebar_compact` tinyint NULL DEFAULT NULL,
  `show_breadcrumb` tinyint NULL DEFAULT NULL,
  `menu_auto_collapsed` tinyint NULL DEFAULT NULL,
  `mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `layout` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `split_menu` tinyint NULL DEFAULT NULL,
  `side_mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_footer_aside` tinyint NULL DEFAULT NULL,
  `is_sidebar_fixed` tinyint NULL DEFAULT NULL,
  `is_header_fixed` tinyint NULL DEFAULT NULL,
  `is_use_tabs_router` tinyint NULL DEFAULT NULL,
  `show_header` tinyint NULL DEFAULT NULL,
  `brand_theme` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `login_bg_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_agreement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `privacy_agreement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `website_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `copyright_start_year` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_enabled` tinyint NULL DEFAULT NULL,
  `email_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_port` int NULL DEFAULT NULL,
  `email_username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_from` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_ssl` tinyint NULL DEFAULT NULL,
  `favicon_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `session_timeout_minutes` int NULL DEFAULT NULL,
  `token_timeout_minutes` int NULL DEFAULT NULL,
  `token_refresh_grace_minutes` int NULL DEFAULT NULL,
  `captcha_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `drag_captcha_width` int NULL DEFAULT NULL,
  `drag_captcha_height` int NULL DEFAULT NULL,
  `drag_captcha_threshold` int NULL DEFAULT NULL,
  `image_captcha_length` int NULL DEFAULT NULL,
  `image_captcha_noise_lines` int NULL DEFAULT NULL,
  `password_min_length` int NULL DEFAULT NULL,
  `password_require_uppercase` tinyint NULL DEFAULT NULL,
  `password_require_lowercase` tinyint NULL DEFAULT NULL,
  `password_require_special` tinyint NULL DEFAULT NULL,
  `password_allow_sequential` tinyint NULL DEFAULT NULL,
  `qr_code_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ai_assistant_enabled` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_settings
-- ----------------------------
INSERT INTO `ui_settings` VALUES (2, 'Elexvx Inc', '苏ICP备2025160017号', '1.0', NULL, '/api/files/AfhTAAbiGchX_GRMPEF80DDX72c_ZEylVGdGxslAnTeLvg7p5b7_84FuuQ0MrYCDuoKMJQejiysLfBGzEAqULV7tJXxXzcTQq7k1s1gHDJ1yW3YuZZusknE5qTHD-0YvYxsfze4_O7l1p8Xo3OyxPLp-7KHmi8ql5KIR7VVf3_fNLkvEHblo2w', '/api/files/AdaYk_j-A2ARRI_Cc5Dx3WnZZ3OvUGyfuHwqhhWag2I2EIhn0wJ_ZnhgRGsqFu7v8CpL_uhe5v_TGCV7JcLZdhUbmgmKNNdGj6L2jUaj-frej5NDsKZlUZpS5ZCbkkumZ2avMo3qPGZ6pCdUtEpe6eyGyqM4SWPzjMGEJrWcytZyYv6x2qsk6w', 0, 0, '/example/goods', 0, '06:00', '18:00', NULL, NULL, NULL, NULL, 'light', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '/api/files/ASEKxrkL3Eyntni2xRg_DV22A3AesVeuj88o5WbIucYgX4flHrqFOyedklljKs0MVJPDqZkTwe4b3f8aK6h7mrMUkg-1fVExjmvUllNmYaqH36UjAnJzFtxvKr7VmwJj2EVg6oD7md1qsgWiFHbHwDicf4Un_cu2zgzSXaTv4Nbe4QWW8t_G4w', '<h1 style=\"text-align: start;\">用户协议</h1><p style=\"text-align: start;\"><em>宏翔商道（南京）科技发展有限公司（Elexvx Inc）</em>（以下简称“我们”）依据本协议为用户（以下简称“你”）提供<em>Elexvx 脚手架系统</em>服务。本协议对你和我们均具有法律约束力。</p><h2 style=\"text-align: start;\">一、本服务的功能</h2><p style=\"text-align: start;\">你可以使用本服务企业底层脚手架系统。</p><p style=\"text-align: start;\"><br></p><h2 style=\"text-align: start;\">二、责任范围及限制</h2><p style=\"text-align: start;\">你使用本服务得到的结果仅供参考，实际情况以官方为准。</p><p style=\"text-align: start;\"><br></p><h2 style=\"text-align: start;\">三、隐私保护</h2><p style=\"text-align: start;\">我们重视对你隐私的保护，你的个人隐私信息将根据《隐私政策》受到保护与规范，详情请参阅《隐私政策》。</p><p style=\"text-align: start;\"><br></p><h2 style=\"text-align: start;\">四、其他条款</h2><p style=\"text-align: start;\">4.1 本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义解释的依据。</p><p style=\"text-align: start;\">4.2 本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有约束力。</p>', '<h1 style=\"text-align: start;\">隐私政策</h1><p>更新日期：<strong>2026/1/8</strong></p><p>生效日期：<strong>2026/1/8</strong></p><h1 style=\"text-align: start;\">导言</h1><p style=\"text-align: start;\"><em>Elexvx 脚手架系统</em> 是一款由 <em>宏翔商道（南京）科技发展有限公司（Elexvx Inc）</em> （以下简称“我们”）提供的产品。 您在使用我们的服务时，我们可能会收集和使用您的相关信息。我们希望通过本《隐私政策》向您说明，在使用我们的服务时，我们如何收集、使用、储存和分享这些信息，以及我们为您提供的访问、更新、控制和保护这些信息的方式。 本《隐私政策》与您所使用的 <em>Elexvx 脚手架系统</em> 服务息息相关，希望您仔细阅读，在需要时，按照本《隐私政策》的指引，作出您认为适当的选择。本《隐私政策》中涉及的相关技术词汇，我们尽量以简明扼要的表述，并提供进一步说明的链接，以便您的理解。</p><p style=\"text-align: start;\"><strong>您使用或继续使用我们的服务，即意味着同意我们按照本《隐私政策》收集、使用、储存和分享您的相关信息。</strong></p><p style=\"text-align: start;\">如对本《隐私政策》或相关事宜有任何问题，请通过 <strong>elexvx@elexvx.com</strong> 与我们联系。</p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">1. 我们收集的信息</h1><p style=\"text-align: start;\">我们或我们的第三方合作伙伴提供服务时，可能会收集、储存和使用下列与您有关的信息。如果您不提供相关信息，可能无法注册成为我们的用户或无法享受我们提供的某些服务，或者无法达到相关服务拟达到的效果。</p><ul><li style=\"text-align: start;\"><strong>个人信息</strong>，您在注册账户或使用我们的服务时，向我们提供的相关个人信息，例如电话号码、电子邮件等。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">2. 信息的存储</h1><h2 style=\"text-align: start;\">2.1 信息存储的方式和期限</h2><ul><li style=\"text-align: start;\">我们会通过安全的方式存储您的信息，包括本地存储（例如利用APP进行数据缓存）、数据库和服务器日志。</li><li style=\"text-align: start;\">一般情况下，我们只会在为实现服务目的所必需的时间内或法律法规规定的条件下存储您的个人信息。</li></ul><h2 style=\"text-align: start;\">2.2 信息存储的地域</h2><ul><li style=\"text-align: start;\">我们会按照法律法规规定，将境内收集的用户个人信息存储于中国境内。</li><li style=\"text-align: start;\">目前我们不会跨境传输或存储您的个人信息。将来如需跨境传输或存储的，我们会向您告知信息出境的目的、接收方、安全保证措施和安全风险，并征得您的同意。</li></ul><h2 style=\"text-align: start;\">2.3 产品或服务停止运营时的通知</h2><ul><li style=\"text-align: start;\">当我们的产品或服务发生停止运营的情况时，我们将以推送通知、公告等形式通知您，并在合理期限内删除您的个人信息或进行匿名化处理，法律法规另有规定的除外。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">3. 信息安全</h1><p style=\"text-align: start;\">我们使用各种安全技术和程序，以防信息的丢失、不当使用、未经授权阅览或披露。例如，在某些服务中，我们将利用加密技术（例如SSL）来保护您提供的个人信息。但请您理解，由于技术的限制以及可能存在的各种恶意手段，在互联网行业，即便竭尽所能加强安全措施，也不可能始终保证信息百分之百的安全。您需要了解，您接入我们的服务所用的系统和通讯网络，有可能因我们可控范围外的因素而出现问题。</p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">4. 我们如何使用信息</h1><p style=\"text-align: start;\">我们可能将在向您提供服务的过程之中所收集的信息用作下列用途：</p><ul><li style=\"text-align: start;\">向您提供服务；</li><li style=\"text-align: start;\">在我们提供服务时，用于身份验证、客户服务、安全防范、诈骗监测、存档和备份用途，确保我们向您提供的产品和服务的安全性；</li><li style=\"text-align: start;\">帮助我们设计新服务，改善我们现有服务；</li><li style=\"text-align: start;\">使我们更加了解您如何接入和使用我们的服务，从而针对性地回应您的个性化需求，例如语言设定、位置设定、个性化的帮助服务和指示，或对您和其他用户作出其他方面的回应；</li><li style=\"text-align: start;\">向您提供与您更加相关的广告以替代普遍投放的广告；</li><li style=\"text-align: start;\">评估我们服务中的广告和其他促销及推广活动的效果，并加以改善；</li><li style=\"text-align: start;\">软件认证或管理软件升级；</li><li style=\"text-align: start;\">让您参与有关我们产品和服务的调查。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">5. 信息共享</h1><p style=\"text-align: start;\">目前，我们不会主动共享或转让您的个人信息至第三方，如存在其他共享或转让您的个人信息或您需要我们将您的个人信息共享或转让至第三方情形时，我们会直接或确认第三方征得您对上述行为的明示同意。</p><p style=\"text-align: start;\">为了投放广告，评估、优化广告投放效果等目的，我们需要向广告主及其代理商等第三方合作伙伴共享您的部分数据，要求其严格遵守我们关于数据隐私保护的措施与要求，包括但不限于根据数据保护协议、承诺书及相关数据处理政策进行处理，避免识别出个人身份，保障隐私安全。</p><p style=\"text-align: start;\">我们不会向合作伙伴分享可用于识别您个人身份的信息（例如您的姓名或电子邮件地址），除非您明确授权。</p><p style=\"text-align: start;\">我们不会对外公开披露所收集的个人信息，如必须公开披露时，我们会向您告知此次公开披露的目的、披露信息的类型及可能涉及的敏感信息，并征得您的明示同意。</p><p style=\"text-align: start;\">随着我们业务的持续发展，我们有可能进行合并、收购、资产转让等交易，我们将告知您相关情形，按照法律法规及不低于本《隐私政策》所要求的标准继续保护或要求新的控制者继续保护您的个人信息。</p><p style=\"text-align: start;\">另外，根据相关法律法规及国家标准，以下情形中，我们可能会共享、转让、公开披露个人信息无需事先征得您的授权同意：</p><ul><li style=\"text-align: start;\">与国家安全、国防安全直接相关的；</li><li style=\"text-align: start;\">与公共安全、公共卫生、重大公共利益直接相关的；</li><li style=\"text-align: start;\">犯罪侦查、起诉、审判和判决执行等直接相关的；</li><li style=\"text-align: start;\">出于维护个人信息主体或其他个人的生命、财产等重大合法权益但又很难得到本人同意的；</li><li style=\"text-align: start;\">个人信息主体自行向社会公众公开个人信息的；</li><li style=\"text-align: start;\">从合法公开披露的信息中收集个人信息的，如合法的新闻报道、政府信息公开等渠道。</li></ul><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">6. 您的权利</h1><p style=\"text-align: start;\">在您使用我们的服务期间，我们可能会视产品具体情况为您提供相应的操作设置，以便您可以查询、删除、更正或撤回您的相关个人信息，您可参考相应的具体指引进行操作。此外，我们还设置了投诉举报渠道，您的意见将会得到及时的处理。如果您无法通过上述途径和方式行使您的个人信息主体权利，您可以通过本《隐私政策》中提供的联系方式提出您的请求，我们会按照法律法规的规定予以反馈。</p><p style=\"text-align: start;\">当您决定不再使用我们的产品或服务时，可以申请注销账户。注销账户后，除法律法规另有规定外，我们将删除或匿名化处理您的个人信息。</p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">7. 变更</h1><p style=\"text-align: start;\">我们可能适时修订本《隐私政策》的条款。当变更发生时，我们会在版本更新时向您提示新的《隐私政策》，并向您说明生效日期。请您仔细阅读变更后的《隐私政策》内容，<strong>若您继续使用我们的服务，即表示您同意我们按照更新后的《隐私政策》处理您的个人信息。</strong></p><p style=\"text-align: start;\"><br></p><h1 style=\"text-align: start;\">8. 未成年人保护</h1><p style=\"text-align: start;\">我们鼓励父母或监护人指导未满十八岁的未成年人使用我们的服务。我们建议未成年人鼓励他们的父母或监护人阅读本《隐私政策》，并建议未成年人在提交的个人信息之前寻求父母或监护人的同意和指导。</p>', 'Elexvx 脚手架系统', '2025', 1, 'smtp.163.com', 465, 'elexvx@163.com', 'BYvyfJmrN92UgbKF', 'elexvx@163.com', 1, NULL, 1440, 1440, 60, 'image', 280, 160, 98, 5, 8, 6, 0, 0, 0, 1, '/api/files/AW2kZzhbP7MhEjvI-x1xwb5hec-HBuUwVYpcwcVh5Cozaj-r6d-IuZ17TkTFAy07yj27nwOu6G3hOfS0PNTtjUxCOZv80OC8GJvKbKhZvAqzuD7XTjieVBCzabQ2cnFfpTn4VPloU3MtSNmKH_J4qF-jrxKlbVv_tfaQS2r2md2cjP09dztUMA', NULL);

-- ----------------------------
-- Table structure for ui_system_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_system_settings`;
CREATE TABLE `ui_system_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `log_retention_days` int NULL DEFAULT NULL,
  `ai_assistant_enabled` tinyint NULL DEFAULT NULL,
  `maintenance_enabled` tinyint NULL DEFAULT NULL,
  `maintenance_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_system_settings
-- ----------------------------
INSERT INTO `ui_system_settings` VALUES (1, 0, 0, 0, '');

-- ----------------------------
-- Table structure for ui_theme_settings
-- ----------------------------
DROP TABLE IF EXISTS `ui_theme_settings`;
CREATE TABLE `ui_theme_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `auto_theme` tinyint NULL DEFAULT NULL,
  `light_start_time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dark_start_time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `brand_theme` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ui_theme_settings
-- ----------------------------
INSERT INTO `ui_theme_settings` VALUES (1, 0, '06:00', '18:00', 'light', NULL);

-- ----------------------------
-- Table structure for user_parameters
-- ----------------------------
DROP TABLE IF EXISTS `user_parameters`;
CREATE TABLE `user_parameters`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `param_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `param_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_parameters
-- ----------------------------

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `user_id` bigint NOT NULL,
  `role` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`, `role`) USING BTREE,
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES (1, 'admin');
INSERT INTO `user_roles` VALUES (148, 'user');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `seat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `entity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `leader` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `position` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `join_day` date NULL DEFAULT NULL,
  `team` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `district` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `guid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account`(`account` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '宋昊晟', '$2a$10$BbVSQCIChdR.4gfwiG1OduJiKE/KpUTbhBXd.7Sr.uwi8eggDpYeu', '', '', '', 'T32F 001', '腾讯集团', 'CEO', '系统管理员', '2018-01-01', '腾讯/腾讯公司/管理层/系统管理组', 'male', '管理员', '', '', '', '', '', '/api/uploads/business/b27eeb829cd64ccaab15123e70678c24.jpg', '', '', 'e59c3cd1-3b52-47c7-bf88-fad5b2281827');
INSERT INTO `users` VALUES (148, 'admin3', 'Admin Three', '$2a$10$e1tqPQdmcvdJItQI89/ZC.TieQ49T8vCfLzVL/dJuReHUD42Zjcc2', '13800138003', NULL, 'admin3@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '110101199003071235', '6ed25d3d-8ea2-4b64-91d1-1e05c884a6d0');

-- ----------------------------
-- Table structure for verification_email_settings
-- ----------------------------
DROP TABLE IF EXISTS `verification_email_settings`;
CREATE TABLE `verification_email_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_enabled` tinyint NULL DEFAULT NULL,
  `email_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_port` int NULL DEFAULT NULL,
  `email_username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_from` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_ssl` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of verification_email_settings
-- ----------------------------
INSERT INTO `verification_email_settings` VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for verification_settings
-- ----------------------------
DROP TABLE IF EXISTS `verification_settings`;
CREATE TABLE `verification_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sms_enabled` tinyint NULL DEFAULT NULL,
  `sms_provider` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_enabled` tinyint NULL DEFAULT NULL,
  `sms_aliyun_access_key_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_access_key_secret` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_sign_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_template_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_region_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_enabled` tinyint NULL DEFAULT NULL,
  `sms_tencent_secret_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_secret_key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_sign_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_template_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_sdk_app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_enabled` tinyint NULL DEFAULT NULL,
  `email_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_port` int NULL DEFAULT NULL,
  `email_username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_from` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email_ssl` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of verification_settings
-- ----------------------------

-- ----------------------------
-- Table structure for verification_sms_settings
-- ----------------------------
DROP TABLE IF EXISTS `verification_sms_settings`;
CREATE TABLE `verification_sms_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sms_enabled` tinyint NULL DEFAULT NULL,
  `sms_provider` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_enabled` tinyint NULL DEFAULT NULL,
  `sms_aliyun_access_key_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_access_key_secret` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_sign_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_template_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_region_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_aliyun_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_enabled` tinyint NULL DEFAULT NULL,
  `sms_tencent_secret_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_secret_key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_sign_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_template_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_tencent_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sms_sdk_app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of verification_sms_settings
-- ----------------------------
INSERT INTO `verification_sms_settings` VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for wallets
-- ----------------------------
DROP TABLE IF EXISTS `wallets`;
CREATE TABLE `wallets`  (
  `booster_id` bigint NOT NULL,
  `balance` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '可提现余额',
  `frozen_balance` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '冻结中金额',
  `deposit` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '保证金',
  `total_withdrawn` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '累计提现总额',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`booster_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '打手钱包表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallets
-- ----------------------------
INSERT INTO `wallets` VALUES (4, 0.00, 52.80, 0.00, 0.00, '2026-01-23 01:59:08', '2026-01-23 01:59:08');
INSERT INTO `wallets` VALUES (5, 0.00, 44.80, 0.00, 0.00, '2026-01-22 18:17:46', '2026-01-22 18:17:46');
INSERT INTO `wallets` VALUES (6, 0.00, 444.00, 0.00, 0.00, '2026-01-22 16:40:52', '2026-01-22 16:40:51');
INSERT INTO `wallets` VALUES (7, 0.00, 109.60, 0.00, 0.00, '2026-01-22 17:12:54', '2026-01-23 01:49:10');
INSERT INTO `wallets` VALUES (8, 0.00, 444.00, 0.00, 0.00, '2026-01-22 14:00:53', '2026-01-22 14:00:53');
INSERT INTO `wallets` VALUES (11, 0.00, 182.40, 0.00, 0.00, '2026-01-24 21:43:28', '2026-01-24 21:43:27');
INSERT INTO `wallets` VALUES (12, 0.00, 630.40, 0.00, 0.00, '2026-01-24 01:40:01', '2026-01-24 01:40:00');
INSERT INTO `wallets` VALUES (14, 0.00, 70.40, 0.00, 0.00, '2026-01-24 22:14:39', '2026-01-24 22:14:38');

-- ----------------------------
-- Table structure for watermark_settings
-- ----------------------------
DROP TABLE IF EXISTS `watermark_settings`;
CREATE TABLE `watermark_settings`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `opacity` double NOT NULL,
  `size` int NOT NULL,
  `gap_x` int NOT NULL,
  `gap_y` int NOT NULL,
  `rotate` int NOT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of watermark_settings
-- ----------------------------
INSERT INTO `watermark_settings` VALUES (1, 'text_single', '水印', '', 0.12, 30, 200, 200, 20, 0);

-- ----------------------------
-- Table structure for withdrawals
-- ----------------------------
DROP TABLE IF EXISTS `withdrawals`;
CREATE TABLE `withdrawals`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booster_id` bigint NOT NULL COMMENT '打手ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '提现金额',
  `account_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收款账号信息',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING' COMMENT '状态: PENDING(待审核), APPROVED(已通过), REJECTED(已驳回)',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(驳回理由等)',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_booster_id`(`booster_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '提现申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of withdrawals
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
