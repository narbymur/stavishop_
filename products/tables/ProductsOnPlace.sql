CREATE TABLE IF NOT EXISTS products.productsonplace
(
    place_id BIGINT   NOT NULL,
    room_id  BIGINT   NOT NULL,
    nm_id    BIGINT   NOT NULL,
    quantity SMALLINT NOT NULL
);

