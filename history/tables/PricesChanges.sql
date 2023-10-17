CREATE TABLE IF NOT EXISTS history.priceschanges
(
    log_id      BIGSERIAL     NOT NULL
        CONSTRAINT pk_priceschanges PRIMARY KEY,
    nm_id       BIGINT        NOT NULL,
    price       NUMERIC(8, 2) NOT NULL,
    ch_staff_id INT           NOT NULL,
    ch_dt       TIMESTAMPTZ   NOT NULL
);