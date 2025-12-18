# Problem statement:
  --------------------
Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:
"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.
Return the result table in any order.
The result format is in the following example.
  
# Table schema:
  --------------------
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
  
# Input: 
  --------------------
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+

# Output: 
  --------------------
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+

# Solution:
  --------------------------
WITH CTE AS (
    SELECT account_id , income , 
    CASE
        WHEN    income<20000    THEN    'Low Salary'
        WHEN    income BETWEEN 20000 AND 50000 THEN  'Average Salary'
        WHEN    income>50000    THEN    'High Salary'    
    END as category
    FROM Accounts
)
, CTE2 AS (
    SELECT category , COUNT(*) as accounts_count
    FROM CTE GROUP BY category
)
, CTE3 AS (
    SELECT 'Average Salary' as category, 0 as accounts_count
    FROM DUAL 
    UNION ALL
    SELECT 'Low Salary' , 0 
    FROM DUAL 
    UNION ALL
    SELECT 'High Salary' , 0 
    FROM DUAL
    UNION ALL 
    SELECT * FROM CTE2 
)
SELECT category,SUM(accounts_count) as accounts_count
FROM CTE3 GROUP BY category;

