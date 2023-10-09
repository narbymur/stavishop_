CREATE TABLE IF NOT EXISTS products.products
(
    nm_id            BIGINT      NOT NULL,
    product_type     BIGSERIAL   NOT NULL,
    product_category BIGSERIAL   NOT NULL,
    sku_id           BIGINT      NOT NULL,
    gender           SMALLINT    NOT NULL,
    season           CHAR(3)     NOT NULL,
    color            VARCHAR(30) NOT NULL,
    description      VARCHAR(30) NOT NULL
);