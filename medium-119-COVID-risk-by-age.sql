-- You have a table named covid_tests with the following columns: name, id, age, and corad score. The corad score values are categorized as follows:
-- -1 indicates a negative result.
-- Scores from 2 to 5 indicate a mild condition.
-- Scores from 6 to 10 indicate a serious condition.
-- Write a query to produce an output with the following columns:
-- age_group: Groups of ages (18-30, 31-45, 46-60).
-- count_negative: The number of people with a negative result in each age group.
-- count_mild: The number of people with a mild condition in each age group.
-- count_serious: The number of people with a serious condition in each age group.

/*
Table: covid_tests
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| name          | varchar(10) |
| id            | int         |
| age           | int         |
| corad_score   | int         |
+---------------+-------------+
*/

with group_cte as
(select *,
case when age between 18 and 30 then '18-30'
when age between 31 and 45 then '31-45'
when age between 46 and 60 then '46-60'
else '>60' end as age_group
from covid_tests)

select age_group,
sum(case when corad_score < 0 then 1 else 0 end) as count_negative,
sum(case when corad_score between 2 and 5 then 1 else 0 end) as count_mild,
sum(case when corad_score between 6 and 10 then 1 else 0 end) as count_serious
from group_cte
where age <= 60
group by age_group

-- Alternate Solution

with group_cte as
(select *,
case when age between 18 and 30 then '18-30'
when age between 31 and 45 then '31-45'
when age between 46 and 60 then '46-60' end as age_group
from covid_tests
where age between 18 and 60)

select age_group,
sum(case when corad_score < 0 then 1 else 0 end) as count_negative,
sum(case when corad_score between 2 and 5 then 1 else 0 end) as count_mild,
sum(case when corad_score between 6 and 10 then 1 else 0 end) as count_serious
from group_cte
group by age_group

-- Alternate solution

with group_cte as
(select *,
case when age between 18 and 30 then '18-30'
when age between 31 and 45 then '31-45'
when age between 46 and 60 then '46-60' end as age_group,
case when corad_score < 0 then 1 else 0 end as count_negative,
case when corad_score between 2 and 5 then 1 else 0 end as count_mild,
case when corad_score between 6 and 10 then 1 else 0 end as count_serious
from covid_tests
where age between 18 and 60)

select age_group,
sum(count_negative) as count_negative,
sum(count_mild) as count_mild,
sum(count_serious) as count_serious
from group_cte
group by age_group
