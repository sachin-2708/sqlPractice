-- At Spotify, we track user activity to understand their engagement with the platform. One of the key metrics we focus on is how consistently a user listens to music each day. A user is considered "consistent" if they have login session every single day since their first login.
-- Your task is to identify users who have logged in and listened to music every single day since their first login date until today.
-- Note: Dates are as per UTC time zone.
/*
Table: user_sessions
+-----------------+----------+
| COLUMN_NAME     | DATA_TYPE|
+-----------------+----------+
| user_id         | int      |
| login_timestamp | datetime | 
+-----------------+----------+
*/

select user_id
from user_sessions
group by user_id
having count(distinct date(login_timestamp)) =
curdate()-min(date (login_timestamp))+1

-- Alternate Solution

with cte as
(select user_id, count(distinct(date(login_timestamp))) as login_days, (CURDATE()-min(date(login_timestamp))+1) as days_between
from user_sessions
group by user_id)

select user_id
from cte
where login_days = days_between
