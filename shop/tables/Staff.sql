CREATE TABLE IF NOT EXISTS shop.staff
(
    staff_id INT         NOT NULL
        CONSTRAINT pk_staff PRIMARY KEY,
    grant_id SMALLINT    NOT NULL,
    name     VARCHAR(64) NOT NULL
);