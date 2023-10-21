CREATE OR REPLACE PROCEDURE products.suppliersdelivery_finished(_delivery_id INT,
                                                                _ch_staff_id INT,
                                                                _delivery_dt TIMESTAMPTZ)
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN
    UPDATE products.suppliersdelivery sd
    SET is_finished = TRUE,
        dt          = _delivery_dt,
        ch_staff_id = _ch_staff_id,
        ch_dt       = _dt
    WHERE sd.delivery_id = _delivery_id;
END
$$;