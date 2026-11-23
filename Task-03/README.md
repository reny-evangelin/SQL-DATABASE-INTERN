
# Task 3: Advanced SQL Queries, CTEs & Window Functions

## Internship 
RabTech SQL Internship

## Project Overview

This task focuses on writing advanced SQL queries using Common Table Expressions (CTEs), Window Functions, Joins, Subqueries, and Recursive Queries.

The objective is to solve business intelligence and analytical problems using PostgreSQL.

## Database Used

- Database Name: `taskflow_saas`
- Database System: PostgreSQL
- Project Example: TaskFlow Project Management SaaS

## Topics Covered

### 1. Common Table Expressions (CTEs)
- WITH clause
- Multi-step query logic
- Recursive CTEs

### 2. Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- Running totals using SUM() OVER()

### 3. Joins and Subqueries
- INNER JOIN
- LEFT JOIN
- FULL OUTER JOIN
- Subqueries
- Multiple table joins

### 4. Analytical Queries
- Task count per project
- Project ranking based on task counts
- Previous and next task due dates
- Running task totals
- Project member assignments
- Daily task scheduling analysis
- Task completion percentages by tenant

## Files Included

| File Name | Description |
|---|---|
| `queries.sql` | Contains 11 advanced SQL analytical queries. |
| `expected_outputs.md` | Documents the expected results of all 11 queries. |

## Execution Instructions

1. Open pgAdmin 4.
2. Connect to the PostgreSQL server.
3. Select the `taskflow_saas` database.
4. Open Query Tool.
5. Open or paste the contents of `queries.sql`.
6. Execute the queries individually.
7. Compare the results with `expected_outputs.md`.

## Key Learning Outcomes

- Understanding advanced SQL query structures.
- Applying CTEs to simplify complex queries.
- Using recursive CTEs for date-series generation.
- Applying window functions for analytical calculations.
- Understanding ranking and sequencing functions.
- Comparing records using LAG() and LEAD().
- Calculating running totals using window functions.
- Combining multiple tables using different JOIN operations.
- Performing business intelligence analysis using SQL.

## Conclusion

Successfully completed the implementation of 11 advanced SQL analytical queries using PostgreSQL.

This task demonstrates the practical application of advanced SQL concepts for data analysis, reporting, and business intelligence.

---
**Internship:** RabTech SQL Internship  
**Task:** Task 3 – Advanced SQL Queries, CTEs & Window Functions
