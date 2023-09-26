CREATE OR REPLACE FUNCTION shop.sales_getbyclient(_client_id int) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT a."Клиент",
                     a."Название продукта",
                     a."Стоимость"
              FROM (SELECT s.client_id               AS "Клиент",
                           p.product_id,
                           p.name                    AS "Название продукта",
                           SUM(p.price * s.quantity) AS "Стоимость"
                    FROM shop.sales s
                             INNER JOIN shop.products p on s.product_id = p.product_id
                    WHERE s.client_id = _client_id
                    GROUP BY s.client_id, p.product_id, p.name) a) res;
END
$$;