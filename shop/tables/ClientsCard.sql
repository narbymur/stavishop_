CREATE TABLE IF NOT EXISTS shop.clientscard
(
    client_id INT         NOT NULL,
    card_id   SMALLSERIAL NOT NULL,
    discount  SMALLINT    NOT NULL
);

