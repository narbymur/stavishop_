CREATE TABLE IF NOT EXISTS shop.storage
(
    nm_id       BIGINT      NOT NULL,
    size        CHAR(3)     NOT NULL,
    quantity    SMALLINT    NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);