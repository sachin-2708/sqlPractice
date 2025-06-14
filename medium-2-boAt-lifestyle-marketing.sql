-- boAt Lifestyle is focusing on influencer marketing to build and scale their brand. They want to partner with power creators for their upcoming campaigns. The creators should satisfy below conditions to qualify:
-- 1- They should have 100k+ followers on at least 2 social media platforms and
-- 2- They should have at least 50k+ views on their latest YouTube video.
-- Write an SQL to get creator id and name satisfying above conditions.
/*
Table: creators
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| id          | int         |
| name        | varchar(10) |
| followers   | int         |
| platform    | varchar(10) |
+-------------+-------------+
Table: youtube_videos
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| id           | int       |
| creator_id   | int       |
| publish_date | date      |
| views        | int       |
+--------------+-----------+
*/

with users_cte as
(select id, name
 from creators
 where followers > 100000
group by id, name
having count(*)>1)
, youtube_views as (
select creator_id from youtube_videos
where publish_date in (select max(publish_date) from youtube_videos group by creator_id)
and views >= 50000)

select u.id, u.name
from users_cte u
join youtube_views y on y.creator_id = u.id

-- Alternate Solution

with user_cte as
(select id, name
from creators
where followers > 100000
group by id, name
having count(*) >= 2)
, views_cte as
(select *, 
row_number()over(partition by creator_id order by publish_date desc) as rn
from youtube_videos)

select u.id,u.name
from user_cte u
join views_cte v on u.id = v.creator_id
where v.rn = 1 and v.views > 50000
