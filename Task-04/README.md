
# Task 4 – Query Index Tuning, Execution Plans & ACID Transactions

## Internship
RabTech SQL Internship

## Database
PostgreSQL – taskflow_saas

## Task Overview
This task focuses on SQL query performance optimization, execution plan analysis, indexing strategies, and ACID transaction management.

## Implementation

### 1. Performance Testing
- Created a simulated inventory table with 100,000 records.
- Used EXPLAIN ANALYZE to inspect query execution plans.
- Identified Sequential Scans before indexing.

### 2. Index Optimization
Implemented and tested:
- B-tree Index
- Composite Index
- Partial Index

### 3. Performance Results

| Measurement | Before | After |
|---|---:|---:|
| Execution Time | 7.061 ms | 0.639 ms |
| Execution Plan | Sequential Scan | Bitmap Index + Heap Scan |

The tested query showed approximately 90.95% lower execution time after composite indexing.

### 4. ACID Transactions
Demonstrated:
- COMMIT
- ROLLBACK
- Row-level locking using SELECT FOR UPDATE
- Insufficient stock protection
- Concurrent inventory updates using two PostgreSQL sessions

## Files Included

| File | Description |
|---|---|
| indexing_scripts.sql | B-tree, composite and partial index creation |
| transaction_scripts.sql | ACID transaction and inventory concurrency examples |
| optimization_report.md | Execution plans, performance comparison and findings |

## Conclusion

Task 4 demonstrates practical database optimization using indexes and execution plans, along with transaction safety and concurrency handling in PostgreSQL.
