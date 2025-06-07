-- You are working for a marketing agency that manages multiple Instagram influencer accounts. Your task is to analyze the engagement performance of these influencers before and after they join your company.
-- Write an SQL query to calculate average engagement growth rate percent for each influencer after they joined your company compare to before. Round the growth rate to 2 decimal places and sort the output in decreasing order of growth rate.
-- Engagement = (# of likes + # of comments on each post)
/*
Table: influencers
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| influencer_id | int         |
| join_date     | date        |
| username      | varchar(10) |
+---------------+-------------+
Table: posts
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| comments      | int       |
| influencer_id | int       |
| likes         | int       |
| post_date     | date      |
| post_id       | int       |
+---------------+-----------+
*/

with cte as 
(select i.username,
avg(case when p.post_date < i.join_date then (likes+comments) end) as before_engagement,
avg(case when p.post_date > i.join_date then (likes+comments) end) as after_engagement
from posts p
join influencers i on p.influencer_id = i.influencer_id
group by i.username)

select username, before_engagement, after_engagement,
round(100.0*(after_engagement-before_engagement)/before_engagement,2) as growth
from cte
