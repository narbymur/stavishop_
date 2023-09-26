CREATE OR REPLACE FUNCTION public.errmessage(_errcode VARCHAR, _msg VARCHAR, _detail VARCHAR) RETURNS JSONB
    LANGUAGE plpgsql
AS
$$
DECLARE
    _errors JSONB;
BEGIN
    SELECT JSONB_AGG(ROW_TO_JSON(s))
    FROM (
        SELECT _errcode error,
               _msg     message,
               _detail  detail) s
    INTO _errors;

    RETURN JSONB_OBJECT_AGG('errors', _errors)::JSONB;
END;
$$;