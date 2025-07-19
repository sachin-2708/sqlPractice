-- You are a facilities manager at a corporate office building, responsible for tracking employee visits, floor preferences, and resource usage within the premises. The office building has multiple floors, each equipped with various resources such as desks, computers, monitors, and other office supplies. You have a database table “entries” that stores information about employee visits to the office building. Each record in the table represents a visit by an employee and includes details such as their name, the floor they visited, and the resources they used during their visit.
-- Write an SQL query to retrieve the total visits, most visited floor, and resources used by each employee, display the output in ascending order of employee name.
/*
Table : entries
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| emp_name    | varchar(10) |
| address     | varchar(10) |
| floor       | int         |
| resources   | varchar(10) |
+-------------+-------------+
*/

with cte as
(select emp_name, floor, 
row_number()over(partition by emp_name order by count(floor) desc) as floor_visit_rn
from entries
group by emp_name, floor)
, cte2 as
(select emp_name, 
count(*) as total_visits, 
group_concat(distinct resources separator ',') as resources_used 
from entries
group by emp_name)

select c2.emp_name, c2.total_visits, c1.floor as most_visited_floor, c2.resources_used
from cte2 c2
join cte c1 on c1.emp_name = c2.emp_name and floor_visit_rn = 1 
order by emp_name
