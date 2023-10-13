CREATE OR REPLACE FUNCTION dictionary.suppliers_getall() RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSON_AGG(ROW_TO_JSON(res)))
        FROM (SELECT sup.suppliers_id,
                     sup.name,
                     sup.supp_info,
                     sup.phone,
                     sup.is_active
              FROM dictionary.suppliers sup) res;
END
$$;