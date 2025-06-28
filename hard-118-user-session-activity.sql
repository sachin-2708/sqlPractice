-- You are given a table user events that tracks user activity with the following schema:
/*
Table: events
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| user_id     | int      |    
| event_type  | varchar  |
| event_time  | timestamp|
+-------------+----------+
Task:
1. Identify user sessions. A session is defined as a sequence of activities by a user where the time difference between consecutive events is less than or equal to 30 minutes. If the time between two events exceeds 30 minutes, it's considered the start of a new session.
2. For each session, calculate the following metrics:
session_id : a unique identifier for each session.
session_start_time : the timestamp of the first event in the session.
session_end_time : the timestamp of the last event in the session.
session_duration : the difference between session_end_time and session_start_time.
event_count : the number of events in the session.
*/

with cte as
(select *,
lag(event_time,1,event_time)over(partition by userid order by event_time) as prev_event_time,
timestampdiff(minute, lag(event_time,1,event_time)over(partition by userid order by event_time), event_time) as time_diff
from events)
, cte2 as
(select userid, event_type, event_time,
case when time_diff <= 30 then 0 else 1 end as session_flag,
sum(case when time_diff <= 30 then 0 else 1 end)over(partition by userid order by event_time) as group_id
from cte)

select userid,
row_number()over(partition by userid order by min(event_time)) as session_id,
min(event_time) as session_start_time,
max(event_time) as session_end_time,
timestampdiff(minute,min(event_time),max(event_time)) as session_duration,
count(*) as event_count
from cte2
group by userid, group_id
