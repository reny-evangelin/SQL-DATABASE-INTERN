# PostgreSQL Backup and Disaster Recovery Guide

## 1. Introduction

This guide explains how to back up and restore the TaskFlow SaaS PostgreSQL database.

Database backups help protect important information against accidental deletion, system failures, and data corruption.

## 2. Database Information

- Database name: `taskflow_saas`
- Database system: PostgreSQL
- Backup utility: `pg_dump`
- Restore utility: `pg_restore`

## 3. Creating a Database Backup

Run the following command in Windows Command Prompt or PowerShell:

```bash
pg_dump -U postgres -h localhost -p 5432 -F c -b -v -f "taskflow_backup.dump" taskflow_saas
```

This creates a compressed custom-format backup file named `taskflow_backup.dump`.

You will be prompted for the PostgreSQL password if required.

## 4. Restoring a Database Backup

First, create an empty database named `taskflow_saas_restore`.

Then execute:

```bash
pg_restore -U postgres -h localhost -p 5432 -d taskflow_saas_restore -v "taskflow_backup.dump"
```

This restores the database contents into the new database.

## 5. Backup Best Practices

- Perform regular database backups.
- Store backup files in a secure location.
- Keep copies on a separate drive or secure cloud storage.
- Protect backup files with appropriate access permissions.
- Never store database passwords directly in scripts or GitHub.
- Periodically test database restoration.

## 6. Disaster Recovery Strategy

In case