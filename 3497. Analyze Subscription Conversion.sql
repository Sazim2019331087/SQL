# Problem statement:
  --------------------
A subscription service wants to analyze user behavior patterns. The company offers a 7-day free trial, after which users can subscribe to a paid plan or cancel. Write a solution to:
    Find users who converted from free trial to paid subscription
    Calculate each users average daily activity duration during their free trial period (rounded to 2 decimal places)
    Calculate each users average daily activity duration during their paid subscription period (rounded to 2 decimal places)
Return the result table ordered by user_id in ascending order.

The result format is in the following example.
  
# Table schema:
  -----------------
Table: UserActivity

+------------------+---------+
| Column Name      | Type    | 
+------------------+---------+
| user_id          | int     |
| activity_date    | date    |
| activity_type    | varchar |
| activity_duration| int     |
+------------------+---------+
(user_id, activity_date, activity_type) is the unique key for this table.
activity_type is one of ('free_trial', 'paid', 'cancelled').
activity_duration is the number of minutes the user spent on the platform that day.
Each row represents a users activity on a specific date.
  
# Input:
  -------------------------
UserActivity table:

+---------+---------------+---------------+-------------------+
| user_id | activity_date | activity_type | activity_duration |
+---------+---------------+---------------+-------------------+
| 1       | 2023-01-01    | free_trial    | 45                |
| 1       | 2023-01-02    | free_trial    | 30                |
| 1       | 2023-01-05    | free_trial    | 60                |
| 1       | 2023-01-10    | paid          | 75                |
| 1       | 2023-01-12    | paid          | 90                |
| 1       | 2023-01-15    | paid          | 65                |
| 2       | 2023-02-01    | free_trial    | 55                |
| 2       | 2023-02-03    | free_trial    | 25                |
| 2       | 2023-02-07    | free_trial    | 50                |
| 2       | 2023-02-10    | cancelled     | 0                 |
| 3       | 2023-03-05    | free_trial    | 70                |
| 3       | 2023-03-06    | free_trial    | 60                |
| 3       | 2023-03-08    | free_trial    | 80                |
| 3       | 2023-03-12    | paid          | 50                |
| 3       | 2023-03-15    | paid          | 55                |
| 3       | 2023-03-20    | paid          | 85                |
| 4       | 2023-04-01    | free_trial    | 40                |
| 4       | 2023-04-03    | free_trial    | 35                |
| 4       | 2023-04-05    | paid          | 45                |
| 4       | 2023-04-07    | cancelled     | 0                 |
+---------+---------------+---------------+-------------------+

# Output:
  -------------------------
+---------+--------------------+-------------------+
| user_id | trial_avg_duration | paid_avg_duration |
+---------+--------------------+-------------------+
| 1       | 45.00              | 76.67             |
| 3       | 70.00              | 63.33             |
| 4       | 37.50              | 45.00             |
+---------+--------------------+-------------------+

# Solution:
  --------------------------
WITH SUMMING AS (
    SELECT user_id,
        SUM(CASE WHEN activity_type='free_trial' THEN activity_duration ELSE 0 END) AS total_free_duration ,
        SUM(CASE WHEN activity_type='paid' THEN activity_duration ELSE 0 END) AS total_paid_duration ,
        SUM(CASE WHEN activity_type='cancelled' THEN activity_duration ELSE 0 END) AS total_cancelled_duration 
    FROM UserActivity
    GROUP BY user_id
    ORDER BY user_id
)
, COUNTING AS (
        SELECT user_id,
        SUM(CASE WHEN activity_type='free_trial' THEN 1 ELSE 0 END) AS count_free_duration ,
        SUM(CASE WHEN activity_type='paid' THEN 1 ELSE 0 END) AS count_paid_duration ,
        SUM(CASE WHEN activity_type='cancelled' THEN 1 ELSE 0 END) AS count_cancelled_duration 
    FROM UserActivity
    GROUP BY user_id
    ORDER BY user_id
)

    SELECT
          S.user_id
        , CASE
            WHEN C.count_free_duration>0 THEN ROUND(S.total_free_duration/C.count_free_duration,2) 
            ELSE 0 
          END AS trial_avg_duration
        , CASE
            WHEN C.count_paid_duration>0 THEN ROUND(S.total_paid_duration/C.count_paid_duration,2) 
            ELSE 0 
          END AS paid_avg_duration

    FROM SUMMING S
    JOIN COUNTING C
    ON S.user_id = C.user_id
    WHERE S.user_id IN (
        SELECT user_id FROM UserActivity WHERE activity_type = 'paid'
    )
