CREATE TABLE IF NOT EXISTS products.prices
(
    nm_id       BIGINT        NOT NULL,
    price       NUMERIC(8, 2) NOT NULL,
    ch_staff_id INT           NOT NULL,
    ch_dt       TIMESTAMPTZ   NOT NULL
);