CREATE OR REPLACE FUNCTION dictionary.productscategory_getall() RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSON_AGG(ROW_TO_JSON(res)))
        FROM (SELECT pc.category_id,
                     pc.name
              FROM dictionary.productcategory pc) res;
END
$$;