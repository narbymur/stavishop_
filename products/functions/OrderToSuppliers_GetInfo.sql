CREATE OR REPLACE FUNCTION products.ordertosuppliers_getinfo(_order_id INT DEFAULT NULL, _suppliers_id INT DEFAULT NULL) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT os.order_id,
                     os.suppliers_id,
                     os.order_info,
                     os.is_finished,
                     os.dt
              FROM products.ordertosupplier os
              WHERE os.order_id     = COALESCE(_order_id, os.order_id)
                AND os.suppliers_id = COALESCE(_suppliers_id, os.suppliers_id)) res;
END
$$;