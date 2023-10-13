CREATE OR REPLACE FUNCTION dictionary.places_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.places (place_id,
                                   name)
    SELECT COALESCE(p.place_id, nextval('dictionary.places_place_id_seq')) AS place_id,
           s.name
    FROM JSONB_TO_RECORD(_src) AS s (place_id BIGINT,
                                     name     VARCHAR(32))
             LEFT JOIN dictionary.places p
                       ON p.place_id = s.place_id
    ON CONFLICT (place_id) DO UPDATE
        SET name = excluded.name;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;