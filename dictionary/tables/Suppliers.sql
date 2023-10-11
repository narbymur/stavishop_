CREATE TABLE IF NOT EXISTS dictionary.suppliers
(
    suppliers_id SERIAL      NOT NULL
        CONSTRAINT pk_suppliers PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    supp_info    VARCHAR(16) NOT NULL,
    phone        VARCHAR(11) NOT NULL,
    is_active    BOOLEAN     NOT NULL
);