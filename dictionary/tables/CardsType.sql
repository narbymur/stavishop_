CREATE TABLE IF NOT EXISTS dictionary.cardstype
(
    type_id  SMALLSERIAL   NOT NULL
        CONSTRAINT pk_cardstype PRIMARY KEY,
    name     VARCHAR(16)   NOT NULL,
    buyout   NUMERIC(8, 2) NOT NULL,
    discount SMALLINT      NOT NULL
);
