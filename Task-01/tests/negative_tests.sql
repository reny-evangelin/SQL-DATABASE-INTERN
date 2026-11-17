
-- RabTech SQL Internship - Task 1
-- Negative tests: invalid data must be rejected

-- TEST 1: Duplicate customer ID
DO $$
BEGIN
    INSERT INTO customers
    VALUES (1, 'Test Customer', 'Chennai', '2026-05-01');

    RAISE EXCEPTION 'FAIL: Duplicate customer ID accepted';
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'PASS: Duplicate customer ID rejected';
END $$;


-- TEST 2: Missing customer name
DO $$
BEGIN
    INSERT INTO customers
    VALUES (9001, NULL, 'Chennai', '2026-05-01');

    RAISE EXCEPTION 'FAIL: Missing customer name accepted';
EXCEPTION
    WHEN not_null_violation THEN
        RAISE NOTICE 'PASS: Missing customer name rejected';
END $$;


-- TEST 3: Invalid customer ID in an order
DO $$
BEGIN
    INSERT INTO orders
    VALUES (9001, 9999, '2026-05-01', 'PLACED', 500.00);

    RAISE EXCEPTION 'FAIL: Invalid customer ID accepted';
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'PASS: Invalid customer ID rejected';
END $$;


-- TEST 4: Invalid order status
DO $$
BEGIN
    INSERT INTO orders
    VALUES (9002, 1, '2026-05-01', 'SHIPPED', 500.00);

    RAISE EXCEPTION 'FAIL: Invalid order status accepted';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'PASS: Invalid order status rejected';
END $$;


-- TEST 5: Negative order amount
DO $$
BEGIN
    INSERT INTO orders
    VALUES (9003, 1, '2026-05-01', 'PLACED', -100.00);

    RAISE EXCEPTION 'FAIL: Negative order amount accepted';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'PASS: Negative order amount rejected';
END $$;


-- TEST 6: Prevent deleting a customer who has orders
DO $$
BEGIN
    DELETE FROM customers WHERE customer_id = 1;

    RAISE EXCEPTION 'FAIL: Customer with orders was deleted';
EXCEPTION
    WHEN SQLSTATE '23001' THEN
        RAISE NOTICE 'PASS: Customer deletion rejected';
END $$;
