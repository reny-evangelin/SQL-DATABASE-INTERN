
-- =====================================================
-- RABTECH SQL INTERNSHIP - TASK 4
-- FILE: indexing_scripts.sql
-- PURPOSE: B-TREE, COMPOSITE AND PARTIAL INDEXING
-- DATABASE: taskflow_saas
-- =====================================================

-- INDEX 1: B-TREE INDEX
CREATE INDEX idx_inventory_category
ON task4_inventory_demo USING BTREE (category);


-- INDEX 2: COMPOSITE INDEX
CREATE INDEX idx_inventory_category_warehouse
ON task4_inventory_demo USING BTREE (category, warehouse_id);


-- INDEX 3: PARTIAL INDEX
CREATE INDEX idx_inventory_active_category
ON task4_inventory_demo USING BTREE (category)
WHERE is_active = TRUE;


-- UPDATE TABLE STATISTICS
ANALYZE task4_inventory_demo;


-- VERIFY CREATED INDEXES
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'task4_inventory_demo'
ORDER BY indexname;
