CREATE OR REPLACE FUNCTION shop.sales_sumproductavg() RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT c.client_id,
                     c.name          AS "Имя клиента",
                     SUM(s.quantity) AS "Суммарное количество товара"
              FROM shop.sales s
                       INNER JOIN shop.client c ON c.client_id = s.client_id
              GROUP BY c.client_id, c.name
              HAVING SUM(s.quantity) > (SELECT AVG(quantity) FROM shop.sales s)) res;
END
$$;