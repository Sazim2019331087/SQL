# Problem statement:
  --------------------
A single number is a number that appeared only once in the MyNumbers table.
Find the largest single number. If there is no single number, report null.
The result format is in the following example.
  
# Table schema:
------------------------
Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
  
# Input:
  -------------------------
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+

# Output:
  -------------------------
+------+
| num  |
+------+
| null |
+------+

# Solution:
  --------------------------
WITH CTE AS (
    SELECT num,COUNT(*) as total
    FROM MyNumbers
    GROUP BY num
    ORDER BY total ASC,num DESC
)
select CASE WHEN total = 1 THEN num ELSE null END as num from cte
LIMIT 1;
