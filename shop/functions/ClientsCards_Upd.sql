CREATE OR REPLACE FUNCTION shop.clientscards_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    INSERT INTO shop.clientscards (card_id,
                                   type_id,
                                   client_id,
                                   is_deleted,
                                   ch_staff_id,
                                   ch_dt)
    SELECT COALESCE(s.card_id, nextval('shop.shopsq')) AS card_id,
           s.type_id,
           s.client_id,
           s.is_deleted,
           _ch_staff_id,
           _dt
    FROM JSONB_TO_RECORD(_src) AS s (card_id BIGINT,
                                     type_id SMALLINT,
                                     client_id INT,
                                     is_deleted BOOLEAN)

    ON CONFLICT (card_id) DO UPDATE
        SET type_id     = excluded.type_id,
            client_id   = excluded.client_id,
            is_deleted  = excluded.is_deleted,
            ch_staff_id = excluded.ch_staff_id,
            ch_dt       = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;