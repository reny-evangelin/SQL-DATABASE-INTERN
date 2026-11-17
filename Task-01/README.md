
# RabTech SQL Internship - Task 1

## Business Rules to Executable Relational Model

### Project Overview
This project implements a relational database using PostgreSQL.
The database manages customers and their orders.

The project converts business rules derived from the supplied starter
schema into executable SQL constraints and validates them through
negative testing.

### Technologies Used
- PostgreSQL
- pgAdmin 4
- SQL

### Database Tables

**1. Customers**
- customer_id (Primary Key)
- customer_name (NOT NULL)
- city (NOT NULL)
- joined_on (NOT NULL)

**2. Orders**
- order_id (Primary Key)
- customer_id (Foreign Key)
- ordered_on
- order_status
- amount_inr

### Business Rules
1. Every customer must have a unique customer ID.
2. Customer name, city and joining date are mandatory.
3. Every order must belong to an existing customer.
4. Order status must be PLACED, PAID or CANCELLED.
5. Order amount cannot be negative.

Note: These rules are derived from the provided database schema,
as no separate detailed business-rule document was supplied.

### Relationship
One customer can have zero or many orders.
Each order belongs to exactly one customer.

See [ER Diagram](er-diagram.md).

### Project Structure
- migrations/ - Database schema
- fixtures/ - Sample data
- tests/ - Negative test cases
- rule-constraint-matrix.md - Business rules and constraints
- er-diagram.md - Entity relationship diagram

### Testing
Six negative tests were executed successfully:
- Duplicate customer ID rejected
- Missing customer name rejected
- Invalid customer ID rejected
- Invalid order status rejected
- Negative order amount rejected
- Customer deletion restricted when orders exist

### How to Run
1. Create a PostgreSQL database.
2. Execute migrations/001_initial_schema.sql.
3. Execute fixtures/seed_data.sql.
4. Execute tests/negative_tests.sql.

### Conclusion
The project demonstrates relational database design,
integrity constraints, foreign key relationships and
negative testing using PostgreSQL.
