CREATE OR REPLACE FUNCTION shop.clientsupd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _client_id  INT;
    _name       VARCHAR(300);
    _birth_date DATE;
    _gender     CHAR(3);
    _phone      VARCHAR(11);
    _res        JSON;
    _dt         TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT coalesce(c.client_id, nextval('shop.shopsq')) AS client_id,
           c.name,
           c.birth_date,
           c.gender,
           c.phone
    INTO _client_id,
         _name,
         _birth_date,
         _gender,
         _phone
    FROM jsonb_to_record(_src) AS c (client_id  INT,
                                     name       VARCHAR(300),
                                     birth_date DATE,
                                     gender     CHAR(3),
                                     phone      VARCHAR(11));

    IF EXISTS(SELECT 1 FROM shop.clients cl WHERE cl.phone = _phone)
    THEN
        RETURN public.errmessage(_errcode := 'shop.clientsupd.phone.phone_exists',
                                 _msg     := 'Такой телефон у другого человека',
                                 _detail  := NULL);
    END IF;

    WITH ins AS (
        INSERT INTO shop.clients AS cl (client_id,
                                        name,
                                        birth_date,
                                        gender,
                                        phone,
                                        ch_staff_id,
                                        ch_dt)
            SELECT _client_id,
                   _name,
                   _birth_date,
                   _gender,
                   _phone,
                   _ch_staff_id,
                   _dt
            ON CONFLICT (client_id) DO UPDATE
                SET name        = excluded.name,
                    birth_date  = excluded.birth_date,
                    gender      = excluded.gender,
                    phone       = excluded.phone,
                    ch_staff_id = excluded.ch_staff_id,
                    ch_dt       = excluded.ch_dt
            RETURNING cl.*)

       , his AS (
        INSERT INTO history.clientschanges (client_id,
                                            name,
                                            birth_date,
                                            gender,
                                            phone,
                                            ch_staff_id,
                                            ch_dt)
            SELECT i.client_id,
                   i.name,
                   i.birth_date,
                   i.gender,
                   i.phone,
                   i.ch_staff_id,
                   i.ch_dt
            FROM ins i)

    , sync AS (
        INSERT INTO whsync.clientssync (client_id,
                                        name,
                                        birth_date,
                                        gender,
                                        phone,
                                        ch_staff_id,
                                        ch_dt)
    SELECT i.client_id,
           i.name,
           i.birth_date,
           i.gender,
           i.phone,
           i.ch_staff_id,
           i.ch_dt
    FROM ins i)

    SELECT JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(res)))
    INTO _res
    FROM (SELECT i.client_id,
                 i.name
          FROM ins i) res;

    RETURN _res;
END
$$;