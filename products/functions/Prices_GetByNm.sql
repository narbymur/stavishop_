CREATE OR REPLACE FUNCTION products.prices_getbynm(_nm_id BIGINT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT pp.nm_id,
                     pp.price,
                     pp.ch_staff_id,
                     pp.ch_dt
              FROM products.prices pp
              WHERE pp.nm_id = COALESCE(_nm_id, pp.nm_id)) res;
END
$$;