# Problem statement:
  --------------------
Find all numbers that appear at least three times consecutively.
Return the result table in any order.
The result format is in the following example.
  
# Table schema:
-----------------
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
  
# Input:
  -------------------------
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+

# Output:
  -------------------------
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

# Solution:
  --------------------------
select distinct num as "ConsecutiveNums" from (
    select id,num,
    lag(num,1) over (order by id) as "prev_val",
    lead(num,1) over (order by id) as "post_val"
    from logs
) as c 
where num = c.prev_val and num = c.post_val;
