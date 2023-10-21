CREATE OR REPLACE FUNCTION products.products_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN
    INSERT INTO products.products (nm_id,
                                   type_id,
                                   category_id,
                                   description,
                                   ch_staff_id,
                                   ch_dt)
    SELECT COALESCE(p.nm_id, nextval('products.productssq')) AS nm_id,
           s.type_id,
           s.category_id,
           s.description,
           _ch_staff_id,
           _dt
    FROM JSONB_TO_RECORD(_src) AS s (nm_id BIGINT,
                                     type_id SMALLINT,
                                     category_id INT,
                                     description JSONB)
             LEFT JOIN products.products p
                       ON p.nm_id = s.nm_id
    ON CONFLICT (nm_id) DO UPDATE
        SET type_id     = excluded.type_id,
            category_id = excluded.category_id,
            description = excluded.description,
            ch_staff_id = excluded.ch_staff_id,
            ch_dt       = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;