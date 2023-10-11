CREATE TABLE IF NOT EXISTS whsync.clientssync
(
    log_id      BIGSERIAL    NOT NULL
        CONSTRAINT pk_clientssync PRIMARY KEY,
    client_id   INT          NOT NULL,
    name        VARCHAR(300) NOT NULL,
    birth_date  DATE         NOT NULL,
    gender      CHAR(3)      NOT NULL,
    phone       VARCHAR(11)  NOT NULL,
    ch_staff_id INT          NOT NULL,
    ch_dt       TIMESTAMPTZ  NOT NULL,
    sync_dt     TIMESTAMPTZ  NULL
);