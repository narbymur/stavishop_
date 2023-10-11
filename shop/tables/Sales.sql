CREATE TABLE IF NOT EXISTS shop.sales
(
    sales_id    BIGINT      NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    client_id   INT         NOT NULL,
    sale_info   JSONB       NOT NULL,
    dt          TIMESTAMPTZ NOT NULL,
    ch_staff_id INT         NULL,
    ch_dt       TIMESTAMPTZ NULL
);