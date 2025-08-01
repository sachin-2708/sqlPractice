/* You are building a flight planner system for a travel application. The system stores data about flights between airports and users who want to travel between cities. The planner must help each user find the fastest possible flight route from their source city to their destination city.
Each route may consist of:
A direct flight, or
A two-leg journey with only one stopover at an intermediate city.
A stopover is allowed only if the connecting flight departs at or after the arrival time of the first flight. The second flight must depart from the airport where the first one landed.

Write a SQL query that returns following columns, for each user:
user_id
trip_start_city
middle_city (NULL if it's a direct flight)
trip_end_city
trip_time (Total journey duration in minutes)
flight_ids (semicolon-separated , eg: 1 for direct, or 3;5 for one-stop)
Return all possible valid routes, sorted by user_id and shortest duration.

Table: users
+-----------------+----------+
| COLUMN_NAME     | DATA_TYPE|
+-----------------+----------+
| id              | INT      |
| source_city     | VARCHAR  |  
| destination_city| VARCHAR  |  
+--------------+-------------+
Table: airports
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| port_code    | VARCHAR  |
| city_name    | VARCHAR  | 
+-------------------------+
Table: flights
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| flight_id    | VARCHAR  |
| start_port   | VARCHAR  | 
| end_port     | VARCHAR  | 
| start_time   | datetime | 
| end_time     | datetime | 
+-------------------------+
*/

select 
	u.user_id, 
    sa.city_name as trip_start_city, 
    NULL as middle_city, 
    ea.city_name as trip_end_city, 
    timestampdiff(minute,f.start_time, f.end_time) as trip_time, 
    cast(f.flight_id as char) as flight_ids  
from flights f
join airports sa on sa.port_code = f.start_port
join airports ea on ea.port_code = f.end_port
join users u on u.source_city = sa.city_name
and u.destination_city = ea.city_name
union all
select 
	u.user_id, 
    sa.city_name as trip_start_city, 
    ma.city_name as middle_city, 
    ea.city_name as trip_end_city, 
    timestampdiff(minute,f1.start_time, f2.end_time) as trip_time,
    concat(f1.flight_id,';',f2.flight_id) as flight_ids
from flights f1
join flights f2 on f1.end_port = f2.start_port
join airports sa on sa.port_code = f1.start_port
join airports ma on ma.port_code = f1.end_port
join airports ea on ea.port_code = f2.end_port
join users u on u.source_city = sa.city_name
and u.destination_city = ea.city_name
where f2.start_time >= f1.end_time
order by user_id, trip_time

-- Alternate Solution

with user_start_port as
(select u.user_id, a.port_code, u.source_city
from users u
join airports a on a.city_name = u.source_city)
, user_end_port as
(select u.user_id, a.port_code, u.destination_city
from users u
join airports a on a.city_name = u.destination_city)
, direct_flights as
(select sp.user_id, sp.source_city as trip_start_city, NULL as middle_city, ep.destination_city as trip_end_city, timestampdiff(minute,f.start_time, f.end_time) as trip_time, cast(f.flight_id as char) as flight_ids
from flights f
join user_start_port sp on sp.port_code = f.start_port
join user_end_port ep on ep.port_code = f.end_port
where sp.user_id = ep.user_id)
, connecting_flights as
(select sp.user_id, sp.source_city as trip_start_city, ma.city_name as middle_city, ep.destination_city as trip_end_city, timestampdiff(minute,f1.start_time, f2.end_time) as trip_time, concat(f1.flight_id, ';', f2.flight_id) as flight_ids
from flights f1
join flights f2 
	on f1.end_port = f2.start_port 
    and f1.end_time <= f2.start_time
join user_start_port sp on sp.port_code = f1.start_port
join airports ma on ma.port_code = f1.end_port
join user_end_port ep on ep.port_code = f2.end_port
where sp.user_id = ep.user_id)

select * from direct_flights
union all
select * from connecting_flights
order by user_id, trip_time

