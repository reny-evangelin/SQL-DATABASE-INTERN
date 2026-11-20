
-- ==================================================
-- TASK 2: TASKFLOW MULTI-TENANT SAAS
-- FILE: seed_data.sql
-- PURPOSE: Insert realistic sample data
-- ==================================================


-- STEP 1: INSERT ORGANISATIONS

INSERT INTO tenants (tenant_name)
VALUES
    ('ABC Technologies'),
    ('FutureTech Solutions');


-- STEP 2: INSERT USERS

INSERT INTO users (full_name, email)
VALUES
    ('Ananya Sharma', 'ananya@gmail.com'),
    ('Rahul Kumar', 'rahul@gmail.com'),
    ('Priya Nair', 'priya@gmail.com');


-- STEP 3: INSERT TENANT MEMBERSHIPS

INSERT INTO tenant_memberships
    (tenant_id, user_id, role)
VALUES
    (1, 1, 'owner'),
    (1, 2, 'member'),
    (2, 1, 'admin'),
    (2, 3, 'member');


-- STEP 4: INSERT TENANT SETTINGS

INSERT INTO tenant_settings
    (tenant_id, timezone, subscription_plan)
VALUES
    (1, 'Asia/Kolkata', 'Pro'),
    (2, 'Asia/Dubai', 'Basic');


-- STEP 5: INSERT PROJECTS

INSERT INTO projects
    (tenant_id, project_name, status)
VALUES
    (1, 'Website Development', 'active'),
    (1, 'Mobile Application', 'planning'),
    (2, 'E-Commerce Platform', 'active');


-- STEP 6: INSERT TASKS

INSERT INTO tasks
    (tenant_id, project_id, title, status, due_date)
VALUES
    (1, 1, 'Design Homepage', 'completed', '2026-12-01'),
    (1, 1, 'Develop Login Page', 'in_progress', '2026-12-05'),
    (1, 2, 'Create App Wireframes', 'todo', '2026-12-10'),
    (2, 3, 'Build Product Catalogue', 'in_progress', '2026-12-15');


-- STEP 7: INSERT PROJECT MEMBERS

INSERT INTO project_members
    (tenant_id, project_id, user_id)
VALUES
    (1, 1, 1),
    (1, 1, 2),
    (1, 2, 1),
    (2, 3, 1),
    (2, 3, 3);


-- ==================================================
-- SEED DATA INSERTION COMPLETED
-- ==================================================
