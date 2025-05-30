-- Suppose you are a data analyst working for ride-sharing platform Uber. Uber is interested in analyzing the performance of drivers based on their ratings and wants to categorize them into different performance tiers. 
-- Write an SQL query to categorize drivers equally into three performance tiers (Top, Middle, and Bottom) based on their average ratings. 
--Drivers with the highest average ratings should be placed in the top tier, drivers with ratings below the top tier but above the bottom tier should be placed in the middle tier, and drivers with the lowest average ratings should be placed in the bottom tier. Sort the output in decreasing order of average rating.
/*
Table : driver_ratings
+-------------+--------------+
| COLUMN_NAME | DATA_TYPE    |
+-------------+--------------+
| driver_id   | int          |
| avg_rating  | decimal(3,2) |
+-------------+--------------+
*/

WITH tier_cte AS (
SELECT driver_id, avg_rating,
NTILE(3) OVER(ORDER BY avg_rating DESC) AS tier_rating
FROM driver_ratings
)

SELECT driver_id, avg_rating,
CASE WHEN tier_rating = 1 THEN 'Top' 
WHEN tier_rating = 2 THEN 'Middle' 
ELSE 'Bottom' END AS performance_tier
FROM tier_cte
ORDER BY avg_rating DESC
