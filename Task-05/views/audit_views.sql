-- ==================================================
-- TASK 5: AUDIT VIEWS
-- PURPOSE: Provide audit details and analytical summary
-- ==================================================

-- 1. Standard audit view
CREATE OR REPLACE VIEW public.v_audit_activity AS
SELECT
    audit_id,
    schema_name,
    table_name,
    operation,
    changed_by,
    changed_at,
    old_data,
    new_data
FROM public.audit_logs;


-- 2. Materialized view for analytical reporting
CREATE MATERIALIZED VIEW IF NOT EXISTS
public.mv_audit_activity_summary AS
SELECT
    table_name,
    operation,
    COUNT(*) AS total_changes,
    MAX(changed_at) AS last_activity
FROM public.audit_logs
GROUP BY table_name, operation;


-- 3. Unique index for summary identification
CREATE UNIQUE INDEX IF NOT EXISTS
idx_audit_summary_table_operation
ON public.mv_audit_activity_summary (table_name, operation);