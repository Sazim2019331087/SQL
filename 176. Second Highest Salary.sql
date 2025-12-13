# Problem statement:
  --------------------
Write a solution to find the second highest distinct salary from the Employee table.
If there is no second highest salary, return null (return None in Pandas).
The result format is in the following example.
  
# Table schema:
-----------------
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
  
# Input:
  -------------------------
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

# Output:
  -------------------------
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

# Solution:
  --------------------------
SELECT MAX(salary) as "SecondHighestSalary"
FROM Employee
WHERE salary < 
(
    select MAX(salary)
    from employee
)
