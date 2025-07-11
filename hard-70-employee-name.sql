-- The HR department needs to extract the first name, middle name and last name of each employee from the full name column. However, the full name column contains names in the format "Lastname,Firstname Middlename". 
-- Please consider that an employee name can be in one of the 3 following formats.
-- 1- "Lastname,Firstname Middlename"
-- 2- "Lastname,Firstname"
-- 3- "Firstname"
/*
Table : employee 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| employeeid  | int         |
| fullname    | varchar(20) |
+-------------+-------------+
*/

with cte as
(select 
	fullname,
    instr(fullname,',') as comma_pos,
    instr(fullname,' ') as space_pos
from employee)

select fullname,
	case
    	when comma_pos = 0 then fullname 
        when space_pos = 0 then substring(fullname,comma_pos+1)
        else substring(fullname,comma_pos+1,space_pos-comma_pos)
        end as first_name,
    case
    	when space_pos = 0 then null 
        else substring(fullname,space_pos+1)
		end as middle_name,
    case
    	when comma_pos = 0 then null 
        else substring(fullname,1,comma_pos-1)
		end as last_name
from cte
