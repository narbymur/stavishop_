CREATE OR REPLACE FUNCTION shop.staff_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _staff_id    INT;
    _position_id SMALLINT;
    _name        VARCHAR(64);
    _phone       VARCHAR(11);
    _birth_date  DATE;
    _is_active   BOOLEAN;
    _dt          TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT COALESCE(s.staff_id, nextval('shop.shopsq')) AS staff_id,
           s.position_id,
           s.name,
           s.phone,
           s.birth_date,
           s.is_active
    INTO _staff_id,
         _position_id,
         _name,
         _phone,
         _birth_date,
         _is_active
    FROM JSONB_TO_RECORD(_src) AS s (staff_id    INT,
                                     position_id SMALLINT,
                                     name        VARCHAR(64),
                                     phone       VARCHAR(11),
                                     birth_date  DATE,
                                     is_active   BOOLEAN);

    IF EXISTS(SELECT 1 FROM shop.staff st WHERE st.phone = _phone)
    THEN
        RETURN public.errmessage(_errcode := 'shop.staffupd.phone.phone_exists',
                                 _msg     := 'Такой телефон у другого человека',
                                 _detail  := NULL);
    END IF;

    WITH ins AS (
        INSERT INTO shop.staff AS st (staff_id,
                                      position_id,
                                      name,
                                      phone,
                                      birth_date,
                                      is_active,
                                      ch_staff_id,
                                      ch_dt)
            SELECT _staff_id,
                   _position_id,
                   _name,
                   _phone,
                   _birth_date,
                   _is_active,
                   _ch_staff_id,
                   _dt
            ON CONFLICT (staff_id) DO UPDATE
                SET position_id = excluded.position_id,
                    name        = excluded.name,
                    phone       = excluded.phone,
                    birth_date  = excluded.birth_date,
                    is_active   = excluded.is_active,
                    ch_staff_id = excluded.ch_staff_id,
                    ch_dt       = excluded.ch_dt
            RETURNING st.*)

       , his AS (
        INSERT INTO history.staffchanges (staff_id,
                                          position_id,
                                          name,
                                          phone,
                                          birth_date,
                                          is_active,
                                          ch_staff_id,
                                          ch_dt)
            SELECT i.staff_id,
                   i.position_id,
                   i.name,
                   i.phone,
                   i.birth_date,
                   i.is_active,
                   i.ch_staff_id,
                   i.ch_dt
            FROM ins i)

    INSERT INTO whsync.staffsync (staff_id,
                                  position_id,
                                  name,
                                  phone,
                                  birth_date,
                                  is_active,
                                  ch_staff_id,
                                  ch_dt)
    SELECT i.staff_id,
           i.position_id,
           i.name,
           i.phone,
           i.birth_date,
           i.is_active,
           i.ch_staff_id,
           i.ch_dt
    FROM ins i;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;