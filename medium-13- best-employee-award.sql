-- TCS wants to award employees based on number of projects completed by each individual each month.
-- Write an SQL to find best employee for each month along with number of projects completed by him/her in that month, display the output in descending order of number of completed projects.
/*Table: projects
+-------------------------+-------------+
| COLUMN_NAME             | DATA_TYPE   |
+-------------------------+-------------+
| project_id              | int         |
| employee_name           | varchar(10) |
| project_completion_date | date        |
+-------------------------+-------------+
*/

with cte as
(select employee_name, 
date_format(project_completion_date, '%Y%m') as yearmonth,
count(*) as total_projects
from projects
group by employee_name, date_format(project_completion_date, '%Y%m'))
,
cte2 as(
select employee_name, yearmonth, total_projects,
rank()over(partition by yearmonth order by total_projects desc) as rnk
from cte)

select employee_name, total_projects as no_of_completed_projects,
yearmonth
from cte2
where rnk = 1
order by no_of_completed_projects desc
