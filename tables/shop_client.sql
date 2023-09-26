CREATE TABLE shop.client
(
    client_id INT         NOT NULL,
    name      VARCHAR(30) NOT NULL,
    phone     VARCHAR(11),
    CONSTRAINT pk_client PRIMARY KEY (client_id)
);