# Problem statement:
  --------------------
The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.

The result format is in the following example.
  
# Table schema:
Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
  
Input: 
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+
Output: 
+---------+-------------------+
| user_id | confirmation_rate |
+---------+-------------------+
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |
+---------+-------------------+

# Solution:
  --------------------------
WITH TOTAL AS (
    SELECT S.user_id AS id, C.action, COUNT(C.action) AS total_action
    FROM Signups S LEFT JOIN Confirmations C
    ON S.user_id = C.user_id 
    GROUP BY S.user_id
),
SUCCESS AS 
(
    SELECT S.user_id as id, C.action, COUNT(C.Action) AS total_confirmed
    FROM Signups S JOIN Confirmations C
    ON S.user_id = C.user_id 
    GROUP BY S.user_id,C.Action
    HAVING C.Action = "confirmed"
),
CTE AS (
SELECT T1.id AS id,T1.total_action AS requests,T2.total_confirmed,COALESCE(T2.total_confirmed,0) AS successful
from 
TOTAL T1
LEFT JOIN
SUCCESS T2
ON T1.id = T2.id
)

SELECT id as user_id,
CASE
WHEN requests = 0 or successful = 0 THEN 0
ELSE ROUND(successful/requests,2)
END AS confirmation_rate
FROM CTE
;
