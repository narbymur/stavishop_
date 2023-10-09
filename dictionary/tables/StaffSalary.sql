CREATE TABLE IF NOT EXISTS dictionary.staffsalary
(
    staff_id INT           NOT NULL,
    title_id SMALLSERIAL   NOT NULL
        CONSTRAINT pk_title PRIMARY KEY,
    title    VARCHAR(16)   NOT NULL,
    salary   DECIMAL(8, 2) NOT NULL
);