# Problem statement:
  --------------------
Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
Return the result table in any order.
  
# Table schema:
  ------Tweets-------
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
content consists of characters on an American Keyboard, and no other special characters.
This table contains all the tweets in a social media app.
  
# Input:
  -------------------------
+----------+-----------------------------------+
| tweet_id | content                           |
+----------+-----------------------------------+
| 1        | Let us Code                       |
| 2        | More than fifteen chars are here! |
+----------+-----------------------------------+

# Output:
  -------------------------
+----------+
| tweet_id |
+----------+
| 2        |
+----------+

# Solution:
  --------------------------
SELECT tweet_id FROM Tweets 
WHERE LENGTH(content)>15;
