CREATE OR REPLACE FUNCTION dictionary.suppliers_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.suppliers (suppliers_id,
                                      name,
                                      supp_info,
                                      phone,
                                      is_active)
    SELECT COALESCE(sup.suppliers_id, nextval('dictionary.suppliers_suppliers_id_seq')) AS suppliers_id,
           s.name,
           s.supp_info,
           s.phone,
           s.is_active
    FROM JSONB_TO_RECORD(_src) AS s (suppliers_id INT,
                                     name VARCHAR(32),
                                     supp_info VARCHAR(16),
                                     phone VARCHAR(11),
                                     is_active BOOLEAN)
             LEFT JOIN dictionary.suppliers sup
                       ON sup.suppliers_id = s.suppliers_id
    ON CONFLICT (suppliers_id) DO UPDATE
        SET name      = excluded.name,
            supp_info = excluded.supp_info,
            phone     = excluded.phone,
            is_active = excluded.is_active;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;