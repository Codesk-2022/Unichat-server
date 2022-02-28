CREATE EXTENSION pgcrypto;

CREATE TABLE users (
  "id"            UUID    NOT NULL,
  "email"         varchar(256) NOT NULL,
  "username"      varchar(30) NOT NULL,
  "password"      varchar(30) NOT NULL,
  "tag"           smallint    NOT NULL,
  "registered_at" timestamp NOT NULL,
  "verified"      boolean NOT NULL
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
  "server"     UUID NOT NULL,
  "channels"   UUID[],
  "created_at" timestamp NOT NULL
);

CREATE TABLE channels (
  "id"          UUID    NOT NULL,
  "name"        varchar(30) NOT NULL,
  "description" varchar(120),
  "server"      UUID NOT NULL,
  "category"    UUID NOT NULL,
  "created_at"  timestamp NOT NULL
);

CREATE TABLE messages (
  "id"         UUID    NOT NULL,
  "user"       UUID NOT NULL,
  "content"    varchar(300) NOT NULL,
  "server"     UUID NOT NULL,
  "channel"    UUID NOT NULL,
  "created_at" timestamp NOT NULL
);

