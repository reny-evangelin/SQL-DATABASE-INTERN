
erDiagram
    TENANTS ||--o{ TENANT_MEMBERSHIPS : has
    USERS ||--o{ TENANT_MEMBERSHIPS : joins

    TENANTS ||--|| TENANT_SETTINGS : has
    TENANTS ||--o{ PROJECTS : owns

    PROJECTS ||--o{ TASKS : contains
    PROJECTS ||--o{ PROJECT_MEMBERS : has
    TENANT_MEMBERSHIPS ||--o{ PROJECT_MEMBERS : assigns

    TENANTS {
        int tenant_id PK
        varchar tenant_name
        timestamp created_at
    }

    USERS {
        int user_id PK
        varchar full_name
        varchar email UK
    }

    TENANT_MEMBERSHIPS {
        int tenant_id PK, FK
        int user_id PK, FK
        varchar role
        timestamp joined_at
    }

    TENANT_SETTINGS {
        int tenant_id PK, FK
        varchar timezone
        varchar subscription_plan
    }

    PROJECTS {
        int tenant_id PK, FK
        int project_id PK
        varchar project_name
        varchar status
    }

    TASKS {
        int tenant_id PK, FK
        int project_id PK, FK
        int task_id PK
        varchar title
        varchar status
        date due_date
    }

    PROJECT_MEMBERS {
        int tenant_id PK, FK
        int project_id PK, FK
        int user_id PK, FK
        timestamp assigned_at
    }
