-- Meta (formerly Facebook) is analyzing the performance of Instagram Reels across different states in the USA. You have access to a table named REEL that tracks the cumulative views of each reel over time. Write an SQL to get average daily views for each Instagram Reel in each state.
-- Round the average to 2 decimal places and sort the result by average is descending order. 
/*
Table: reel 
+-----------------+----------+
| COLUMN_NAME     | DATA_TYPE|
+-----------------+----------+
| reel_id         | int      |    
| record_date     | date     |
| state           | varchar  |
| cumulative_views| int      |
+-------------+--------------+
*/

select reel_id, state, 
round(max(cumulative_views)/count(distinct record_date),2) as avg_daily_views
from reel
group by reel_id, state
order by avg_daily_views desc

-- alternate solution

with cte as
(select reel_id, state, 
max(cumulative_views) as max_cum_views,
count(distinct record_date) as no_of_days
from reel
group by reel_id, state)

select reel_id, state, round(max_cum_views/no_of_days,2) as avg_daily_views
from cte
order by avg_daily_views desc
