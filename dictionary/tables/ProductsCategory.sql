CREATE TABLE IF NOT EXISTS dictionary.productcategory
(
    category_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_productcategory PRIMARY KEY,
    name        VARCHAR(64) NOT NULL
);