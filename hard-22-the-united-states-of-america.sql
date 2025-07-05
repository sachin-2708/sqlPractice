-- In some poorly designed UI applications, there's often a lack of data input restrictions. For instance, in a free text field for the country, users might input variations such as 'USA,' 'United States of America,' or 'US.'
-- Suppose we have survey data from individuals in the USA about their job satisfaction, rated on a scale of 1 to 5. Write a SQL query to count the number of respondents for each rating on the scale. Additionally, include the country name in the format that occurs most frequently in that scale, display the output in ascending order of job satisfaction.
/*
Table: survey 
+------------------+-------------+
| COLUMN_NAME      | DATA_TYPE   |
+------------------+-------------+
| country          | varchar(20) |
| job_satisfaction | int         |
| name             | varchar(10) |
+------------------+-------------+
*/

with cte as
(select job_satisfaction, country, count(*) as cnt 
from survey
group by job_satisfaction, country)
, cte2 as
(select *,
sum(cnt)over(partition by job_satisfaction) as number_of_respondents,
row_number()over(partition by job_satisfaction order by cnt desc) as rn
from cte)

select job_satisfaction, country, number_of_respondents
from cte2
where rn = 1

-- alternate solution

with cte1 as
(select job_satisfaction, country, count(*) as cnt
from survey
group by job_satisfaction, country)
, cte2 as
(select *,
sum(cnt)over(partition by job_satisfaction) as no_of_respondents,
max(cnt)over(partition by job_satisfaction) as max_cnt
from cte1)

select job_satisfaction, country, no_of_respondents
from cte2
where cnt = max_cnt
