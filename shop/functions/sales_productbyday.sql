CREATE OR REPLACE FUNCTION shop.sales_productbyday(_date DATE) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT p.name     AS "Продукт",
                     SUM(s.quantity) AS "Количество",
                     c.name     AS "Имя клиента"
              FROM shop.sales s
                       INNER JOIN shop.products p ON p.product_id = s.product_id
                       INNER JOIN shop.client c ON c.client_id = s.client_id
              WHERE s.date::date = _date) res;
END
$$;
