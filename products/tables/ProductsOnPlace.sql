CREATE TABLE IF NOT EXISTS products.productsonplace
(
    place_id BIGINT   NOT NULL
        CONSTRAINT pk_architecture PRIMARY KEY,
    room_id  BIGINT   NOT NULL,
    nm_id    BIGINT   NOT NULL,
    quantity SMALLINT NOT NULL
);

