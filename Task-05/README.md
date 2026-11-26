# Task 5: Production Database Migration & Backup Strategy Capstone

## 1. Project Overview

This project implements production-oriented database migration, automated audit logging, analytical views, stored procedures, and PostgreSQL backup and disaster recovery documentation.

**Database:** TaskFlow SaaS  
**DBMS:** PostgreSQL

## 2. Objectives

- Implement version-controlled database migrations.
- Create UP and DOWN migration scripts.
- Automate database audit logging using triggers.
- Develop stored procedures for audit summary refresh.
- Create standard and materialized views for analytical reporting.
- Document database backup and disaster recovery procedures.

## 3. Project Structure

```text
Task-05/
│
├── migrations/
│   ├── 001_create_audit_logs.up.sql
│   ├── 001_create_audit_logs.down.sql
│   ├── 002_create_audit_triggers.up.sql
│   └── 002_create_audit_triggers.down.sql
│
├── procedures/
│   └── audit_procedures.sql
│
├── views/
│   └── audit_views.sql
│
├── backup/
│   └── backup_restore_guide.md
│
└── README.md
```

## 4. Database Migrations

### Migration 001: Audit Logs

Creates the `audit_logs` table with:

- Unique audit ID
- Schema and table names
- Operation type
- Old and new record data in JSONB format
- User who performed the operation
- Timestamp of the change

Indexes are created for table name and change timestamp.

### Migration 002: Audit Triggers

Creates the `log_database_changes()` trigger function and attaches audit triggers to the TaskFlow tables.

The triggers capture:
- INSERT operations
- UPDATE operations
- DELETE operations

Each operation is automatically recorded in the audit_logs table.

## 5. Stored Procedures

**Procedure:** `public.refresh_audit_summary()`

Refresh
