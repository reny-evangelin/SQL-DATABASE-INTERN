
-- =====================================================
-- TASK 5: MIGRATION 002 - UP
-- PURPOSE: AUTOMATED AUDIT LOGGING
-- =====================================================

CREATE OR REPLACE FUNCTION public.log_database_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN

        INSERT INTO public.audit_logs
            (schema_name, table_name, operation, new_data)
        VALUES
            (TG_TABLE_SCHEMA, TG_TABLE_NAME, TG_OP, to_jsonb(NEW));

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN

        INSERT INTO public.audit_logs
            (schema_name, table_name, operation, old_data, new_data)
        VALUES
            (TG_TABLE_SCHEMA, TG_TABLE_NAME, TG_OP,
             to_jsonb(OLD), to_jsonb(NEW));

        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO public.audit_logs
            (schema_name, table_name, operation, old_data)
        VALUES
            (TG_TABLE_SCHEMA, TG_TABLE_NAME, TG_OP, to_jsonb(OLD));

        RETURN OLD;

    END IF;

    RETURN NULL;
END;
$$;
