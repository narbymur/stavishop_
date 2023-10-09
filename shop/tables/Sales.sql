CREATE TABLE IF NOT EXISTS shop.sales
(
    client_id INT         NOT NULL,
    staff_id  INT         NOT NULL,
    nm_id     BIGINT      NOT NULL
        CONSTRAINT pk_nm PRIMARY KEY,
    quantity  BIGINT      NOT NULL
        CONSTRAINT ch_quantity CHECK ( quantity > 0 ),
    date      TIMESTAMPTZ NOT NULL
);