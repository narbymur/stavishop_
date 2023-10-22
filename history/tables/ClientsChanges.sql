CREATE TABLE IF NOT EXISTS history.clientschanges
(
    log_id      BIGSERIAL    NOT NULL,
    client_id   INT          NOT NULL,
    name        VARCHAR(300) NOT NULL,
    birth_date  DATE         NOT NULL,
    gender      CHAR(3)      NOT NULL,
    phone       VARCHAR(11)  NOT NULL,
    ch_staff_id INT          NOT NULL,
    ch_dt       TIMESTAMPTZ  NOT NULL
) PARTITION BY RANGE (ch_dt);

CREATE INDEX IF NOT EXISTS ix_clientschanges_ch_dt ON history.clientschanges (ch_dt);

CREATE INDEX IF NOT EXISTS ix_clientschanges_log_id ON history.clientschanges (log_id);

CREATE TABLE history.clientschanges_202310 PARTITION OF history.clientschanges FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');
CREATE TABLE history.clientschanges_202311 PARTITION OF history.clientschanges FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');
CREATE TABLE history.clientschanges_202312 PARTITION OF history.clientschanges FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');
CREATE TABLE history.clientschanges_202401 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');
CREATE TABLE history.clientschanges_202402 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');
CREATE TABLE history.clientschanges_202403 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');
CREATE TABLE history.clientschanges_202404 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');
CREATE TABLE history.clientschanges_202405 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');
CREATE TABLE history.clientschanges_202406 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');
CREATE TABLE history.clientschanges_202407 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');
CREATE TABLE history.clientschanges_202408 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');
CREATE TABLE history.clientschanges_202409 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');
CREATE TABLE history.clientschanges_202410 PARTITION OF history.clientschanges FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');