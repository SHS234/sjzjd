ALTER TABLE `boosters` ADD COLUMN `regions` VARCHAR(255) DEFAULT NULL COMMENT '游戏大区' AFTER `game_rank`;
