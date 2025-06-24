-- You are given a table of list of lifts , their maximum capacity and people along with their weight and gender who wants to enter into it. You need to make sure maximum people enter into the lift without lift getting overloaded but you need to give preference to female passengers first.
-- For each lift find the comma separated list of people who can be accomodated. The comma separated list should have female first and then people in the order of their weight in increasing order, display the output in increasing order of id.
/*
Table: lifts 
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| capacity_kg | int       |
| id          | int       |
+-------------+-----------+
Table: lift_passengers
+----------------+-------------+
| COLUMN_NAME    | DATA_TYPE   |
+----------------+-------------+
| passenger_name | varchar(10) |
| weight_kg      | int         |
| gender         | varchar(1)  |
| lift_id        | int         |
+----------------+-------------+
*/

with rolling_weight as
(select p.passenger_name, p.weight_kg, p.gender, l.id, l.capacity_kg, 
sum(p.weight_kg)over(partition by l.id order by case when p.gender='F' then 0 else 1 end, p.weight_kg) as roll_weight
from lift_passengers p
join lifts l on p.lift_id = l.id)

select id, group_concat(distinct passenger_name order by gender, weight_kg separator ',') as passenger_list
from rolling_weight
where capacity_kg >= roll_weight
group by id
