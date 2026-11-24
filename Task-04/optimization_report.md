# Task 4: Query Index Tuning, Execution Plans & ACID Transactions

## 1. Objective

The objective of this task is to improve SQL query performance using indexes, analyze query execution plans with `EXPLAIN ANALYZE`, and demonstrate safe ACID transactions for inventory management.

**Database:** `taskflow_saas`  
**Performance demo table:** `task4_inventory_demo`  
**Total simulated records:** 100,000

---

## 2. Dataset Preparation

A demonstration inventory table was created with 100,000 simulated product records.

The table contains:

- `item_id` – Unique product identifier
- `product_name` – Product name
- `category` – Product category
- `warehouse_id` – Warehouse identifier
- `quantity` – Available quantity
- `unit_price` – Product price
- `is_active` – Product availability status
- `last_updated` – Last update timestamp

The table was analyzed using:

```sql
ANALYZE task4_inventory_demo;
```

---

## 3. Baseline Query: Before Indexing

The following query retrieves electronics products stored in warehouse 25.

```sql
EXPLAIN ANALYZE
SELECT *
FROM task4_inventory_demo
WHERE category = 'Electronics'
AND warehouse_id = 25;
```

### Execution plan before indexing

```text
Seq Scan on task4_inventory_demo
(cost=0.00..2499.00 rows=95 width=48)
(actual time=0.059..7.023 rows=100.00 loops=1)

Filter:
(category = 'Electronics' AND warehouse_id = 25)

Rows Removed by Filter: 99900

Planning Time: 2.124 ms
Execution Time: 7.061 ms
```

### Observation

- PostgreSQL performed a Sequential Scan.
- It examined the table and filtered out 99,900 records.
- Only 100 records matched the conditions.
- Execution time was 7.061 ms.

This showed an opportunity to optimize the query using indexes.

---

## 4. Index Creation

Three indexes were created.

### A. B-tree Index

```sql
CREATE INDEX idx_inventory_category
ON task4_inventory_demo USING BTREE (category);
```

Purpose: Improve searches that filter products by category.

### B. Composite Index

```sql
CREATE INDEX idx_inventory_category_warehouse
ON task4_inventory_demo USING BTREE (category, warehouse_id);
```

Purpose: Improve queries that filter using both category and warehouse ID.

### C. Partial Index

```sql
CREATE INDEX idx_inventory_active_category
ON task4_inventory_demo USING BTREE (category)
WHERE is_active = TRUE;
```

Purpose: Optimize searches for active products by category while indexing only rows where `is_active` is TRUE.

Finally, the table statistics were updated:

```sql
ANALYZE task4_inventory_demo;
```

---

## 5. Performance Comparison: After Composite Indexing

The original query was executed again.

```sql
EXPLAIN ANALYZE
SELECT *
FROM task4_inventory_demo
WHERE category = 'Electronics'
AND warehouse_id = 25;
```

### Execution plan after indexing

```text
Bitmap Heap Scan on task4_inventory_demo
(actual time=0.293..0.394 rows=100.00 loops=1)

  -> Bitmap Index Scan
     on idx_inventory_category_warehouse
     (actual time=0.256..0.257 rows=100.00 loops=1)

Planning Time: 6.491 ms
Execution Time: 0.639 ms
```

### Observation

- PostgreSQL used the composite index.
- A Bitmap Index Scan located matching records.
- A Bitmap Heap Scan retrieved the corresponding table rows.
- The query returned the same 100 records.
- Execution time decreased to 0.639 ms.

### Before vs After

| Metric | Before | After |
|---|---:|---:|
| Execution plan | Sequential Scan | Bitmap Index + Heap Scan |
| Records returned | 100 | 100 |
| Execution time | 7.061 ms | 0.639 ms |
| Rows removed by filter | 99,900 | Not applicable in the same way |

**Measured execution-time reduction: approximately 90.95%.**

The query ran approximately 11.05 times faster in this test.

---

## 6. B-tree Index Verification

The standalone B-tree index was tested with:

```sql
EXPLAIN ANALYZE
SELECT *
FROM task4_inventory_demo
WHERE category = 'Electronics';
```

### Observed execution plan

```text
Bitmap