CREATE OR REPLACE FUNCTION dictionary.staffposition_upd(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO dictionary.staffposition (position_id,
                                          name,
                                          salary)
    SELECT COALESCE(sp.position_id, nextval('dictionary.staffposition_position_id_seq')) AS position_id,
           s.name,
           s.salary
    FROM JSONB_TO_RECORD(_src) AS s (position_id SMALLINT,
                                     name VARCHAR(64),
                                     salary DECIMAL(8, 2))
             LEFT JOIN dictionary.staffposition sp
                       ON sp.position_id = s.position_id
    ON CONFLICT (position_id) DO UPDATE
        SET name   = excluded.name,
            salary = excluded.salary;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;