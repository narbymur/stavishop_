CREATE TABLE IF NOT EXISTS dictionary.clientscard
(
    card_id  SMALLSERIAL NOT NULL
        CONSTRAINT pk_card PRIMARY KEY,
    name     VARCHAR(16) NOT NULL,
    discount SMALLINT    NOT NULL
);
