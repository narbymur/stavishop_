CREATE TABLE IF NOT EXISTS dictionary.staffposition
(
    position_id SMALLSERIAL   NOT NULL
        CONSTRAINT pk_position PRIMARY KEY,
    name        VARCHAR(64)   NOT NULL,
    salary      DECIMAL(8, 2) NOT NULL
);