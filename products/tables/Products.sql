CREATE TABLE IF NOT EXISTS products.products
(
    nm_id       BIGINT      NOT NULL
        CONSTRAINT pk_products PRIMARY KEY,
    type_id     SMALLINT    NOT NULL,
    category_id INT         NOT NULL,
    description JSONB       NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);