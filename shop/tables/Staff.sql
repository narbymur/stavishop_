CREATE TABLE IF NOT EXISTS shop.staff
(
    staff_id    INT         NOT NULL
        CONSTRAINT pk_staff PRIMARY KEY,
    position_id SMALLINT    NOT NULL,
    name        VARCHAR(64) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    birth_date  DATE        NOT NULL,
    is_active   BOOLEAN     NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);
