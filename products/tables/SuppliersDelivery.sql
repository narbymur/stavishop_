CREATE TABLE IF NOT EXISTS products.suppliersdelivery
(
    delivery_id   INT         NOT NULL
        CONSTRAINT pk_suppliersdelivery PRIMARY KEY,
    suppliers_id  INT         NOT NULL,
    delivery_info JSONB       NOT NULL,
    plan_dt       DATE        NOT NULL,
    is_finished   BOOLEAN     NOT NULL,
    dt            TIMESTAMPTZ NULL,
    ch_staff_id   INT         NULL,
    ch_dt         TIMESTAMPTZ NULL
);