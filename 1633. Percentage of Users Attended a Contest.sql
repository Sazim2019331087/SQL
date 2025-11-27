# Problem statement:
  --------------------
Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
The result format is in the following example.
  
# Table schema:
Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
 

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.

# Input: 
----------
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+

# Output: 
----------
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+

# Solution:
  --------------------------
WITH CTE AS (
    SELECT contest_id 
    , COUNT(user_id)
    AS total_contest
    , (SELECT COUNT(*) FROM users)
    as total_user
    FROM Register
    GROUP BY contest_id
    
)
SELECT contest_id,
ROUND( (total_contest/total_user)*100,2 )
AS percentage
FROM CTE
ORDER BY 
percentage DESC,contest_id;
