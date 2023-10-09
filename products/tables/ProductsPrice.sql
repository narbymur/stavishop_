CREATE TABLE IF NOT EXISTS products.productsprice
(
    nm_id            BIGINT        NOT NULL,
    product_type     BIGSERIAL     NOT NULL,
    product_category BIGSERIAL     NOT NULL,
    sku_id           BIGINT        NOT NULL,
    price            NUMERIC(8, 2) NOT NULL
);