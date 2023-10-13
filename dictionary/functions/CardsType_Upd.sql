CREATE OR REPLACE FUNCTION dictionary.cardstype_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.cardstype (type_id,
                                      name,
                                      discount)
    SELECT COALESCE(ct.type_id, nextval('dictionary.cardstype_type_id_seq')) AS type_id,
           s.name,
           s.discount
    FROM JSONB_TO_RECORD(_src) AS s (type_id  SMALLINT,
                                     name     VARCHAR(16),
                                     discount SMALLINT)
             LEFT JOIN dictionary.cardstype ct
                       ON ct.type_id = s.type_id
    ON CONFLICT (type_id) DO UPDATE
        SET name     = excluded.name,
            discount = excluded.discount;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;