CREATE OR REPLACE PROCEDURE shop.sales_upd(_src JSONB)
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _date timestamptz := now() AT TIME ZONE 'Europe/Moscow';
BEGIN

    CREATE TEMP TABLE srctemp ON COMMIT DROP
    AS
    SELECT coalesce(s.sales_id, nextval('shop.shop_sq')) AS sales_id,
           s.client_id,
           s.product_id,
           s.quantity
    FROM jsonb_to_recordset(_src) AS s (sales_id int,
                                        client_id int,
                                        product_id int,
                                        quantity int);

    INSERT INTO shop.sales (sales_id,
                            date,
                            client_id,
                            product_id,
                            quantity)
    SELECT s.sales_id,
           _date,
           s.client_id,
           s.product_id,
           s.quantity
    FROM srctemp s
    ON CONFLICT (sales_id) DO UPDATE
        SET date       = excluded.date,
            client_id  = excluded.client_id,
            product_id = excluded.product_id,
            quantity   = excluded.quantity;
END
$$;
