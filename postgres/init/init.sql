CREATE EXTENSION pgcrypto;

CREATE TABLE users (
  id             UUID         NOT NULL,
  email          varchar(256) NOT NULL,
  username       varchar(30)  NOT NULL,
  "password"     varchar(30)  NOT NULL,
  tag            smallint     NOT NULL,
  registered_at  timestamp    NOT NULL,
  verified       boolean      NOT NULL
);

CREATE TABLE servers (
  "categories" UUID    NOT NULL,
  "created_at" varchar(30) NOT NULL,
  "emojis"     UUID    NOT NULL,
  "stamps"     UUID[],
  "owner"      UUID[],
  "name"       UUID[],
  "id"         timestamp NOT NULL
);

CREATE TABLE categories (
  "categories" UUID    NOT NULL,
  "created_at" varchar(30) NOT NULL,
  "emojis"     UUID    NOT NULL,
  "stamps"     UUID[],
  "owner"      UUID[],
  "name"       UUID[],
  "id"         timestamp NOT NULL
);

CREATE TABLE channels (
  "categories" UUID    NOT NULL,
  "created_at" varchar(30) NOT NULL,
  "emojis"     UUID    NOT NULL,
  "stamps"     UUID[],
  "owner"      UUID[],
  "name"       UUID[],
  "id"         timestamp NOT NULL
);

CREATE TABLE messages (
  "categories" UUID    NOT NULL,
  "created_at" varchar(30) NOT NULL,
  "emojis"     UUID    NOT NULL,
  "stamps"     UUID[],
  "owner"      UUID[],
  "name"       UUID[],
  "id"         timestamp NOT NULL
);