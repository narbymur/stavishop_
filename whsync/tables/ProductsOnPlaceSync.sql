CREATE TABLE IF NOT EXISTS whsync.productsonplacesync
(
    log_id   BIGSERIAL   NOT NULL
        CONSTRAINT pk_productsonplacesync PRIMARY KEY,
    place_id BIGINT      NOT NULL,
    room_id  BIGINT      NOT NULL,
    nm_id    BIGINT      NOT NULL,
    quantity SMALLINT    NOT NULL,
    sync_dt  TIMESTAMPTZ NULL
);