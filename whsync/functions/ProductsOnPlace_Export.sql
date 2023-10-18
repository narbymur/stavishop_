CREATE OR REPLACE FUNCTION whsync.productsonplace_export(_log_id BIGINT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt  TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _res JSONB;
BEGIN
    DELETE
    FROM whsync.productsonplacesync pops
    WHERE pops.log_id <= _log_id
      AND pops.sync_dt IS NOT NULL;

    WITH sync_cte AS (SELECT pops.log_id,
                             pops.place_id,
                             pops.room_id,
                             pops.nm_id,
                             pops.quantity
                      FROM whsync.productsonplacesync pops
                      ORDER BY pops.log_id
                      LIMIT 1000)

       , cte_upd AS (
        UPDATE whsync.productsonplacesync pops
            SET sync_dt = _dt
            FROM sync_cte sc
            WHERE pops.log_id = sc.log_id)

    SELECT JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(sc)))
    INTO _res
    FROM sync_cte sc;

    RETURN _res;
END
$$;