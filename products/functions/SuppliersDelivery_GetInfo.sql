CREATE OR REPLACE FUNCTION products.suppliersdelivery_getinfo(_delivery_id INT DEFAULT NULL, _suppliers_id INT DEFAULT NULL) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT sd.delivery_id,
                     sd.suppliers_id,
                     sd.delivery_info,
                     sd.plan_dt,
                     sd.is_finished,
                     sd.dt,
                     sd.ch_staff_id,
                     sd.ch_dt
              FROM products.suppliersdelivery sd
              WHERE sd.delivery_id  = COALESCE(_delivery_id, sd.delivery_id)
                AND sd.suppliers_id = COALESCE(_suppliers_id, sd.suppliers_id)) res;
END
$$;