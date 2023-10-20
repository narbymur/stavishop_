CREATE OR REPLACE FUNCTION products.productsonplace_getinfo(_nm_id    BIGINT DEFAULT NULL,
                                                            _place_id BIGINT DEFAULT NULL,
                                                            _room_id  BIGINT DEFAULT NULL) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT pp.place_id,
                     pp.room_id,
                     pp.nm_id,
                     pp.quantity
              FROM products.productsonplace pp
              WHERE pp.nm_id    = COALESCE(_nm_id, pp.nm_id)
                AND pp.place_id = COALESCE(_place_id, pp.place_id)
                AND pp.room_id  = COALESCE(_room_id, pp.room_id)) res;
END
$$;