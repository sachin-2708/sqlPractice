-- You are given a table of list of lifts , their maximum capacity and people along with their weight who wants to enter into it. You need to make sure maximum people enter into the lift without lift getting overloaded.
-- For each lift find the comma separated list of people who can be accommodated. The comma separated list should have people in the order of their weight in increasing order, display the output in increasing order of id.
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
| lift_id        | int         |
+----------------+-------------+
*/

with rolling_weight as
(select passenger_name, weight_kg, lift_id, capacity_kg,
sum(weight_kg)over(partition by lift_id order by weight_kg) as roll_weight
from lift_passengers p
inner join lifts l on p.lift_id = l.id)

select lift_id, group_concat(passenger_name separator ',') as passenger_list
from rolling_weight
where roll_weight <= capacity_kg
group by lift_id
order by lift_id
