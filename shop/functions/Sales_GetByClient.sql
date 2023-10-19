CREATE OR REPLACE FUNCTION shop.sales_getbyclient(_client_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT s.client_id,
                     s.sale_info,
                     s.dt,
                     s.ch_staff_id,
                     s.ch_dt
              FROM shop.sales s
              WHERE s.client_id = _client_id) res;
END
$$;