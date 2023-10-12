CREATE OR REPLACE FUNCTION dictionary.cardstype_getall() RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSON_AGG(ROW_TO_JSON(res)))
        FROM (SELECT ct.type_id,
                     ct.name,
                     ct.discount
              FROM dictionary.cardstype ct) res;
END
$$;