CREATE TABLE IF NOT EXISTS dictionary.suppliers
(
    supplier_id SERIAL      NOT NULL
        CONSTRAINT pk_suppliers PRIMARY KEY,
    name        VARCHAR(32) NOT NULL,
    info        VARCHAR(16) NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    is_active   BOOLEAN     NOT NULL
);