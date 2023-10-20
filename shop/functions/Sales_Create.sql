CREATE OR REPLACE FUNCTION shop.sale_create(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN
    WITH cte AS (SELECT s.client_id,
                        s.nm_id,
                        s.size,
                        s.quantity,
                        SUM(s.quantity*p.price) AS amount
                 FROM JSONB_TO_RECORDSET(_src) AS s (client_id INT,
                                                     nm_id     BIGINT,
                                                     size      CHAR(3),
                                                     quantity  SMALLINT)
                          INNER JOIN products.prices p
                                     ON p.nm_id = s.nm_id
                 GROUP BY s.client_id, s.nm_id, s.size, s.quantity)

    INSERT INTO shop.sales AS ss (sales_id,
                                  client_id,
                                  sale_info,
                                  dt,
                                  ch_staff_id,
                                  ch_dt)
    SELECT nextval('shop.shopsq'),
           c.client_id,
           JSONB_BUILD_OBJECT('nm_id', c.nm_id,
                              'size', c.size,
                              'quantity', c.quantity,
                              'amount', ROUND(((1 - (SELECT ct.discount
                                                     FROM shop.clientscards cc
                                                              INNER JOIN dictionary.cardstype ct
                                                                         ON ct.type_id = cc.type_id
                                                     WHERE cc.client_id = c.client_id) /
                                                    100::NUMERIC) * c.amount)::NUMERIC, 2)),
           _dt,
           _ch_staff_id,
           _dt
    FROM cte c;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;