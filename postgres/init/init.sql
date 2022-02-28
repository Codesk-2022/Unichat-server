CREATE EXTENSION pgcrypto;

CREATE TABLE users (
  "id"         UUID    NOT NULL,
  "name"       varchar(30) NOT NULL,
  "owner"      UUID    NOT NULL,
  "categories" UUID[],
  "emojis"     UUID[],
  "stamps"     UUID[],
  "created_at" timestamp NOT NULL
);

CREATE TABLE servers (
  "id"         UUID    NOT NULL,
  "name"       varchar(30) NOT NULL,
  "owner"      UUID    NOT NULL,
  "categories" UUID[],
  "emojis"     UUID[],
  "stamps"     UUID[],
  "created_at" timestamp NOT NULL
);

CREATE TABLE categories (
  "id"         UUID    NOT NULL,
  "name"       varchar(30) NOT NULL,
  "owner"      UUID    NOT NULL,
  "categories" UUID[],
  "emojis"     UUID[],
  "stamps"     UUID[],
  "created_at" timestamp NOT NULL
);

CREATE TABLE channels (
  "id"         UUID    NOT NULL,
  "name"       varchar(30) NOT NULL,
  "owner"      UUID    NOT NULL,
  "categories" UUID[],
  "emojis"     UUID[],
  "stamps"     UUID[],
  "created_at" timestamp NOT NULL
);

CREATE TABLE messages (
  "id"         UUID    NOT NULL,
  "name"       varchar(30) NOT NULL,
  "owner"      UUID    NOT NULL,
  "categories" UUID[],
  "emojis"     UUID[],
  "stamps"     UUID[],
  "created_at" timestamp NOT NULL
);