-- Given a sample table with emails sent vs. received by the users, calculate the response rate (%) which is given as emails sent/ emails received. For simplicity consider sent emails are delivered. List all the users that fall under the top 25 percent based on the highest response rate.
-- Please consider users who have sent at least one email and have received at least one email.
/*
Table : gmail_data
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| from_user   | varchar(20) |
| to_user     | varchar(20) |
| email_day   | date        |
+-------------+-------------+
*/

with sent as
(select from_user, count(*) as email_sent 
from gmail_data
group by from_user
order by email_sent desc)

, received as
(select to_user, count(*) as email_received 
from gmail_data
group by to_user
order by email_received desc)

, response as
(select s.from_user as user_id, 
100.0*s.email_sent/r.email_received as response_rate,
ntile(4)over(order by 100.0*s.email_sent/r.email_received desc) as quartile
from sent s
join received r on s.from_user = r.to_user and s.email_sent >= 1 and r.email_received >= 1
order by response_rate desc)

select user_id, response_rate
from response
where quartile = 1
