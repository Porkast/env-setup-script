CREATE DATABASE IF NOT EXISTS rsshubdb;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'qazxsw';

CREATE USER
    'rsshub'@'%' IDENTIFIED
WITH
    mysql_native_password BY 'qazxsw';

GRANT ALL PRIVILEGES ON *.* TO 'rsshub'@'%';

USE rsshubdb;

create table
    if not exists rss_feed_channel (
        id varchar(64) not null primary key,
        title varchar(128) null,
        channel_desc mediumtext null,
        image_url varchar(128) null,
        link varchar(128) null,
        rss_link varchar(128) null
    );

-- MySQL fulltext search table

create table
    if not exists rss_feed_item (
        id varchar(64) not null primary key,
        channel_id varchar(64) not null,
        title mediumtext null,
        content mediumtext null,
        link varchar(128) null,
        date date null,
        author varchar(128) null,
        input_date datetime null,
        thumbnail varchar(256) null,
        description mediumtext null,
        FULLTEXT KEY rss_feed_item_fts_key (
            title,
            content,
            author,
            description
        )
        WITH
            PARSER ngram
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

create index rfi_idx_channel_id on rss_feed_item (channel_id);