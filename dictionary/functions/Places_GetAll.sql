CREATE OR REPLACE FUNCTION dictionary.places_getall() RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSON_AGG(ROW_TO_JSON(res)))
        FROM (SELECT p.place_id,
                     p.name
              FROM dictionary.places p) res;
END
$$;