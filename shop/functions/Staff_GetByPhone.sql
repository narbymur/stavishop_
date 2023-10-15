CREATE OR REPLACE FUNCTION shop.staff_getbyphone(_phone VARCHAR(11)) RETURNS JSONB
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
              WHERE s.phone = _phone) res;
END
$$;