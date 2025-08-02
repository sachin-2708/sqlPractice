/*
The HR analytics team wants to evaluate employee performance based on their salary progression and promotion history. Write a query to return a summary for each employee with the following:
 1. `employee_id`
 2. `latest_salary`: most recent salary value
 3. `total_promotions`: number of times the employee got a promotion 
 4. `max_perc_change`: the maximum percentage increase between any two salary changes (round to 2 decimal places)
 5. `never_decreased`: 'Y' if salary never decreased, else 'N'
 6. `RankByGrowth`: rank of the employee based on salary growth (latest_salary / first_salary), tie-breaker = earliest join date
Table: employees
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| employee_id   | INT      | 
| name          | VARCHAR  | 
| join_date     | DATE     | 
| department    | VARCHAR  |  
| intial_salary | INT      | 
+--------------------------+
Table: salary_history
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| employee_id  | INT      | 
| change_date  | DATE     |
| salary       | INT      | 
| promotion    | VARCHAR  | 
+-------------------------+
*/

with salary_union as
(select employee_id, join_date as change_date, initial_salary as salary, 'No' as promotion
from employees
union all
select employee_id, change_date, salary, promotion
from salary_history)
, cte as
(select *,
rank()over(partition by employee_id order by change_date) rn_asc,
rank()over(partition by employee_id order by change_date desc) rn_desc,
lead(salary)over(partition by employee_id order by change_date desc) as prev_salary
from salary_union)
, salary_growth as
(select employee_id, 
max(case when rn_desc = 1 then salary end)*1.0/max(case when rn_asc = 1 then salary end) as salary_growth, min(change_date) as join_date
from cte
group by employee_id)
, decrease_flag as
(select employee_id,
max(case when prev_salary is not null and salary < prev_salary then 1 else 0 end) as has_decreased
from cte
group by employee_id)

select c.employee_id,
max(case when c.rn_desc = 1 then salary end) as latest_salary,
sum(case when c.promotion = 'Yes' then 1 else 0 end) as total_promotions,
max(case when c.prev_salary is not null then round((c.salary - c.prev_salary)*100.0/c.prev_salary,2) else 0.00 end) as max_perc_growth,
case when d.has_decreased = 1 then 'N' else 'Y' end as never_decreased,
rank()over(order by sg.salary_growth desc, sg.join_date asc) as RankByGrowth
from cte c
join decrease_flag d on d.employee_id = c.employee_id
join salary_growth sg on sg.employee_id = c.employee_id
group by c.employee_id, d.has_decreased
order by employee_id
