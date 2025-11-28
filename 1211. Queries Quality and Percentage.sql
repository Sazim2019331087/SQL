# Problem statement:
  --------------------
We define query quality as:
The average of the ratio between query rating and its position.
We also define poor query percentage as:
The percentage of all queries with rating less than 3.
Write a solution to find each query_name, the quality and poor_query_percentage. 
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order.
The result format is in the following example.
  
# Table schema:
Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.

# Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
# Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+

# Solution:
  --------------------------
WITH Q AS(
    SELECT query_name
    , ROUND(AVG(rating/position),2) AS quality
    FROM Queries
    GROUP BY query_name
), P AS (
    SELECT query_name
    , SUM(rating<3) AS total_poor
    FROM Queries
    GROUP BY query_name
), S AS (
    SELECT query_name
    , COUNT(*) AS total_row
    FROM Queries
    GROUP BY query_name
), CTE1 AS(
    SELECT Q.query_name as query_name
    , Q.quality as quality
    , COALESCE(P.total_poor,0) as total_poor
    FROM Q LEFT JOIN P
    ON Q.query_name = P.query_name
)
SELECT C.query_name
, C.quality
, ROUND((C.total_poor/S.total_row)*100,2)
AS poor_query_percentage
FROM CTE1 AS C
JOIN S ON C.query_name = S.query_name;
