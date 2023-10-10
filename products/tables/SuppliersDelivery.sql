CREATE TABLE IF NOT EXISTS products.delivery
(
    delivery_id   INT         NOT NULL
        CONSTRAINT pk_delivery PRIMARY KEY,
    supplier_id   INT         NOT NULL,
    delivery_info JSONB       NOT NULL,
    plan_dt       DATE        NOT NULL,
    dt            TIMESTAMPTZ NOT NULL,
    ch_staff_id   INT         NULL,
    ch_dt         TIMESTAMPTZ NULL
);