CREATE TABLE IF NOT EXISTS products.delivery
(
    delivery_id INT         NOT NULL
        CONSTRAINT pk_suppliersdelivery PRIMARY KEY,
    supplier_id INT         NOT NULL,
    data        JSONB       NOT NULL,
    plan_dt     DATE        NOT NULL,
    dt          TIMESTAMPTZ NOT NULL,
    ch_staff_id INT         NULL,
    ch_dt       TIMESTAMPTZ NULL
);