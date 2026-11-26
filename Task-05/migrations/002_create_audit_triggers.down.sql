DO $$
DECLARE
    tbl TEXT;
BEGIN
    FOREACH tbl IN ARRAY ARRAY[
        'tenants',
        'users',
        'tenant_memberships',
        'tenant_settings',
        'projects',
        'tasks',
        'project_members'
    ]
    LOOP
        IF to_regclass('public.' || tbl) IS NOT NULL THEN
            EXECUTE format(
                'DROP TRIGGER IF EXISTS audit_changes ON public.%I',
                tbl
            );
        END IF;
    END LOOP;
END;
$$;

DROP FUNCTION IF EXISTS public.log_database_changes();