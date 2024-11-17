CREATE DATABASE porkastdb;

CREATE USER porkast WITH PASSWORD '1qaz!QAZ';

GRANT ALL PRIVILEGES ON DATABASE porkastdb TO porkast;

\c porkastdb;

CREATE TABLE feed_channel (
    id VARCHAR(64) NOT NULL,
    title VARCHAR(128),
    channel_desc TEXT,
    image_url VARCHAR(128),
    link VARCHAR(128),
    feed_link VARCHAR(128),
    copyright VARCHAR(128),
    language VARCHAR(128),
    author VARCHAR(128),
    owner_name VARCHAR(128),
    owner_email VARCHAR(128),
    feed_type VARCHAR(128),
    categories VARCHAR(128),
    source VARCHAR(64),
    feed_id VARCHAR(64),
    PRIMARY KEY (id)
);

CREATE TABLE feed_item (
    id varchar(64) NOT NULL,
    channel_id varchar(64) NOT NULL,
    guid varchar(256),
    title text,
    link text,
    pub_date date,
    author varchar(128),
    input_date timestamp,
    image_url varchar(256),
    enclosure_url text,
    enclosure_type varchar(256),
    enclosure_length varchar(256),
    duration varchar(256),
    episode varchar(64),
    explicit varchar(64),
    season varchar(64),
    episodeType varchar(64),
    description text,
    channel_title text,
    feed_id varchar(64) NOT NULL,
    feed_link varchar(255),
    source varchar(255),
    PRIMARY KEY (id)
);

CREATE EXTENSION pgroonga;

CREATE INDEX idx_rss_feed_item_full_text_search ON rss_feed_item USING pgroonga (title, description);

CREATE INDEX rfi_idx_pub_date ON feed_item (pub_date);

CREATE TABLE keyword_subscription (
    id SERIAL PRIMARY KEY,
    keyword VARCHAR(128) NOT NULL,
    feed_channel_id VARCHAR(128) NOT NULL,
    feed_item_id VARCHAR(128) NOT NULL,
    create_time TIMESTAMP,
    country VARCHAR(64),
    source VARCHAR(64),
    exclude_feed_id VARCHAR(64)
);

CREATE INDEX ks_idx_keyword ON keyword_subscription (keyword);
CREATE INDEX ks_idx_kcse ON keyword_subscription (keyword, country, source, exclude_feed_id);

CREATE TABLE user_info (
    id VARCHAR(64) PRIMARY KEY,
    username VARCHAR(128),
    nickname VARCHAR(128),
    password VARCHAR(128),
    email VARCHAR(128),
    phone VARCHAR(128),
    reg_date DATE,
    update_date DATE,
    avatar VARCHAR(256)
);

CREATE TABLE user_listen_later (
    id VARCHAR(64) PRIMARY KEY,
    user_id VARCHAR(128),
    item_id VARCHAR(128),
    channel_id VARCHAR(128),
    reg_date TIMESTAMP,
    status INT DEFAULT 1
);

CREATE INDEX ull_idx_user_id ON user_listen_later (user_id);
CREATE INDEX ull_idx_item_id ON user_listen_later (item_id);

CREATE TABLE user_sub_keyword (
    id VARCHAR(64),
    user_id VARCHAR(128),
    keyword VARCHAR(128),
    order_by_date INT,
    create_time TIMESTAMP,
    lang VARCHAR(64),
    country VARCHAR(64),
    exclude_feed_id VARCHAR(64),
    status INT DEFAULT 1,
    source VARCHAR(64)
);

CREATE INDEX usk_idx_keyword ON user_sub_keyword (keyword);
CREATE INDEX usk_idx_user_id ON user_sub_keyword (user_id);
CREATE INDEX usk_user_id_keyword ON user_sub_keyword (user_id, keyword, source);
