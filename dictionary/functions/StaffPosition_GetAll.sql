CREATE OR REPLACE FUNCTION dictionary.staffposition_getall() RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSON_AGG(ROW_TO_JSON(res)))
        FROM (SELECT sp.position_id,
                     sp.name,
                     sp.salary
              FROM dictionary.staffposition sp) res;
END
$$;