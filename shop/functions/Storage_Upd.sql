CREATE OR REPLACE FUNCTION shop.storage_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN
    INSERT INTO shop.storage AS st (nm_id,
                                    size,
                                    quantity,
                                    ch_staff_id,
                                    ch_dt)
    SELECT p.nm_id,
           s.size,
           SUM(s.quantity),
           _ch_staff_id,
           _dt
    FROM JSONB_TO_RECORDSET(_src) AS s (nm_id       BIGINT,
                                        size        CHAR(3),
                                        quantity    SMALLINT,
                                        ch_staff_id INT,
                                        ch_dt       TIMESTAMPTZ)
             LEFT JOIN products.products p
                       ON p.nm_id = s.nm_id
    GROUP BY p.nm_id, s.size
    ON CONFLICT (nm_id, size) DO UPDATE
        SET quantity    = st.quantity + excluded.quantity,
            ch_staff_id = excluded.ch_staff_id,
            ch_dt       = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;