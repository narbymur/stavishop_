CREATE OR REPLACE FUNCTION whsync.clientsexport(_log_id BIGINT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt  TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _res JSONB;
BEGIN
    DELETE
    FROM whsync.clientssync cs
    WHERE cs.log_id <= _log_id
      AND cs.sync_dt IS NOT NULL;

    WITH sync_cte AS (SELECT cs.log_id,
                             cs.client_id,
                             cs.name,
                             cs.birth_date,
                             cs.gender,
                             cs.phone,
                             cs.ch_staff_id,
                             cs.ch_dt
                      FROM whsync.clientssync cs
                      ORDER BY cs.log_id
                      LIMIT 1000)

       , cte_upd AS (
        UPDATE whsync.clientssync cs
            SET sync_dt = _dt
            FROM sync_cte sc
            WHERE cs.log_id = sc.log_id)

    SELECT JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(sc)))
    INTO _res
    FROM sync_cte sc;

    RETURN _res;
END
$$;