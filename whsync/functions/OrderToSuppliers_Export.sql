CREATE OR REPLACE FUNCTION whsync.ordertosuppliers_export(_log_id BIGINT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt  TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _res JSONB;
BEGIN
    DELETE
    FROM whsync.ordertosupplierssync os
    WHERE os.log_id <= _log_id
      AND os.sync_dt IS NOT NULL;

    WITH sync_cte AS (SELECT os.log_id,
                             os.order_id,
                             os.suppliers_id,
                             os.order_info,
                             os.dt
                      FROM whsync.ordertosupplierssync os
                      ORDER BY os.log_id
                      LIMIT 1000)

       , cte_upd AS (
        UPDATE whsync.ordertosupplierssync os
            SET sync_dt = _dt
            FROM sync_cte sc
            WHERE os.log_id = sc.log_id)

    SELECT JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(sc)))
    INTO _res
    FROM sync_cte sc;

    RETURN _res;
END
$$;