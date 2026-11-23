
# Task 3: Advanced SQL Queries, CTEs & Window Functions

## Expected Outputs

Database: `taskflow_saas`

The following outputs represent the expected results from the 11 analytical SQL queries in `queries.sql`.

---

## Query 1: Task Count Per Project

**Business Question:** How many tasks are assigned to each project?

| Tenant | Project | Total Tasks |
|---|---|---:|
| ABC Technologies | Mobile Application | 1 |
| ABC Technologies | Website Development | 2 |
| FutureTech Solutions | E-Commerce Platform | 1 |

## Query 2: ROW_NUMBER()

**Business Question:** What is the sequence number of each task within its project?

| Project | Task | Row Number |
|---|---|---:|
| Website Development | Design Homepage | 1 |
| Website Development | Develop Login Page | 2 |
| Mobile Application | Create App Wireframes | 1 |
| E-Commerce Platform | Build Product Catalogue | 1 |

## Query 3: RANK()

**Business Question:** How do projects rank based on their total task counts?

| Project | Total Tasks | Rank |
|---|---:|---:|
| Website Development | 2 | 1 |
| E-Commerce Platform | 1 | 2 |
| Mobile Application | 1 | 2 |

## Query 4: DENSE_RANK()

**Business Question:** How can projects be ranked without gaps between ranking positions?

| Project | Total Tasks | Dense Rank |
|---|---:|---:|
| Website Development | 2 | 1 |
| E-Commerce Platform | 1 | 2 |
| Mobile Application | 1 | 2 |

## Query 5: LAG()

**Business Question:** What was the due date of the previous task in each project?

| Project | Task | Due Date | Previous Due Date |
|---|---|---|---|
| Website Development | Design Homepage | 2026-12-01 | NULL |
| Website Development | Develop Login Page | 2026-12-05 | 2026-12-01 |
| Mobile Application | Create App Wireframes | 2026-12-10 | NULL |
| E-Commerce Platform | Build Product Catalogue | 2026-12-15 | NULL |

## Query 6: LEAD()

**Business Question:** What is the due date of the next task in each project?

| Project | Task | Due Date | Next Due Date |
|---|---|---|---|
| Website Development | Design Homepage | 2026-12-01 | 2026-12-05 |
| Website Development | Develop Login Page | 2026-12-05 | NULL |
| Mobile Application | Create App Wireframes | 2026-12-10 | NULL |
| E-Commerce Platform | Build Product Catalogue | 2026-12-15 | NULL |

## Query 7: Running Total

**Business Question:** What is the cumulative number of tasks across projects within each tenant?

| Tenant ID | Project | Total Tasks | Running Total |
|---|---|---:|---:|
| 1 | Website Development | 2 | 2 |
| 1 | Mobile Application | 1 | 3 |
| 2 | E-Commerce Platform | 1 | 1 |

## Query 8: LEFT JOIN with Subquery

**Business Question:** How many projects is each tenant member assigned to?

| User | Tenant Role | Assigned Projects |
|---|---|---:|
| Ananya Sharma | owner | 2 |
| Rahul Kumar | member | 1 |
| Ananya Sharma | admin | 1 |
| Priya Nair | member | 1 |

## Query 9: FULL OUTER JOIN

**Business Question:** How many tasks and project members exist in each project?

| Tenant ID | Project ID | Total Tasks | Total Members |
|---|---:|---:|---:|
| 1 | 1 | 2 | 2 |
| 1 | 2 | 1 | 1 |
| 2 | 3 | 1 | 2 |

## Query 10: Recursive CTE

**Business Question:** How many tasks are scheduled for each date in the task due-date range?

| Date | Task Count |
|---|---:|
| 2026-12-01 | 1 |
| 2026-12-02 | 0 |
| 2026-12-03 | 0 |
| 2026-12-04 | 0 |
| 2026-12-05 | 1 |
| 2026-12-06 | 0 |
| 2026-12-07 | 0 |
| 2026-12-08 | 0 |
| 2026-12-09 | 0 |
| 2026-12-10 | 1 |
| 2026-12-11 | 0 |
| 2026-12-12 | 0 |
| 2026-12-13 | 0 |
| 2026-12-14 | 0 |
| 2026-12-15 | 1 |

## Query 11: Conditional Aggregation

**Business Question:** What is the task completion status and completion percentage for each tenant?

| Tenant ID | Tenant Name | Total Tasks | Completed | In Progress | Pending | Completion % |
|---:|---|---:|---:|---:|---:|---:|
| 1 | ABC Technologies | 3 | 1 | 1 | 1 | 33.33 |
| 2 | FutureTech Solutions | 1 | 0 | 1 | 0 | 0.00 |

---

## Conclusion

Successfully implemented 11 advanced SQL analytical queries using:

- Common Table Expressions (CTEs)
- Recursive CTEs
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- Running totals with window functions
- INNER JOIN
- LEFT JOIN
- FULL OUTER JOIN
- Subqueries
- Conditional aggregation

These queries demonstrate advanced SQL techniques for business intelligence and analytical reporting.
