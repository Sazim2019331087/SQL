# Problem statement:
  --------------------
Write a solution to display the records with three or more rows with consecutive ids, and the number of people is greater than or equal to 100 for each.
Return the result table ordered by visit_date in ascending order.
The result format is in the following example.
  
# Table schema:
  --------------
Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
  
# Input:
  -------------------------
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+

# Output:
  -------------------------
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+

# Solution:
  --------------------------
WITH CTE1 AS (
    SELECT id,to_char(visit_date,'yyyy-mm-dd') AS visit_date,
    people ,
    id - ROW_NUMBER() OVER(ORDER BY id) AS grp_id
    FROM Stadium
    WHERE people >= 100
)
, CTE2 AS (
    SELECT grp_id , 
    COUNT(*) AS total
    FROM CTE1
    GROUP BY grp_id
)

    SELECT id,visit_date,people FROM CTE1
    WHERE grp_id IN 
    (
        SELECT grp_id FROM CTE2 WHERE total>=3
    )
    ORDER BY id
