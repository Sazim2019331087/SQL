# Problem statement:
  --------------------
Write a solution to find the employees who earn more than their managers.
Return the result table in any order.
The result format is in the following example.
  
# Table schema:
-----------------
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.

# Input:
  -------------------------
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+

# Output:
  -------------------------
+----------+
| Employee |
+----------+
| Joe      |
+----------+

# Solution:
  --------------------------
WITH CTE AS (
    SELECT E1.id,E1.name,E1.salary AS e_salary
    ,E2.salary AS m_salary
    FROM Employee E1
    LEFT JOIN Employee E2
    ON E2.id = E1.managerId
    ORDER BY E1.id
)
SELECT name AS Employee
FROM CTE 
WHERE e_salary > m_salary
