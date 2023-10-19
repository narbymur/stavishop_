CREATE TABLE IF NOT EXISTS whsync.ordertosupplierssync
(
    log_id       BIGSERIAL   NOT NULL
        CONSTRAINT pk_ordertosupplierssync PRIMARY KEY,
    order_id     INT         NOT NULL,
    suppliers_id INT         NOT NULL,
    order_info   JSONB       NOT NULL,
    is_finished  BOOLEAN     NOT NULL,
    dt           TIMESTAMPTZ NOT NULL,
    ch_staff_id  INT         NULL,
    ch_dt        TIMESTAMPTZ NULL,
    sync_dt      TIMESTAMPTZ NULL
);