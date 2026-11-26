-- ==================================================
-- TASK 5: AUDIT PROCEDURES
-- PURPOSE: Refresh audit summary materialized view
-- ==================================================

CREATE OR REPLACE PROCEDURE public.refresh_audit_summary()
LANGUAGE plpgsql
AS $$
BEGIN
    REFRESH MATERIALIZED VIEW
    public.mv_audit_activity_summary;
END;
$$;