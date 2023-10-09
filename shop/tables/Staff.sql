CREATE TABLE IF NOT EXISTS shop.staff
(
    staff_id INT         NOT NULL
        CONSTRAINT pk_staff PRIMARY KEY,
    title_id SMALLSERIAL NOT NULL,
    title    VARCHAR(16) NOT NULL
);