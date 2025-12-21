# Problem statement:
  --------------------
Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
The result format is in the following example.

# Table schema:
  -----------------
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
Each movie has a unique title.
Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the users review date.
  
# Input:
  -------------------------
Movies table:
+-------------+--------------+
| movie_id    |  title       |
+-------------+--------------+
| 1           | Avengers     |
| 2           | Frozen 2     |
| 3           | Joker        |
+-------------+--------------+
Users table:
+-------------+--------------+
| user_id     |  name        |
+-------------+--------------+
| 1           | Daniel       |
| 2           | Monica       |
| 3           | Maria        |
| 4           | James        |
+-------------+--------------+
MovieRating table:
+-------------+--------------+--------------+-------------+
| movie_id    | user_id      | rating       | created_at  |
+-------------+--------------+--------------+-------------+
| 1           | 1            | 3            | 2020-01-12  |
| 1           | 2            | 4            | 2020-02-11  |
| 1           | 3            | 2            | 2020-02-12  |
| 1           | 4            | 1            | 2020-01-01  |
| 2           | 1            | 5            | 2020-02-17  | 
| 2           | 2            | 2            | 2020-02-01  | 
| 2           | 3            | 2            | 2020-03-01  |
| 3           | 1            | 3            | 2020-02-22  | 
| 3           | 2            | 4            | 2020-02-25  | 
+-------------+--------------+--------------+-------------+

# Output:
  -------------------------
+--------------+
| results      |
+--------------+
| Daniel       |
| Frozen 2     |
+--------------+

# Solution:
  --------------------------
WITH Max_Rating AS (
    SELECT user_id,COUNT(movie_id) as total_count
    FROM MovieRating
    GROUP BY user_id
)
, USER_RATING AS (
    SELECT U.name , Max_Rating.total_count
    FROM Users U
    JOIN Max_Rating
    ON U.user_id = Max_Rating.user_id
    ORDER BY total_count DESC,U.name ASC
)
, FEB_MOVIE AS (    
    SELECT movie_id,rating,created_at
    FROM MovieRating
    WHERE EXTRACT(MONTH FROM created_at)=2
    AND EXTRACT(YEAR FROM created_at)=2020 
)
, AVG_RATING AS (
    SELECT movie_id , AVG(rating) AS average_rating
    FROM FEB_MOVIE
    GROUP BY movie_id
)
, MOVIE AS (
    SELECT movie_id FROM AVG_RATING
    WHERE average_rating = (
        SELECT MAX(average_rating)
        FROM AVG_RATING )
)
, MOVIE_NAME as (
    SELECT M.title
    FROM Movies M
    JOIN Movie MR
    ON M.movie_id = MR.movie_id
    ORDER BY M.title
)

SELECT name as results FROM USER_RATING WHERE ROWNUM = 1
UNION ALL
SELECT title as results FROM MOVIE_NAME WHERE ROWNUM = 1
