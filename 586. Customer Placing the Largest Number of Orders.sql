# Problem statement:
  --------------------
Write a solution to find the customer_number for the customer who has placed the largest number of orders.
The test cases are generated so that exactly one customer will have placed more orders than any other customer.
The result format is in the following example.

# Table schema:
  -----------------
Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
  
# Input:
  -------------------------
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+

# Output:
  -------------------------
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+

# Solution:
  --------------------------
WITH CTE1 AS (
    SELECT customer_number,COUNT(*) as total_order
    FROM Orders
    GROUP BY customer_number
)
, CTE2 AS (
    SELECT Max(total_order) as max_order 
    FROM CTE1 
)
SELECT customer_number
FROM CTE1
WHERE total_order = (
    SELECT max_order FROM CTE2
)
