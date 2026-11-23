
-- ==================================================
-- TASK 3: ADVANCED SQL QUERIES
-- QUERY 1: Task Count Per Project
-- BUSINESS QUESTION:
-- How many tasks belong to each project,
-- and which tenant owns each project?
-- ==================================================

WITH project_task_counts AS (
    SELECT
        p.tenant_id,
        p.project_id,
        p.project_name,
        t.tenant_name,
        COUNT(ts.task_id) AS total_tasks

    FROM projects p

    INNER JOIN tenants t
        ON p.tenant_id = t.tenant_id

    LEFT JOIN tasks ts
        ON p.tenant_id = ts.tenant_id
        AND p.project_id = ts.project_id

    GROUP BY
        p.tenant_id,
        p.project_id,
        p.project_name,
        t.tenant_name
)

SELECT *
FROM project_task_counts
ORDER BY tenant_name, project_name;



-- ==================================================
-- QUERY 2: ROW_NUMBER()
-- BUSINESS QUESTION:
-- How can we number tasks within each project
-- according to their due dates?
-- ==================================================

SELECT
    tenant_id,
    project_id,
    task_id,
    title,
    status,
    due_date,

    ROW_NUMBER() OVER (
        PARTITION BY tenant_id, project_id
        ORDER BY due_date
    ) AS task_number

FROM tasks

ORDER BY tenant_id, project_id, task_number;



-- ==================================================
-- QUERY 3: RANK()
-- BUSINESS QUESTION:
-- Which projects have the highest number of tasks?
-- ==================================================

WITH project_task_counts AS (
    SELECT
        p.tenant_id,
        p.project_id,
        p.project_name,
        COUNT(t.task_id) AS total_tasks

    FROM projects p

    LEFT JOIN tasks t
        ON p.tenant_id = t.tenant_id
        AND p.project_id = t.project_id

    GROUP BY
        p.tenant_id,
        p.project_id,
        p.project_name
)

SELECT
    project_name,
    total_tasks,

    RANK() OVER (
        ORDER BY total_tasks DESC
    ) AS project_rank

FROM project_task_counts

ORDER BY project_rank, project_name;



-- ==================================================
-- QUERY 4: DENSE_RANK()
-- BUSINESS QUESTION:
-- How do projects rank by task count without
-- skipping rank numbers when there are ties?
-- ==================================================

WITH project_task_counts AS (
    SELECT
        p.tenant_id,
        p.project_id,
        p.project_name,
        COUNT(t.task_id) AS total_tasks

    FROM projects p

    LEFT JOIN tasks t
        ON p.tenant_id = t.tenant_id
        AND p.project_id = t.project_id

    GROUP BY
        p.tenant_id,
        p.project_id,
        p.project_name
)

SELECT
    project_name,
    total_tasks,

    DENSE_RANK() OVER (
        ORDER BY total_tasks DESC
    ) AS dense_project_rank

FROM project_task_counts

ORDER BY dense_project_rank, project_name;


-- ==================================================
-- QUERY 5: LAG()
-- BUSINESS QUESTION:
-- What was the due date of the previous task
-- within the same project?
-- ==================================================

SELECT
    tenant_id,
    project_id,
    task_id,
    title,
    due_date,

    LAG(due_date) OVER (
        PARTITION BY tenant_id, project_id
        ORDER BY due_date
    ) AS previous_task_due_date

FROM tasks

ORDER BY tenant_id, project_id, due_date;


-- ==================================================
-- QUERY 6: LEAD()
-- BUSINESS QUESTION:
-- What is the due date of the next task
-- within the same project?
-- ==================================================

SELECT
    tenant_id,
    project_id,
    task_id,
    title,
    due_date,

    LEAD(due_date) OVER (
        PARTITION BY tenant_id, project_id
        ORDER BY due_date
    ) AS next_task_due_date

FROM tasks

ORDER BY tenant_id, project_id, due_date;


-- ==================================================
-- QUERY 7: RUNNING TOTAL
-- BUSINESS QUESTION:
-- How does the cumulative number of tasks
-- increase across projects?
-- ==================================================

WITH project_task_counts AS (
    SELECT
        p.tenant_id,
        p.project_id,
        p.project_name,
        COUNT(t.task_id) AS total_tasks

    FROM projects p

    LEFT JOIN tasks t
        ON p.tenant_id = t.tenant_id
        AND p.project_id = t.project_id

    GROUP BY
        p.tenant_id,
        p.project_id,
        p.project_name
)

SELECT
    tenant_id,
    project_name,
    total_tasks,

    SUM(total_tasks) OVER (
        PARTITION BY tenant_id
        ORDER BY project_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_total

FROM project_task_counts

ORDER BY tenant_id, project_id;



-- ==================================================
-- QUERY 8: LEFT JOIN WITH SUBQUERY
-- BUSINESS QUESTION:
-- How many projects has each user been assigned
-- to within each tenant?
-- ==================================================

SELECT
    u.user_id,
    u.full_name,
    tm.tenant_id,
    tm.role,
    COALESCE(pa.total_projects, 0) AS total_projects

FROM tenant_memberships tm

INNER JOIN users u
    ON tm.user_id = u.user_id

LEFT JOIN (
    SELECT
        tenant_id,
        user_id,
        COUNT(project_id) AS total_projects

    FROM project_members

    GROUP BY tenant_id, user_id
) pa
    ON tm.tenant_id = pa.tenant_id
    AND tm.user_id = pa.user_id

ORDER BY tm.tenant_id, u.user_id;



-- ==================================================
-- QUERY 9: FULL OUTER JOIN WITH CTEs
-- BUSINESS QUESTION:
-- How many tasks and project-member assignments
-- does each project have?
-- ==================================================

WITH task_summary AS (
    SELECT
        tenant_id,
        project_id,
        COUNT(task_id) AS total_tasks
    FROM tasks
    GROUP BY tenant_id, project_id
),

member_summary AS (
    SELECT
        tenant_id,
        project_id,
        COUNT(user_id) AS total_members
    FROM project_members
    GROUP BY tenant_id, project_id
)

SELECT
    COALESCE(ts.tenant_id, ms.tenant_id) AS tenant_id,
    COALESCE(ts.project_id, ms.project_id) AS project_id,
    COALESCE(ts.total_tasks, 0) AS total_tasks,
    COALESCE(ms.total_members, 0) AS total_members

FROM task_summary ts

FULL OUTER JOIN member_summary ms
    ON ts.tenant_id = ms.tenant_id
    AND ts.project_id = ms.project_id

ORDER BY tenant_id, project_id;


-- ==================================================
-- QUERY 10: RECURSIVE CTE
-- BUSINESS QUESTION:
-- How many tasks are scheduled each day,
-- including days with no scheduled tasks?
-- ==================================================

WITH RECURSIVE date_bounds AS (
    SELECT
        MIN(due_date) AS start_date,
        MAX(due_date) AS end_date
    FROM tasks
),

date_series (schedule_date, end_date) AS (
    SELECT
        start_date,
        end_date
    FROM date_bounds
    WHERE start_date IS NOT NULL

    UNION ALL

    SELECT
        schedule_date + 1,
        end_date
    FROM date_series
    WHERE schedule_date < end_date
)

SELECT
    ds.schedule_date,
    COUNT(t.task_id) AS total_tasks

FROM date_series ds

LEFT JOIN tasks t
    ON t.due_date = ds.schedule_date

GROUP BY ds.schedule_date

ORDER BY ds.schedule_date;


-- ==================================================
-- QUERY 11: CONDITIONAL AGGREGATION
-- BUSINESS QUESTION:
-- How many tasks are completed, in progress,
-- and pending in each tenant?
-- What percentage of tasks are completed?
-- ==================================================

SELECT
    tn.tenant_id,
    tn.tenant_name,

    COUNT(t.task_id) AS total_tasks,

    COUNT(CASE
        WHEN t.status = 'completed' THEN 1
    END) AS completed_tasks,

    COUNT(CASE
        WHEN t.status = 'in_progress' THEN 1
    END) AS in_progress_tasks,

    COUNT(CASE
        WHEN t.status = 'todo' THEN 1
    END) AS pending_tasks,

    COALESCE(
        ROUND(
            100.0 * COUNT(CASE
                WHEN t.status = 'completed' THEN 1
            END)
            / NULLIF(COUNT(t.task_id), 0),
            2
        ),
        0
    ) AS completion_percentage

FROM tenants tn

LEFT JOIN tasks t
    ON tn.tenant_id = t.tenant_id

GROUP BY
    tn.tenant_id,
    tn.tenant_name

ORDER BY tn.tenant_id;
