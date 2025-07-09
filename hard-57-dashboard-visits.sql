-- You're working as a data analyst for a popular website's dashboard analytics team. Your task is to analyze user visits to the dashboard and identify users who are highly engaged with the platform. The dashboard records user visits along with timestamps to provide insights into user activity patterns.
-- A user can visit the dashboard multiple times within a day. However, to be counted as separate visits, there should be a minimum gap of 60 minutes between consecutive visits. If the next visit occurs within 60 minutes of the previous one, it's considered part of the same visit.
/*
Table: dashboard_visit
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| user_id     | varchar(10) |
| visit_time  | datetime    |
+-------------+-------------+
Write an SQL query to find total number of visits by each user along with number of distinct days user has visited the dashboard. While calculating the number of distinct days you have to consider a visit even if it is same as previous days visit.
So for example if there is a visit at 2024-01-12 23:30:00 and next visit at 2024-01-13 00:15:00 , The visit on 13th will not be considered as new visit because it is within 1 hour window of previous visit but number of days will be counted as 2 only, display the output in ascending order of user id.
*/

with cte as
(select user_id, visit_time, 
lag(visit_time,1)over(partition by user_id order  by visit_time) as last_visit
from dashboard_visit)

select user_id,
sum(case when timestampdiff(minute,last_visit,visit_time) is null or timestampdiff(minute,last_visit,visit_time) > 60 then 1
else 0 end) as no_of_visits,
count(distinct date(visit_time)) as visit_days
from cte
group by user_id
