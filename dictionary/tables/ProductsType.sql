CREATE TABLE IF NOT EXISTS dictionary.productstype
(
    product_type     BIGSERIAL NOT NULL,
    product_category BIGSERIAL NOT NULL,
    name             CHAR(3)   NOT NULL
);