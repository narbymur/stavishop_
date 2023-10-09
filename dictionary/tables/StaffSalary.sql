CREATE TABLE IF NOT EXISTS dictionary.staffsalary
(
    grant_id SMALLSERIAL   NOT NULL
        CONSTRAINT pk_title PRIMARY KEY,
    name     VARCHAR(64)   NOT NULL,
    salary   DECIMAL(8, 2) NOT NULL
);