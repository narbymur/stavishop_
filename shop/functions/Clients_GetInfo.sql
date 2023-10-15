CREATE OR REPLACE FUNCTION shop.clients_getinfo(_phone VARCHAR(11)) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT cl.client_id,
                     cl.name,
                     cl.phone,
                     cl.birth_date,
                     cl.gender
              FROM shop.clients cl
              WHERE cl.phone = COALESCE(_phone, cl.phone)) res;
END
$$;