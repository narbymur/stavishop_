CREATE TABLE IF NOT EXISTS shop.orders
(
    orders_id INT         NOT NULL
        CONSTRAINT pk_orders PRIMARY KEY,
    client_id INT         NOT NULL,
    staff_id  INT         NOT NULL,
    status    VARCHAR(16) NOT NULL,
    date      TIMESTAMPTZ NOT NULL,
    address   VARCHAR(32) NOT NULL
);