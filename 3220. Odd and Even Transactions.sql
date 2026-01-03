# Problem statement:
  --------------------
Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even transactions for a specific date, display as 0.
Return the result table ordered by transaction_date in ascending order.
The result format is in the following example.
  
# Table schema:
  -------------------
Table: transactions

+------------------+------+
| Column Name      | Type | 
+------------------+------+
| transaction_id   | int  |
| amount           | int  |
| transaction_date | date |
+------------------+------+
The transactions_id column uniquely identifies each row in this table.
Each row of this table contains the transaction id, amount and transaction date.

# Input: 
  -----------
transactions table:

+----------------+--------+------------------+
| transaction_id | amount | transaction_date |
+----------------+--------+------------------+
| 1              | 150    | 2024-07-01       |
| 2              | 200    | 2024-07-01       |
| 3              | 75     | 2024-07-01       |
| 4              | 300    | 2024-07-02       |
| 5              | 50     | 2024-07-02       |
| 6              | 120    | 2024-07-03       |
+----------------+--------+------------------+

# Output: 
  --------
+------------------+---------+----------+
| transaction_date | odd_sum | even_sum |
+------------------+---------+----------+
| 2024-07-01       | 75      | 350      |
| 2024-07-02       | 0       | 350      |
| 2024-07-03       | 0       | 120      |
+------------------+---------+----------+

# Solution:
  --------------------------

    SELECT to_char(transaction_date,'yyyy-mm-dd') AS transaction_date ,  
    SUM(CASE WHEN MOD(amount,2)=1 THEN amount ELSE 0 END) AS odd_sum , 
    SUM(CASE WHEN MOD(amount,2)=0 THEN amount ELSE 0 END) AS even_sum
    FROM transactions
    GROUP BY transaction_date 
    ORDER BY transaction_date
