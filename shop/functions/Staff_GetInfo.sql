CREATE OR REPLACE FUNCTION shop.staff_getinfo(_position_id SMALLINT, _phone VARCHAR(11)) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
        FROM (SELECT s.staff_id,
                     s.position_id,
                     s.name,
                     s.phone,
                     s.birth_date,
                     s.is_active
              FROM shop.staff s
              WHERE s.position_id = COALESCE(_position_id, s.position_id)
                AND s.phone       = COALESCE(_phone, s.phone)) res;
END
$$;