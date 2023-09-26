CREATE OR REPLACE FUNCTION shop.sales_productprice() RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (select p.product_id,
                     p.name       AS "Название продукта",
                     p.price      AS "Цена"
              FROM shop.products p
              WHERE p.price BETWEEN 100 AND 300
              ORDER BY p.price DESC) res;
END
$$;
