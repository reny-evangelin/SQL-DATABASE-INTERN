
erDiagram
    CUSTOMERS ||--o{ ORDERS : places

    CUSTOMERS {
        INTEGER customer_id PK
        VARCHAR customer_name
        VARCHAR city
        DATE joined_on
    }

    ORDERS {
        INTEGER order_id PK
        INTEGER customer_id FK
        DATE ordered_on
        VARCHAR order_status
        NUMERIC amount_inr
    }
