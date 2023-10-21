CREATE OR REPLACE FUNCTION products.products_getinfo(_nm_id       BIGINT DEFAULT NULL,
                                                     _type_id     SMALLINT DEFAULT NULL,
                                                     _category_id INT DEFAULT NULL) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT p.nm_id,
                     p.type_id,
                     p.category_id,
                     p.description
              FROM products.products p
              WHERE p.nm_id       = COALESCE(_nm_id, p.nm_id)
                AND p.type_id     = COALESCE(_type_id, p.type_id)
                AND p.category_id = COALESCE(_category_id, p.category_id)) res;
END
$$;