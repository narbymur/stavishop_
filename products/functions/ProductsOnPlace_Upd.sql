CREATE OR REPLACE FUNCTION products.productsonplace_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO products.productsonplace AS pop (place_id,
                                                 room_id,
                                                 nm_id,
                                                 quantity)
    SELECT p.place_id,
           s.room_id,
           s.nm_id,
           s.quantity
    FROM JSONB_TO_RECORDSET(_src) AS s (place_id BIGINT,
                                        room_id  BIGINT,
                                        nm_id    BIGINT,
                                        quantity SMALLINT)
             LEFT JOIN dictionary.places p
                       ON p.place_id = s.place_id
    ON CONFLICT (place_id, nm_id) DO UPDATE
        SET room_id  = excluded.room_id,
            quantity = pop.quantity + excluded.quantity;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;