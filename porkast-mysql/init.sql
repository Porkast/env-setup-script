CREATE DATABASE IF NOT EXISTS porkastdb;

GRANT ALL PRIVILEGES ON *.* TO 'porkast'@'%';

USE porkastdb;

CREATE TABLE
    `feed_channel` (
        `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
        `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `channel_desc` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
        `image_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `link` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `feed_link` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `copyright` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `language` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `author` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `owner_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `owner_email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `feed_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `categories` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `source` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `feed_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE
    `feed_item` (
        `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
        `channel_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
        `guid` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `title` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
        `link` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
        `pub_date` date DEFAULT NULL,
        `author` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `input_date` datetime DEFAULT NULL,
        `image_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `enclosure_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `enclosure_type` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `enclosure_length` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `duration` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `episode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `explicit` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `season` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `episodeType` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `description` blob,
        `channel_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `feed_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'source channel id',
        `feed_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        PRIMARY KEY (`id`),
        KEY `rfi_idx_channel_id` (`channel_id`),
        KEY `rfi_idx_pub_date` (`pub_date`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE
    `keyword_subscription` (
        `id` int NOT NULL AUTO_INCREMENT,
        `keyword` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
        `feed_channel_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
        `feed_item_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
        `create_time` datetime DEFAULT NULL,
        `country` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `source` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `exclude_feed_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        PRIMARY KEY (`id`),
        KEY `ks_idx_keyword` (`keyword`),
        KEY `ks_idx_kcse` (
            `keyword`,
            `country`,
            `source`,
            `exclude_feed_id`
        )
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE
    `user_info` (
        `id` varchar(64) NOT NULL,
        `username` varchar(128) DEFAULT NULL,
        `nickname` varchar(128) DEFAULT NULL,
        `password` varchar(128) DEFAULT NULL,
        `email` varchar(128) DEFAULT NULL,
        `phone` varchar(128) DEFAULT NULL,
        `reg_date` date DEFAULT NULL,
        `update_date` date DEFAULT NULL,
        `avatar` varchar(256) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE
    `user_listen_later` (
        `id` varchar(64) NOT NULL,
        `user_id` varchar(128) DEFAULT NULL,
        `item_id` varchar(128) DEFAULT NULL,
        `channel_id` varchar(128) DEFAULT NULL,
        `reg_date` datetime DEFAULT NULL,
        `status` int DEFAULT '1',
        PRIMARY KEY (`id`),
        KEY `ull_idx_user_id` (`user_id`),
        KEY `ull_idx_item_id` (`item_id`)
    ) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE
    `user_sub_keyword` (
        `id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `keyword` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `order_by_date` int DEFAULT NULL,
        `create_time` datetime DEFAULT NULL,
        `lang` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'feed language',
        `country` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `exclude_feed_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        `status` int DEFAULT '1',
        `source` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
        KEY `usk_idx_keyword` (`keyword`),
        KEY `usk_idx_user_id` (`user_id`),
        KEY `usk_user_id_keyword` (`user_id`, `keyword`, `source`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;