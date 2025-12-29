# Problem statement:
  --------------------
Write a solution to report the Capital gain/loss for each stock.
The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
Return the result table in any order.
The result format is in the following example.
  
# Table schema:
-----------------
Table: Stocks

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| stock_name    | varchar |
| operation     | enum    |
| operation_day | int     |
| price         | int     |
+---------------+---------+
(stock_name, operation_day) is the primary key (combination of columns with unique values) for this table.
The operation column is an ENUM (category) of type ('Sell', 'Buy')
Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
  
# Input:
  -------------------------
Stocks table:
+---------------+-----------+---------------+--------+
| stock_name    | operation | operation_day | price  |
+---------------+-----------+---------------+--------+
| Leetcode      | Buy       | 1             | 1000   |
| Corona Masks  | Buy       | 2             | 10     |
| Leetcode      | Sell      | 5             | 9000   |
| Handbags      | Buy       | 17            | 30000  |
| Corona Masks  | Sell      | 3             | 1010   |
| Corona Masks  | Buy       | 4             | 1000   |
| Corona Masks  | Sell      | 5             | 500    |
| Corona Masks  | Buy       | 6             | 1000   |
| Handbags      | Sell      | 29            | 7000   |
| Corona Masks  | Sell      | 10            | 10000  |
+---------------+-----------+---------------+--------+

# Output:
  -------------------------
+---------------+-------------------+
| stock_name    | capital_gain_loss |
+---------------+-------------------+
| Corona Masks  | 9500              |
| Leetcode      | 8000              |
| Handbags      | -23000            |
+---------------+-------------------+

# Solution:
  --------------------------
WITH total_stocks AS (
    SELECT DISTINCT stock_name
    FROM Stocks 
)
, Total_Sell AS (
    SELECT stock_name , SUM(price) as sell
    FROM Stocks
    WHERE operation = 'Sell'    
    GROUP BY stock_name

)
, Total_Buy AS (
    SELECT stock_name , SUM(price) as buy
    FROM Stocks
    WHERE operation = 'Buy'    
    GROUP BY stock_name

)
SELECT
       TB.stock_name
    ,  TS.sell - TB.buy as capital_gain_loss
FROM Total_Sell TS
JOIN Total_Buy TB
ON TS.stock_name = TB.stock_name
