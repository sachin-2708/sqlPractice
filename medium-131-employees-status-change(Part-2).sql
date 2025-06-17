-- You work in the Human Resources (HR) department of a growing company that tracks the status of its employees year over year. The company needs to analyze employee status changes between two consecutive years: 2020 and 2021.
-- The company's HR system has two separate records of employees for the years 2020 and 2021 in the same table, which include each employee's unique identifier (emp_id) and their corresponding designation (role) within the organization for each year.
-- The task is to track how the designations of employees have changed over the year. Specifically, you are required to identify the following changes:
-- Promoted: If an employee's designation has changed (e.g., from Trainee to Developer, or from Developer to Manager).
-- Resigned: If an employee was present in 2020 but has left the company by 2021.
-- New Hire: If an employee was hired in 2021 but was not present in 2020.
-- Assume that employees can only be promoted and cannot be demoted.
/*
Table: employees
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | int      |
| year        | int      | 
| designation | date     |
+-------------+----------+
*/

with cte_next as
(select *,
lead(year)over(partition by emp_id) as next_year,
lead(designation)over(partition by emp_id) as next_designation
from employees),
next as
(select * from cte_next
where year = 2020)
, cte_prev as
(select *, 
lag(year)over(partition by emp_id) as prev_year,
lag(designation)over(partition by emp_id) as prev_designation
from employees)
, last as
(select *
from cte_prev where 
year = 2021 and prev_year is null)
, final as
(select *
from next
union
select *
from last)
, comment_cte as
(select emp_id,
case when designation <> next_designation then 'Promoted'
when year = 2020 and next_designation is null then 'Resigned'
when year = 2021 and next_designation is null then 'New Hire'
end as comment
from final)

select emp_id, comment
from comment_cte
where comment is not null

-- Alternate Solution

select coalesce(e20.emp_id,e21.emp_id) as emp_id,
case when e20.designation <> e21.designation then 'Promoted'
when e21.designation is null then 'Resigned'
else 'New Hire' end as comment
from employees e20
left join employees e21 on e20.emp_id = e21.emp_id and e21.year = 2021
where e20.year = 2020
and (e20.designation <> e21.designation
or e20.designation is null
or e21.designation is null)
union
select coalesce(e20.emp_id,e21.emp_id) as emp_id,
case when e20.designation <> e21.designation then 'Promoted'
when e21.designation is null then 'Resigned'
else 'New Hire' end as comment
from employees e21
left join employees e20 on e20.emp_id = e21.emp_id and e20.year = 2020
where e21.year = 2021
and (e20.designation <> e21.designation
     or e20.designation is null
     or e21.designation is null)
