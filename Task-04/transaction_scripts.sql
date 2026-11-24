
-- =====================================================
-- RABTECH SQL INTERNSHIP - TASK 4
-- FILE: transaction_scripts.sql
-- PURPOSE: ACID TRANSACTIONS AND INVENTORY CONCURRENCY
-- DATABASE: taskflow_saas
-- =====================================================


-- =====================================================
-- TRANSACTION 1: COMMIT
-- Business Rule: Save inventory updates permanently.
-- =====================================================

BEGIN;

UPDATE task4_stock
SET quantity = quantity - 5
WHERE product_id = 1
AND quantity >= 5;

UPDATE task4_stock
SET quantity = quantity + 10
WHERE product_id = 2;

COMMIT;


-- =====================================================
-- TRANSACTION 2: ROLLBACK
-- Business Rule: Cancel uncommitted changes.
-- =====================================================

BEGIN;

UPDATE task4_stock
SET quantity = 25
WHERE product_id = 1;

-- Cancel the temporary update.
ROLLBACK;


-- =====================================================
-- TRANSACTION 3: SAFE INVENTORY DEDUCTION
-- Business Rule: Never allow negative inventory.
-- =====================================================

BEGIN;

UPDATE task4_stock
SET quantity = quantity - 10
WHERE product_id = 1
AND quantity >= 10
RETURNING product_id, product_name, quantity;

COMMIT;


-- =====================================================
-- TRANSACTION 4: INSUFFICIENT STOCK PROTECTION
-- Business Rule: Reject purchases exceeding stock.
-- =====================================================

BEGIN;

UPDATE task4_stock
SET quantity = quantity - 50
WHERE product_id = 1
AND quantity >= 50
RETURNING product_id, product_name, quantity;

-- Cancel or finish the transaction safely.
ROLLBACK;


-- =====================================================
-- TRANSACTION 5: ROW-LEVEL LOCKING
-- Business Rule: Prevent conflicting stock updates.
-- =====================================================

BEGIN;

-- Lock the selected inventory row.
SELECT *
FROM task4_stock
WHERE product_id = 1
FOR UPDATE;

-- Deduct stock only when sufficient quantity exists.
UPDATE task4_stock
SET quantity = quantity - 5
WHERE product_id = 1
AND quantity >= 5
RETURNING product_id, product_name, quantity;

COMMIT;


-- =====================================================
-- TRANSACTION 6: VERIFY INVENTORY
-- =====================================================

SELECT *
FROM task4_stock
ORDER BY product_id;


-- =====================================================
-- CONCURRENCY TEST INSTRUCTIONS
--
-- SESSION A:
-- BEGIN;
-- SELECT * FROM task4_stock
-- WHERE product_id = 1 FOR UPDATE;
--
-- SESSION B:
-- BEGIN;
-- UPDATE task4_stock
-- SET quantity = quantity - 5
-- WHERE product_id = 1 AND quantity >= 5
-- RETURNING *;
--
-- SESSION A:
-- COMMIT;
--
-- SESSION B:
-- The waiting UPDATE continues.
-- COMMIT;
--
-- Verify the final inventory in either session.
-- =====================================================
