CREATE OR REPLACE FUNCTION dictionary.productstype_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.productstype (type_id,
                                         name)
    SELECT COALESCE(pt.type_id, nextval('dictionary.productstype_type_id_seq')) AS type_id,
           s.name
    FROM jsonb_to_record(_src) AS s (type_id  SMALLINT,
                                     name     VARCHAR(16))
             LEFT JOIN dictionary.productstype pt
                       ON pt.type_id = s.type_id
    ON CONFLICT (type_id) DO UPDATE
        SET name = excluded.name;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;