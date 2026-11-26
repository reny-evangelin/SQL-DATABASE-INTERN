
-- =====================================================
-- TASK 5: MIGRATION 001 - DOWN
-- PURPOSE: REMOVE AUDIT LOG TABLE
-- =====================================================

DROP TABLE IF EXISTS public.audit_logs CASCADE;
