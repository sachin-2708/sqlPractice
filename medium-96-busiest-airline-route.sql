-- You are given a table named "tickets" containing information about airline tickets sold. Write an SQL query to find the busiest route based on the total number of tickets sold. Also display total ticket count for that route.
-- oneway_round ='O' -> One Way Trip 
-- oneway_round ='R' -> Round Trip 
-- Note: DEL -> BOM is different route from BOM -> DEL
/*
Tables: tickets
+----------------+-------------+
| COLUMN_NAME    | DATA_TYPE   |
+----------------+-------------+
| airline_number | varchar(10) |
| origin         | varchar(3)  |
| destination    | varchar(3)  |
| oneway_round   | char(1)     |
| ticket_count   | int         |
+----------------+-------------+
*/

with cte as
(select origin, destination, ticket_count
from tickets
union all
select destination, origin, ticket_count
from tickets
where oneway_round = 'R')

select origin, destination, sum(ticket_count) as tc
from cte
group by origin, destination
order by tc desc
limit 1

-- Alternate Solution

with all_flights as
(select airline_number, origin, destination, ticket_count
from tickets
union all
select airline_number,
case when oneway_round = 'R' then destination end as update_origin,
case when oneway_round = 'R' then origin end as update_destination,
ticket_count
from tickets
where oneway_round = 'R'),
rnking as 
(select origin, destination, sum(ticket_count) as tc,
 rank()over(order by sum(ticket_count) desc) as rnk
from all_flights
group by origin, destination)

select origin, destination, tc
from rnking
where rnk = 1

-- Alternate Solution

with all_flights as
(select airline_number, origin, destination, ticket_count
from tickets
union all
select airline_number,
case when oneway_round = 'R' then destination end as update_origin,
case when oneway_round = 'R' then origin end as update_destination,
ticket_count
from tickets
where oneway_round = 'R')

select origin, destination, sum(ticket_count) as tc
from all_flights
group by origin, destination
order by tc desc
limit 1


