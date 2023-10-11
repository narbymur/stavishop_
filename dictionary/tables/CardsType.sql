CREATE TABLE IF NOT EXISTS dictionary.cardstype
(
    type_id  SMALLSERIAL NOT NULL
        CONSTRAINT pk_cardstype PRIMARY KEY,
    name     VARCHAR(16) NOT NULL,
    discount SMALLINT    NOT NULL
);
