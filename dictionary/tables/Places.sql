CREATE TABLE IF NOT EXISTS dictionary.places
(
    place_id BIGSERIAL   NOT NULL
        CONSTRAINT pk_places PRIMARY KEY,
    name     VARCHAR(32) NOT NULL
);