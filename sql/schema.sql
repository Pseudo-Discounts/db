CREATE TABLE IF NOT EXISTS media_metadata
(
    id  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    url VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS marketplaces
(
    id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name    VARCHAR UNIQUE NOT NULL,
    logo_id BIGINT UNIQUE  REFERENCES media_metadata (id) ON UPDATE CASCADE ON DELETE SET NULL,
    url     VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS products
(
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    marketplace_id BIGINT REFERENCES marketplaces (id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    name           VARCHAR UNIQUE                                                          NOT NULL,
    picture_id     BIGINT UNIQUE                                                           REFERENCES media_metadata (id) ON UPDATE CASCADE ON DELETE SET NULL,
    url            VARCHAR UNIQUE                                                          NOT NULL,
    is_adult_only  BOOLEAN                                                                 NOT NULL
);

CREATE TABLE IF NOT EXISTS prices
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT REFERENCES products (id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    price      DECIMAL(10, 2)                                                      NOT NULL,
    timestamp  TIMESTAMP WITH TIME ZONE DEFAULT NOW()                              NOT NULL
);

CREATE TABLE IF NOT EXISTS users
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       VARCHAR NOT NULL,
    birth_date DATE    NOT NULL
);

CREATE TABLE IF NOT EXISTS user_details
(
    user_id                    BIGINT PRIMARY KEY REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
    username                   VARCHAR UNIQUE       NOT NULL,
    password_hash              VARCHAR              NOT NULL,
    is_account_non_expired     BOOLEAN DEFAULT TRUE NOT NULL,
    is_account_non_locked      BOOLEAN DEFAULT TRUE NOT NULL,
    is_credentials_non_expired BOOLEAN DEFAULT TRUE NOT NULL,
    is_enabled                 BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE IF NOT EXISTS roles
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS users_roles
(
    user_id BIGINT REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id BIGINT REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY (user_id, role_id)
);
