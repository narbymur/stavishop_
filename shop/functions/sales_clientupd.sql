CREATE OR REPLACE FUNCTION shop.client_upd(_src jsonb, _employee_id int) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _name       varchar(30);
    _phone      varchar(11);
    _client_id  int;
    _is_deleted boolean;
    _dt         timestamptz := now();
BEGIN
    SET TIME ZONE 'Europe/Moscow';

    SELECT coalesce(s.client_id, nextval('shop.prodseq')) AS client_id,
           s.name,
           s.phone,
           s.is_deleted
    INTO _client_id, _name, _phone, _is_deleted
    FROM jsonb_to_record(_src) AS s (client_id int,
                                     name varchar(30),
                                     phone varchar(11),
                                     is_deleted boolean);
    IF _is_deleted = TRUE
    THEN
        DELETE
        FROM shop.client c
        WHERE c.client_id = _client_id
          AND _is_deleted = TRUE;

        RETURN jsonb_build_object('data', NULL);
    END IF;

    IF exists(SELECT 1 FROM shop.client c WHERE c.phone = _phone)
    THEN
        RETURN public.errmessage(_errcode := 'shop.client_ins.phone_exists',
                                 _msg := 'Такой номер телефона уже принадлежит другому пользователю!',
                                 _detail := concat('phone = ', _phone));
    END IF;

    INSERT INTO shop.client AS c(client_id,
                                 name,
                                 phone,
                                 dt,
                                 ch_employee)
    SELECT _client_id,
           _name,
           _phone,
           _dt,
           _employee_id
    ON CONFLICT (client_id) DO UPDATE
        SET name        = excluded.name,
            phone       = excluded.phone,
            dt          = excluded.dt,
            ch_employee = excluded.ch_employee;

    INSERT INTO history.clientchanges (client_id,
                                       name,
                                       phone,
                                       dt,
                                       ch_employee)
    SELECT _client_id,
           _name,
           _phone,
           _dt,
           _employee_id;

    RETURN jsonb_build_object('data', NULL);
END
$$;