CREATE TABLE IF NOT EXISTS dictionary.placetype
(
    room_id BIGSERIAL   NOT NULL
        CONSTRAINT pk_room PRIMARY KEY,
    name    VARCHAR(32) NOT NULL
);