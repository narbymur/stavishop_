CREATE OR REPLACE FUNCTION whsync.suppliersdelivery_import(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    SET TIME ZONE 'Europe/Moscow';

    WITH cte AS (SELECT s.delivery_id,
                        s.suppliers_id,
                        s.delivery_info,
                        s.plan_dt,
                        s.is_finished,
                        s.dt,
                        ROW_NUMBER() over (PARTITION BY s.delivery_id ORDER BY s.dt DESC) rn
                 FROM JSONB_TO_RECORDSET(_src) AS s (delivery_id   INT,
                                                     suppliers_id  INT,
                                                     delivery_info JSONB,
                                                     plan_dt       DATE,
                                                     is_finished   BOOLEAN,
                                                     dt            TIMESTAMPTZ))

    INSERT INTO products.suppliersdelivery AS sd (delivery_id,
                                                  suppliers_id,
                                                  delivery_info,
                                                  plan_dt,
                                                  is_finished,
                                                  dt)
    SELECT s.delivery_id,
           s.suppliers_id,
           s.delivery_info,
           s.plan_dt,
           s.is_finished,
           s.dt
    FROM cte s
    WHERE rn = 1
    ON CONFLICT (delivery_id) DO UPDATE
    SET suppliers_id  = excluded.suppliers_id,
        delivery_info = excluded.delivery_info,
        plan_dt       = excluded.plan_dt,
        is_finished   = excluded.is_finished,
        dt            = excluded.dt
    WHERE sd.dt <= excluded.dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;

