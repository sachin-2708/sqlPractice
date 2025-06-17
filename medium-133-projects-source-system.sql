-- A company manages project data from three source systems with varying reliability:
-- EagleEye: The most reliable and prioritized internal system.
-- SwiftLink: A trusted partner system with moderate reliability.
-- DataVault: A third-party system used as a fallback.

-- Data for a project can come from multiple systems. For each project, you need to select the most reliable data by prioritizing the source systems: EagleEye > SwiftLink > DataVault
-- Write an SQL to display id , project number and selected source system.
/*
Table: projects
+----------------+----------+
| COLUMN_NAME    | DATA_TYPE|
+----------------+----------+
| id             | int      |
| project_number | int      | 
| Source_System  | varchar  |
+-------------+-------------+
*/

with cte as
(select id, project_number, source_system,
case when source_system = 'EagleEye' then 1
when source_system = 'SwiftLink' then 2
when source_system = 'DataVault' then 3
end as priority
from projects)
, ranked as
(select *,
rank()over(partition by project_number order by priority) as rn
from cte)

select id, project_number, source_system
from ranked
where rn = 1

-- Alternate Solution

with cte as
(select id, project_number, source_system,
rank()over(partition by project_number order by
case when source_system = 'EagleEye' then 1
when source_system = 'SwiftLink' then 2
when source_system = 'DataVault' then 3
end) as rn
from projects)

select id, project_number, source_system
from cte
where rn=1
