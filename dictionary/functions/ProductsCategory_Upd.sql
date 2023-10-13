CREATE OR REPLACE FUNCTION dictionary.productscategory_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.productcategory (category_id,
                                            name)
    SELECT COALESCE(pc.category_id, nextval('dictionary.productcategory_category_id_seq')) AS category_id,
           s.name
    FROM JSONB_TO_RECORD(_src) AS s (category_id SMALLINT,
                                     name        VARCHAR(64))
             LEFT JOIN dictionary.productcategory pc
                       ON pc.category_id = s.category_id
    ON CONFLICT (category_id) DO UPDATE
        SET name = excluded.name;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;