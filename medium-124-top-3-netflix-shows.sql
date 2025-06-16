-- Netflix’s analytics team wants to identify the Top 3 most popular shows based on the viewing patterns of its users. The definition of "popular" is based on two factors:
-- Unique Watchers: The total number of distinct users who have watched a show.
-- Total Watch Duration: The cumulative time users have spent watching the show.
-- In the case of ties in the number of unique watchers, the total watch duration will serve as the tie-breaker.
-- Write an SQL query to determine the Top 3 shows based on the above criteria. The output should be sorted by show_id and should include: show_id , unique_watchers, total_duration.
 
/*
Table: watch_history 
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| user_id       | int      |
| show_id       | int      |
| watch_date    | int      |
| watch_duration| int      |
+--------------+-----------+
*/


with cte as
(select show_id, count(distinct user_id) as unique_viewers, sum(watch_duration) as total_duration
from watch_history
group by show_id),
ranked as
(select show_id, unique_viewers, total_duration,
rank()over(order by unique_viewers desc, total_duration desc) as rn
from cte)

select show_id, unique_viewers, total_duration
from ranked
where rn <= 3
order by show_id

-- Alternate Solution

select show_id, unique_viewers, total_duration
from 
  (select show_id, count(distinct user_id) as unique_viewers, sum(watch_duration) as total_duration
from watch_history
group by show_id
order by unique_viewers desc, total_duration desc
limit 3) a
order by show_id
