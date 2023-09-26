CREATE OR REPLACE FUNCTION shop.sales_clientbyproduct(_product_id int) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT s.product_id AS "Продукт",
                     c.client_id,
                     c.name       AS "Имя",
                     c.phone      AS "Телефон"
              FROM shop.sales s
                       INNER JOIN shop.client c on s.client_id = c.client_id
              WHERE s.product_id = _product_id) res;
END
$$;