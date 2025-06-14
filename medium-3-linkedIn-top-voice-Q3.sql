-- LinkedIn is a professional social networking app. 
-- They want to give top voice badge to their best creators to encourage them to create more quality content. A creator qualifies for the badge if he/she satisfies following criteria.
-- 1- Creator should have more than 50k followers.
-- 2- Creator should have more than 100k impressions on the posts that they published in the month of Dec-2023.
-- 3- Creator should have published atleast 3 posts in Dec-2023.

-- Write a SQL to get the list of top voice creators name along with no of posts and impressions by them in the month of Dec-2023.


select c.creator_name, 
	count(*) as no_of_post, 
    sum(p.impressions) as total_impressions 
from creators c
left join posts p 
on p.creator_id = c.creator_id
where year(publish_date) = '2023' and month(publish_date) = '12'
and c.followers > 50000
group by c.creator_name
having sum(p.impressions) > 100000
and count(*) >= 3
