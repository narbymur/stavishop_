CREATE OR REPLACE FUNCTION dictionary.productstype_getall() RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSON_AGG(ROW_TO_JSON(res)))
        FROM (SELECT pt.type_id,
                     pt.name
              FROM dictionary.productstype pt) res;
END
$$;