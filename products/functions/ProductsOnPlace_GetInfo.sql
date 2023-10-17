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
              WHERE _nm_id    = COALESCE(pp.nm_id, _nm_id)
                AND _place_id = COALESCE(pp.place_id, _place_id)
                AND _room_id  = COALESCE(pp.room_id, _room_id)) res;
END
$$;