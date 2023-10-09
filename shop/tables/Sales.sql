CREATE TABLE IF NOT EXISTS shop.sales
(
    order_id    BIGINT      NOT NULL
        CONSTRAINT pk_sales PRIMARY KEY,
    client_id   INT         NOT NULL,
    order_info  JSONB       NOT NULL,
    room_id     BIGINT      NULL,
    status      CHAR(3)     NOT NULL,
    dt          TIMESTAMPTZ NOT NULL,
    ch_staff_id INT         NULL,
    ch_dt       TIMESTAMPTZ NULL
);