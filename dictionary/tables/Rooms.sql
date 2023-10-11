CREATE TABLE IF NOT EXISTS dictionary.rooms
(
    rooms_id BIGSERIAL   NOT NULL
        CONSTRAINT pk_rooms PRIMARY KEY,
    name     VARCHAR(32) NOT NULL
);