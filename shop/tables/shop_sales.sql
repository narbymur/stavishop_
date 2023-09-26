CREATE TABLE shop.sales
(
    sales_id   INT         NOT NULL,
    date       TIMESTAMPTZ NOT NULL,
    client_id  INT         NOT NULL,
    product_id INT         NOT NULL,
    quantity   INT         NOT NULL,
    CONSTRAINT pk_sales PRIMARY KEY (sales_id),
    CONSTRAINT ch_quantity CHECK (quantity > 0)
);