
-- =========================================
-- TASK 2: PROJECT MANAGEMENT SAAS
-- Database: TaskFlow
-- =========================================

-- TABLE 1: TENANTS
-- Stores organisation details

CREATE TABLE tenants (
    tenant_id INTEGER GENERATED ALWAYS AS IDENTITY,
    tenant_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_tenants PRIMARY KEY (tenant_id),
    CONSTRAINT uq_tenant_name UNIQUE (tenant_name)
);



-- TABLE 2: USERS
-- Stores application user accounts

CREATE TABLE users (
    user_id INTEGER GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,

    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT uq_users_email UNIQUE (email)
);



-- TABLE 3: TENANT_MEMBERSHIPS
-- Connects users with organisations

CREATE TABLE tenant_memberships (
    tenant_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    role VARCHAR(20) NOT NULL,
    joined_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_tenant_memberships
        PRIMARY KEY (tenant_id, user_id),

    CONSTRAINT fk_membership_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tenants(tenant_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_membership_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_membership_role
        CHECK (role IN ('owner', 'admin', 'member'))
);



-- TABLE 4: TENANT_SETTINGS
-- Stores settings for each organisation

CREATE TABLE tenant_settings (
    tenant_id INTEGER NOT NULL,
    timezone VARCHAR(50) NOT NULL DEFAULT 'UTC',
    subscription_plan VARCHAR(20) NOT NULL DEFAULT 'Basic',

    CONSTRAINT pk_tenant_settings
        PRIMARY KEY (tenant_id),

    CONSTRAINT fk_settings_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tenants(tenant_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_subscription_plan
        CHECK (subscription_plan IN ('Basic', 'Pro', 'Enterprise'))
);



-- TABLE 5: PROJECTS
-- Stores projects belonging to organisations

CREATE TABLE projects (
    tenant_id INTEGER NOT NULL,
    project_id INTEGER GENERATED ALWAYS AS IDENTITY,
    project_name VARCHAR(150) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'planning',

    CONSTRAINT pk_projects
        PRIMARY KEY (tenant_id, project_id),

    CONSTRAINT fk_projects_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tenants(tenant_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_project_status
        CHECK (status IN ('planning', 'active', 'completed', 'on_hold'))
);



-- TABLE 6: TASKS
-- Stores tasks belonging to projects

CREATE TABLE tasks (
    tenant_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    task_id INTEGER GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(200) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'todo',
    due_date DATE,

    CONSTRAINT pk_tasks
        PRIMARY KEY (tenant_id, project_id, task_id),

    CONSTRAINT fk_tasks_project
        FOREIGN KEY (tenant_id, project_id)
        REFERENCES projects(tenant_id, project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_task_status
        CHECK (status IN ('todo', 'in_progress', 'completed'))
);



-- TABLE 7: PROJECT_MEMBERS
-- Connects organisation members with projects

CREATE TABLE project_members (
    tenant_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_project_members
        PRIMARY KEY (tenant_id, project_id, user_id),

    CONSTRAINT fk_project_members_project
        FOREIGN KEY (tenant_id, project_id)
        REFERENCES projects(tenant_id, project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_members_membership
        FOREIGN KEY (tenant_id, user_id)
        REFERENCES tenant_memberships(tenant_id, user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

