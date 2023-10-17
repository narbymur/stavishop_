CREATE OR REPLACE FUNCTION products.prices_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _res   JSONB;
    _nm_id BIGINT;
    _price NUMERIC(8, 2);
    _dt    TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT p.nm_id AS nm_id,
           s.price
    INTO _nm_id, _price
    FROM JSONB_TO_RECORD(_src) AS s (nm_id BIGINT,
                                     price NUMERIC(8, 2))
             LEFT JOIN products.products p
                       ON p.nm_id = s.nm_id;

    IF _nm_id IS NULL
    THEN
        RETURN public.errmessage(_errcode := 'products.prices_upd.nm.nm_not_found',
                                 _msg     := 'Такой номенклатуры не существует!',
                                 _detail  := NULL);
    END IF;

    WITH ins AS (
        INSERT INTO products.prices AS pp (nm_id,
                                           price,
                                           ch_staff_id,
                                           ch_dt)
            SELECT _nm_id,
                   _price,
                   _ch_staff_id,
                   _dt
            ON CONFLICT (nm_id) DO UPDATE
                SET price       = excluded.price,
                    ch_staff_id = excluded.ch_staff_id,
                    ch_dt       = excluded.ch_dt
            RETURNING pp.*)

       , his AS (
        INSERT INTO history.priceschanges (nm_id,
                                           price,
                                           ch_staff_id,
                                           ch_dt)
            SELECT i.nm_id,
                   i.price,
                   i.ch_staff_id,
                   i.ch_dt
            FROM ins i)

    SELECT JSONB_BUILD_OBJECT('data', NULL)
    INTO _res;

    RETURN _res;
END
$$;