
-- =====================================================
-- TASK 5: MIGRATION 001 - UP
-- PURPOSE: CREATE AUDIT LOG TABLE
-- DATABASE: taskflow_saas
-- =====================================================

CREATE TABLE IF NOT EXISTS public.audit_logs (
    audit_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    schema_name TEXT NOT NULL,
    table_name TEXT NOT NULL,
    operation TEXT NOT NULL
        CHECK (operation IN ('INSERT', 'UPDATE', 'DELETE')),
    old_data JSONB,
    new_data JSONB,
    changed_by TEXT NOT NULL DEFAULT CURRENT_USER,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_audit_logs_table
ON public.audit_logs (table_name);

CREATE INDEX IF NOT EXISTS idx_audit_logs_changed_at
ON public.audit_logs (changed_at);
