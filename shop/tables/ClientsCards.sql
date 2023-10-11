CREATE TABLE IF NOT EXISTS shop.clientscards
(
    card_id     BIGINT      NOT NULL
        CONSTRAINT pk_clientscards PRIMARY KEY,
    type_id     SMALLINT    NOT NULL,
    client_id   INT         NOT NULL,
    is_deleted  BOOLEAN     NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);

