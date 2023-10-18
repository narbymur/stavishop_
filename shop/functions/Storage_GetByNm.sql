CREATE OR REPLACE FUNCTION shop.storage_getbynm(_nm_id BIGINT DEFAULT NULL) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSON_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT s.nm_id,
                     s.size,
                     s.quantity,
                     s.ch_staff_id,
                     s.ch_dt
              FROM shop.storage s
              WHERE s.nm_id = COALESCE(_nm_id, s.nm_id)) res;
END
$$;