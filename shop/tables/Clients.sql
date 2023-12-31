CREATE TABLE IF NOT EXISTS shop.clients
(
    client_id   INT          NOT NULL
        CONSTRAINT pk_clients PRIMARY KEY,
    name        VARCHAR(300) NOT NULL,
    birth_date  DATE         NOT NULL,
    gender      CHAR(3)      NOT NULL,
    phone       VARCHAR(11)  NOT NULL
        CONSTRAINT uq_clients_phone UNIQUE,
    ch_staff_id INT          NOT NULL,
    ch_dt       TIMESTAMPTZ  NOT NULL
);