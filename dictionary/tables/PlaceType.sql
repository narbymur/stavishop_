CREATE TABLE IF NOT EXISTS dictionary.placetype
(
    type_id BIGSERIAL   NOT NULL
        CONSTRAINT pk_placetype PRIMARY KEY,
    name    VARCHAR(32) NOT NULL
);