# Problem statement:
  --------------------
Reformat the table such that there is a department id column and a revenue column for each month.
Return the result table in any order.
The result format is in the following example.

# Table schema:
  -----------------
Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
In SQL,(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
  
# Input:
  -------------------------
Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+

# Output:
  -------------------------
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+

# Solution:
  --------------------------
WITH JANU AS(
    SELECT id,
    SUM(revenue) as Jan_Revenue
    FROM Department
    WHERE month = 'Jan'
    GROUP BY id
)
,  FEBU AS(
    SELECT id,
    SUM(revenue) as Feb_Revenue
    FROM Department
    WHERE month = 'Feb'
    GROUP BY id
)
,  MARCH AS(
    SELECT id,
    SUM(revenue) as Mar_Revenue
    FROM Department
    WHERE month = 'Mar'
    GROUP BY id
)
,  APRIL AS(
    SELECT id,
    SUM(revenue) as Apr_Revenue
    FROM Department
    WHERE month = 'Apr'
    GROUP BY id
)
,  MAY AS(
    SELECT id,
    SUM(revenue) as May_Revenue
    FROM Department
    WHERE month = 'May'
    GROUP BY id
)
,  JUNE AS(
    SELECT id,
    SUM(revenue) as Jun_Revenue
    FROM Department
    WHERE month = 'Jun'
    GROUP BY id
)
,  JULY AS(
    SELECT id,
    SUM(revenue) as Jul_Revenue
    FROM Department
    WHERE month = 'Jul'
    GROUP BY id
)
,  AUGUST AS(
    SELECT id,
    SUM(revenue) as Aug_Revenue
    FROM Department
    WHERE month = 'Aug'
    GROUP BY id
)
,  SEPTEM AS(
    SELECT id,
    SUM(revenue) as Sep_Revenue
    FROM Department
    WHERE month = 'Sep'
    GROUP BY id
)
,  OCTOBER AS(
    SELECT id,
    SUM(revenue) as Oct_Revenue
    FROM Department
    WHERE month = 'Oct'
    GROUP BY id
)
,  NOVEMBER AS(
    SELECT id,
    SUM(revenue) as Nov_Revenue
    FROM Department
    WHERE month = 'Nov'
    GROUP BY id
)
,  DECEMBER AS(
    SELECT id,
    SUM(revenue) as Dec_Revenue
    FROM Department
    WHERE month = 'Dec'
    GROUP BY id
)

SELECT 
      DISTINCT D.id
    , JANU.Jan_Revenue
    , FEBU.Feb_Revenue
    , MARCH.Mar_Revenue
    , APRIL.Apr_Revenue
    , MAY.May_Revenue
    , JUNE.Jun_Revenue    
    , JULY.Jul_Revenue
    , AUGUST.Aug_Revenue
    , SEPTEM.Sep_Revenue
    , OCTOBER.Oct_Revenue    
    , NOVEMBER.Nov_Revenue
    , DECEMBER.Dec_Revenue

FROM Department D
LEFT JOIN JANU ON D.id = JANU.id
LEFT JOIN FEBU ON D.id = FEBU.id
LEFT JOIN MARCH ON D.id = MARCH.id
LEFT JOIN APRIL ON D.id = APRIL.id
LEFT JOIN MAY ON D.id = MAY.id
LEFT JOIN JUNE ON D.id = JUNE.id
LEFT JOIN JULY ON D.id = JULY.id
LEFT JOIN AUGUST ON D.id = AUGUST.id
LEFT JOIN SEPTEM ON D.id = SEPTEM.id
LEFT JOIN OCTOBER ON D.id = OCTOBER.id
LEFT JOIN NOVEMBER ON D.id = NOVEMBER.id
LEFT JOIN DECEMBER ON D.id = DECEMBER.id
