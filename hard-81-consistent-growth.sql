-- In a financial analysis project, you are tasked with identifying companies that have consistently increased their revenue by at least 25% every year. You have a table named revenue that contains information about the revenue of different companies over several years.
-- Your goal is to find companies whose revenue has increased by at least 25% every year consecutively. So for example If a company's revenue has increased by 25% or more for three consecutive years but not for the fourth year, it will not be considered.
-- Write an SQL query to retrieve the names of companies that meet the criteria mentioned above along with total lifetime revenue , display the output in ascending order of company id
/*
Table : revenue 
+-------------+---------------+
| COLUMN_NAME | DATA_TYPE     |
+-------------+---------------+
| company_id  | int           |
| year        | int           |
| revenue     | decimal(10,2) |
+-------------+---------------+
*/

with cte as
(select *, lag(revenue,1)over(partition by company_id order by year) as prev_revenue
from revenue)
, cte2 as
(select distinct company_id 
from cte
where revenue < 1.25*prev_revenue)

select company_id, sum(revenue) as total_revenue
from revenue
where company_id not in (select company_id from cte2) 
group by company_id

-- Alternate Solution

with revenue_growth as
(select *, case when revenue >= 1.25*
lag(revenue,1,0)over(partition by company_id order by year) then 1 else 0 end as growth_flag
from revenue)

select company_id, sum(revenue) as total_revenue
from revenue
where company_id not in (select distinct company_id from revenue_growth where growth_flag = 0)
group by company_id
