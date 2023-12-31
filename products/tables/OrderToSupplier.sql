CREATE TABLE IF NOT EXISTS products.ordertosupplier
(
    order_id     INT         NOT NULL
        CONSTRAINT pk_ordertosupplier PRIMARY KEY,
    suppliers_id INT         NOT NULL,
    order_info   JSONB       NOT NULL,
    is_finished  BOOLEAN     NOT NULL,
    dt           TIMESTAMPTZ NOT NULL,
    ch_staff_id  INT         NULL,
    ch_dt        TIMESTAMPTZ NULL
);