-- You work in the Human Resources (HR) department of a growing company that tracks the status of its employees year over year. The company needs to analyze employee status changes between two consecutive years: 2020 and 2021.
-- The company's HR system has two separate tables of employees for the years 2020 and 2021, which include each employee's unique identifier (emp_id) and their corresponding designation (role) within the organization.
-- The task is to track how the designations of employees have changed over the year. Specifically, you are required to identify the following changes:
-- Promoted: If an employee's designation has changed (e.g., from Trainee to Developer, or from Developer to Manager).
-- Resigned: If an employee was present in 2020 but has left the company by 2021.
-- New Hire: If an employee was hired in 2021 but was not present in 2020.
-- Assume that employees can only be promoted and cannot be demoted.
/*
Table: emp_2020 
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | int      |
| designation | date     |
+-------------+----------+

Table: emp_2021
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | int      |
| designation | date     |
+-------------+----------+
*/

with cte as
(select e1.emp_id, e1.designation as old_designation, e2.designation from emp_2020 e1
left join emp_2021 e2 on e1.emp_id = e2.emp_id
union
select e3.emp_id, e4.designation as old_designation, e3.designation from emp_2021 e3
left join emp_2020 e4 on e3.emp_id = e4.emp_id)
, cte2 as
(select emp_id,
case when old_designation<>designation then 'Promoted'
when designation is null then 'Resigned'
when old_designation is null then 'New Hire' end
as comment
from cte)

select emp_id, comment
from cte2
where comment is not null
