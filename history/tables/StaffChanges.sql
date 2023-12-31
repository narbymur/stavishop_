CREATE TABLE IF NOT EXISTS history.staffchanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_staffchanges PRIMARY KEY,
    staff_id    INT         NOT NULL,
    position_id SMALLINT    NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    birth_date  DATE        NOT NULL,
    is_active   BOOLEAN     NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);
