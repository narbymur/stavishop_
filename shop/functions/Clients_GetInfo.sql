CREATE OR REPLACE FUNCTION shop.clients_getinfo(_phone VARCHAR(11)) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT cl.client_id,
                     cl.name,
                     cc.card_id,
                     cc.type_id,
                     cl.phone,
                     cl.birth_date,
                     cl.gender
              FROM shop.clients cl
                       LEFT JOIN shop.clientscards cc
                                 ON cl.client_id = cc.client_id AND cc.is_deleted = false
              WHERE cl.phone = COALESCE(_phone, cl.phone)) res;
END
$$;