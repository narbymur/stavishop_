CREATE TABLE shop.Products
(
    product_id INT            NOT NULL,
    name       VARCHAR(30)    NOT NULL,
    price      NUMERIC(10, 2) NOT NULL,
    CONSTRAINT pk_Products PRIMARY KEY (product_id),
    CONSTRAINT ch_price CHECK (Price > 0)
);