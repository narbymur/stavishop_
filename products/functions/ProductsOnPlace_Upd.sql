CREATE OR REPLACE FUNCTION products.productsonplace_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    WITH cte AS (
        SELECT p.place_id,
               s.room_id,
               s.nm_id,
               s.quantity,
               s.is_replace
        FROM JSONB_TO_RECORDSET(_src) AS s (place_id   BIGINT,
                                            room_id    BIGINT,
                                            nm_id      BIGINT,
                                            quantity   SMALLINT,
                                            is_replace BOOLEAN)
                 LEFT JOIN dictionary.places p
                           ON p.place_id = s.place_id)
       , ins_cte AS (
           INSERT INTO products.productsonplace AS pop (place_id,
                                                        room_id,
                                                        nm_id,
                                                        quantity)
        SELECT c.place_id,
               c.room_id,
               c.nm_id,
               c.quantity
        FROM cte c
        ON CONFLICT (place_id, nm_id) DO UPDATE
            SET room_id = excluded.room_id,
                quantity = (SELECT CASE
                                       WHEN c.is_replace = TRUE
                                           THEN pop.quantity - excluded.quantity
                                       ELSE pop.quantity + excluded.quantity
                                       END
                            FROM cte c
                            WHERE c.place_id = excluded.place_id
                              AND c.nm_id = excluded.nm_id)
                  RETURNING pop.*)

    INSERT INTO whsync.productsonplacesync (place_id,
                                            room_id,
                                            nm_id,
                                            quantity)
    SELECT i.place_id,
           i.room_id,
           i.nm_id,
           i.quantity
    FROM ins_cte i;


    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;