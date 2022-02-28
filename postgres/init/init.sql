CREATE EXTENSION pgcrypto;

CREATE TABLE users {
  id             UUID         NOT NULL,
  email          varchar(256) NOT NULL,
  username       varchar(30)  NOT NULL,
  "password"     varchar(30)  NOT NULL,
  tag            smallint     NOT NULL,
  registered_at  timestamp    NOT NULL,
  verified       boolean      NOT NULL
};

