
# Business Rules and Constraint Matrix

## Project
RabTech SQL Internship – Task 1

## Note
The provided starter SQL contains a Customer–Order database.
The following business rules are derived from the supplied schema.
They are assumptions based on the available requirements, not separately
provided business rules from RabTech.

| Rule ID | Business Rule | Database Constraint | Table |
|---|---|---|---|
| BR-01 | Every customer must have a unique customer ID. | PRIMARY KEY | customers |
| BR-02 | Customer name, city and joining date are mandatory. | NOT NULL | customers |
| BR-03 | Every order must belong to an existing customer. | FOREIGN KEY | orders |
| BR-04 | Order status must be PLACED, PAID or CANCELLED. | CHECK | orders |
| BR-05 | Order amount cannot be negative. | CHECK | orders |

## Additional Constraints

- Every order has a unique order ID (PRIMARY KEY).
- A customer can have zero or many orders.
- Each order belongs to exactly one customer.
- A customer with existing orders cannot be deleted because the foreign key
  uses ON DELETE RESTRICT.
- Order amounts are stored using NUMERIC(10,2).

## Assumptions and Limitations

- No customer retention period was specified.
- No rules for changing order statuses were provided.
- The rules above are derived from the supplied database schema.
