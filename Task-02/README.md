# Task 2 – TaskFlow SaaS

## Project Overview

TaskFlow is a multi-tenant Project Management SaaS database designed using PostgreSQL.

The database supports multiple organisations (tenants), users, projects, tasks, and project assignments while maintaining referential integrity and tenant-level data isolation.

## Database Design

The database contains seven related tables:

1. `tenants` – Stores organisation information.
2. `users` – Stores user information.
3. `tenant_memberships` – Connects users with tenants and their roles.
4. `tenant_settings` – Stores tenant-specific settings.
5. `projects` – Stores projects belonging to tenants.
6. `tasks` – Stores tasks belonging to projects.
7. `project_members` – Assigns tenant members to projects.

## Relationships

- Tenants and tenant settings: One-to-One (optional settings).
- Tenants and projects: One-to-Many.
- Projects and tasks: One-to-Many.
- Users and tenants: Many-to-Many through `tenant_memberships`.
- Users and projects: Many-to-Many through `project_members`.

## Normalization

The schema is designed to satisfy Third Normal Form (3NF).

- Atomic values are maintained in individual columns.
- Junction tables resolve many-to-many relationships.
- Composite primary and foreign keys enforce relationship integrity.
- Redundant user, tenant, and project information is avoided.

## Implementation

The database uses:

- Primary Keys
- Foreign Keys
- Composite Keys
- NOT NULL constraints
- UNIQUE constraints
- CHECK constraints
- ON DELETE CASCADE
- ON UPDATE CASCADE

## Project Files

| File | Description |
|---|---|
| `ER-diagram.png` | Entity-Relationship diagram |
| `er-diagram.md` | ER diagram source |
| `schema.sql` | Database table creation scripts |
| `seed_data.sql` | Sample data insertion scripts |
| `integrity_tests.sql` | Referential integrity and cascading tests |

## Execution Order

Run the SQL files in this order:

1. `schema.sql`
2. `seed_data.sql`
3. `integrity_tests.sql`

## Testing Results

All five integrity tests passed successfully:

- Invalid project reference rejected.
- Cross-tenant project assignment rejected.
- Invalid user membership rejected.
- Cascading DELETE verified.
- Cascading UPDATE verified.

## Technology Used

- PostgreSQL
- pgAdmin 4
- SQL
- GitHub

---

**Internship Task:** Task 2 – Relational Schema Modeling & 3NF Normalization  
**Project:** TaskFlow SaaS
