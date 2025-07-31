/*
Khan Academy capture data on how users are using their product, with the schemas below. Using this data they would like to report on monthly “engaged” retention rates. Monthly “engaged” retention is defined here as the % of users from each registration cohort that continued to use the product as an “engaged” user having met the threshold of >= 30 minutes per month. They are looking for the retention metric calculated for within 1-3 calendar months post registration.
Table: users
+-------------------+----------+
| COLUMN_NAME       | DATA_TYPE|
+-------------------+----------+
| user_id           | VARCHAR  |
| registration_date | DATE     | 
+-------------+----------------+
Table: usage
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| user_id     | VARCHAR  |
| usage_date  | DATE     | 
| location    | VARCHAR  | 
| time_spent  | INTEGER  | 
+-------------+----------+
Write a SQL query whose output is in the following format using the input tables in the editor:
registration_month 	total_users    	m1_retention   	m2_retention 	m3_retention
2019-01	            3	              66.67 	        33.33	        33.33
2019-02	            2	              100.00	        0.00	        50.00

Explanation:
user aaa used the product 2 times within the first month (2019-01-03, 2019-02-01), 0 times in the 2nd month, and 1 time in the 3rd month (2019-03-04), post the user aaa’s initial registration (2019-01-03). User bbb used the product once in 1st month (2019-01-03) and once in 2nd month (2019-02-04) post registration (2019-01-02), but the 1st month usage is <30 minutes so the user doesn’t count in the m1_retention metric. Note that we want to calculate this usage metric as across all geographies.  Round the result to 2 decimal places.
Also note that m1 time period is exact one month from registration date not just the month of registration. Similarly m2 and m3.
*/

with cte as
(select u.user_id, date_format(u.registration_date,'%Y-%m') as registration_month,
sum(case when d.usage_date <= date_add(u.registration_date, interval 1 month) then d.time_spent else 0 end) as 'm1_time',
sum(case when d.usage_date > date_add(u.registration_date, interval 1 month) and d.usage_date <= date_add(u.registration_date, interval 2 month) then d.time_spent else 0 end) as 'm2_time',
sum(case when d.usage_date > date_add(u.registration_date, interval 2 month) and d.usage_date <= date_add(u.registration_date, interval 3 month) then d.time_spent else 0 end) as 'm3_time'
from users u
left join usage_data d on d.user_id = u.user_id
group by u.user_id, date_format(u.registration_date,'%Y-%m'))

select registration_month, count(*) as total_users,
ifnull(round(sum(case when m1_time >= 30 then 1 else 0 end)*100.0/count(*),2),0) as m1_retention,
ifnull(round(sum(case when m2_time >= 30 then 1 else 0 end)*100.0/count(*),2),0) as m2_retention,
ifnull(round(sum(case when m3_time >= 30 then 1 else 0 end)*100.0/count(*),2),0) as m3_retention
from cte
group by registration_month
