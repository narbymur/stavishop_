CREATE OR REPLACE FUNCTION dictionary.rooms_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.rooms (rooms_id,
                                  name)
    SELECT COALESCE(r.rooms_id, nextval('dictionary.rooms_rooms_id_seq')) AS rooms_id,
           s.name
    FROM JSONB_TO_RECORD(_src) AS s (rooms_id BIGINT,
                                     name     VARCHAR(32))
             LEFT JOIN dictionary.rooms r
                       ON r.rooms_id = s.rooms_id
    ON CONFLICT (rooms_id) DO UPDATE
        SET name = excluded.name;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;