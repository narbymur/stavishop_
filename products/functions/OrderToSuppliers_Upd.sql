CREATE OR REPLACE FUNCTION products.ordertosuppliers_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _order_id     INT;
    _suppliers_id INT;
    _order_info   JSONB;
    _is_finished  BOOLEAN;
    _dt           TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT COALESCE(s.order_id, nextval('shop.shopsq')) AS order_id,
           sup.suppliers_id,
           s.order_info,
           s.is_finished,
           s.dt
    INTO _order_id,
        _suppliers_id,
        _order_info,
        _is_finished,
        _dt
    FROM JSONB_TO_RECORD(_src) AS s (order_id     INT,
                                     suppliers_id INT,
                                     order_info   JSONB,
                                     is_finished  BOOLEAN,
                                     dt           TIMESTAMPTZ)
             LEFT JOIN dictionary.suppliers sup
                       ON sup.suppliers_id = s.suppliers_id;

    WITH cte AS (
        INSERT INTO products.ordertosupplier AS os (order_id,
                                                    suppliers_id,
                                                    order_info,
                                                    is_finished,
                                                    dt,
                                                    ch_staff_id,
                                                    ch_dt)
            SELECT _order_id,
                   _suppliers_id,
                   _order_info,
                   _is_finished,
                   _dt,
                   _ch_staff_id,
                   _dt
            ON CONFLICT (order_id) DO UPDATE
                SET order_id     = excluded.order_id,
                    suppliers_id = excluded.suppliers_id,
                    order_info   = excluded.order_info,
                    is_finished  = excluded.is_finished,
                    dt           = excluded.dt,
                    ch_staff_id  = excluded.ch_staff_id,
                    ch_dt        = excluded.ch_dt
            RETURNING os.*)

        INSERT INTO whsync.ordertosupplierssync (order_id,
                                                 suppliers_id,
                                                 order_info,
                                                 is_finished,
                                                 dt,
                                                 ch_staff_id,
                                                 ch_dt)
            SELECT c.order_id,
                   c.suppliers_id,
                   c.order_info,
                   c.is_finished,
                   c.dt,
                   c.ch_staff_id,
                   c.ch_dt
            FROM cte c;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;