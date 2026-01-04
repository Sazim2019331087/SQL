# Problem statement:
  --------------------
Write a solution to find the students who have shown improvement. A student is considered to have shown improvement if they meet both of these conditions:
    Have taken exams in the same subject on at least two different dates
    Their latest score in that subject is higher than their first score
Return the result table ordered by student_id, subject in ascending order.

The result format is in the following example.
  
# Table schema:
  -------------------
Table: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student_id  | int     |
| subject     | varchar |
| score       | int     |
| exam_date   | varchar |
+-------------+---------+
(student_id, subject, exam_date) is the primary key for this table.
Each row contains information about a students score in a specific subject on a particular exam date. score is between 0 and 100 (inclusive).
  
# Input:
  -------------------------
Scores table:

+------------+----------+-------+------------+
| student_id | subject  | score | exam_date  |
+------------+----------+-------+------------+
| 101        | Math     | 70    | 2023-01-15 |
| 101        | Math     | 85    | 2023-02-15 |
| 101        | Physics  | 65    | 2023-01-15 |
| 101        | Physics  | 60    | 2023-02-15 |
| 102        | Math     | 80    | 2023-01-15 |
| 102        | Math     | 85    | 2023-02-15 |
| 103        | Math     | 90    | 2023-01-15 |
| 104        | Physics  | 75    | 2023-01-15 |
| 104        | Physics  | 85    | 2023-02-15 |
+------------+----------+-------+------------+

# Output:
  -------------------------
+------------+----------+-------------+--------------+
| student_id | subject  | first_score | latest_score |
+------------+----------+-------------+--------------+
| 101        | Math     | 70          | 85           |
| 102        | Math     | 80          | 85           |
| 104        | Physics  | 75          | 85           |
+------------+----------+-------------+--------------+

# Solution:
  --------------------------
WITH CTE1 AS (
    SELECT student_id,subject,score,exam_date,
    ROW_NUMBER() OVER (PARTITION BY student_id,subject ORDER BY exam_date ASC) as score_1 
    FROM Scores
)
, CTE2 AS (
    SELECT student_id,subject,score,exam_date,
    ROW_NUMBER() OVER (PARTITION BY student_id,subject ORDER BY exam_date DESC) as score_2
    FROM Scores
)

    SELECT 
          C1.student_id
        , C1.subject
        , C1.score AS first_score
        , C2.score AS latest_score
    FROM CTE1  C1
    JOIN CTE2  C2
    ON C1.student_id = C2.student_id
    AND C1.subject = C2.subject

    WHERE C1.score < C2.score
    AND C1.exam_date < C2.exam_date
    AND C1.score_1 = 1 AND C2.score_2 = 1
