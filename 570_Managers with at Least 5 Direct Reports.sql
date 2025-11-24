# Problem statement:
  --------------------
Write a solution to find managers with at least five direct reports.

Return the result table in any order.

The result format is in the following example.
  
# Table schema:
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
  
# Input:
  -------------------------
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+


# Output:
  -------------------------
+------+
| name |
+------+
| John |
+------+

# Solution:
  --------------------------
WITH CTE AS 
(

    SELECT A.name as staff , B.name as Manager , B.id as Manager_Id
    FROM Employee A JOIN Employee B
    Where A.managerId = B.id
)
SELECT Manager as name 
FROM CTE
GROUP BY Manager_Id
HAVING COUNT(*)>=5
;
