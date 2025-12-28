# Problem statement:
  --------------------
Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:
    The employees name is missing, or
    The employees salary is missing.
Return the result table ordered by employee_id in ascending order.
The result format is in the following example.

# Table schema:
  -----------------
Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 

Table: Salaries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
  
# Input:
  -------------------------
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+

# Output:
  -------------------------
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+

# Solution:
  --------------------------
WITH Emp_Id AS (
    SELECT employee_id FROM Employees
    UNION
    SELECT employee_id FROM Salaries
)
, Missing_Name AS (
    SELECT employee_id FROM Emp_Id
    WHERE employee_id NOT IN (
        SELECT employee_id FROM Employees
    )
)
, Missing_Salary AS (
    SELECT employee_id FROM Emp_Id
    WHERE employee_id NOT IN (
        SELECT employee_id FROM Salaries
    )
)
SELECT employee_id FROM Missing_Name
UNION
SELECT employee_id FROM Missing_Salary
