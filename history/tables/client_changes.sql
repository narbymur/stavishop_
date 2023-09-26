CREATE TABLE IF NOT EXISTS history.clientchanges
(
    log_id      bigserial   NOT NULL,
    client_id   integer     NOT NULL,
    name        varchar(30) NOT NULL,
    phone       varchar(11),
    dt          timestamptz NOT NULL,
    ch_employee int         NOT NULL
);