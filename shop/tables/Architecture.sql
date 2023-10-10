CREATE TABLE IF NOT EXISTS shop.architecture
(
    place_id BIGINT NOT NULL
        CONSTRAINT pk_architecture PRIMARY KEY,
    room_id  BIGINT NOT NULL
);