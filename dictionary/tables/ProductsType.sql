CREATE TABLE IF NOT EXISTS dictionary.productstype
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_producttype PRIMARY KEY,
    name    VARCHAR(16) NOT NULL
);