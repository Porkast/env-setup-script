CREATE DATABASE IF NOT EXISTS guoshaofmdb;

GRANT ALL PRIVILEGES ON *.* TO 'guoshaofm'@'%';

USE guoshaofmdb;

-- guoshaofmdb.feed_channel definition
CREATE TABLE
    `daily_feed_item_record` (
        `channel_id` varchar(64) NOT NULL,
        `item_id` varchar(64) NOT NULL,
        `pub_date` date DEFAULT NULL,
        KEY `dfiu_idx_pubdate` (`pub_date`) USING BTREE,
        KEY `dfiu_idx_channel_id` (`channel_id`) USING BTREE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    `feed_channel` (
        `id` varchar(64) NOT NULL,
        `ido` varchar(64) NOT NULL,
        `title` varchar(128) DEFAULT NULL,
        `channel_desc` mediumtext,
        `image_url` varchar(128) DEFAULT NULL,
        `link` varchar(128) DEFAULT NULL,
        `feed_link` varchar(128) DEFAULT NULL,
        `copyright` varchar(128) DEFAULT NULL,
        `language` varchar(128) DEFAULT NULL,
        `author` varchar(128) DEFAULT NULL,
        `owner_name` varchar(128) DEFAULT NULL,
        `owner_email` varchar(128) DEFAULT NULL,
        `feed_type` varchar(128) DEFAULT NULL,
        `categories` varchar(128) DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    `feed_channel_update_record` (
        `channel_id` varchar(64) NOT NULL,
        `func_name` varchar(100) NOT NULL,
        `update_time` datetime NOT NULL,
        UNIQUE KEY `fcu_idx_channel_id` (`channel_id`) USING BTREE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    `feed_item` (
        `id` varchar(64) NOT NULL,
        `channel_id` varchar(64) NOT NULL,
        `title` mediumtext,
        `link` varchar(128) DEFAULT NULL,
        `pub_date` date DEFAULT NULL,
        `author` varchar(128) DEFAULT NULL,
        `input_date` datetime DEFAULT NULL,
        `image_url` varchar(256) DEFAULT NULL,
        `enclosure_url` varchar(256) DEFAULT NULL,
        `enclosure_type` varchar(256) DEFAULT NULL,
        `enclosure_length` varchar(256) DEFAULT NULL,
        `duration` varchar(256) DEFAULT NULL,
        `episode` varchar(64) DEFAULT NULL,
        `explicit` varchar(64) DEFAULT NULL,
        `season` varchar(64) DEFAULT NULL,
        `episodeType` varchar(64) DEFAULT NULL,
        `description` mediumtext,
        PRIMARY KEY (`id`),
        KEY `rfi_idx_channel_id` (`channel_id`),
        KEY `rfi_idx_pub_date` (`pub_date`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    `keyword_subscription` (
        `id` varchar(64) NOT NULL,
        `keyword` varchar(128) NOT NULL,
        `feed_channel_id` varchar(128) NOT NULL,
        `feed_item_id` varchar(128) NOT NULL,
        `create_time` datetime DEFAULT NULL,
        `order_by_date` int DEFAULT '0',
        `lang` varchar(64) DEFAULT NULL COMMENT 'feed language',
        KEY `ks_idx_keyword` (`keyword`),
        KEY `ks_idx_klo` (
            `keyword`,
            `lang`,
            `order_by_date`
        )
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;

CREATE TABLE
    `user_sub_keyword` (
        `id` varchar(64) DEFAULT NULL,
        `user_id` varchar(128) DEFAULT NULL,
        `keyword` varchar(128) DEFAULT NULL,
        `order_by_date` int DEFAULT NULL,
        `create_time` datetime DEFAULT NULL,
        `lang` varchar(64) DEFAULT NULL COMMENT 'feed language',
        `status` int DEFAULT '1',
        KEY `usk_idx_keyword` (`keyword`),
        KEY `usk_idx_user_id` (`user_id`),
        KEY `usk_user_id_keyword` (`user_id`, `keyword`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;