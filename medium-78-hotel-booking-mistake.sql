-- A hotel has accidentally made overbookings for certain rooms on specific dates. Due to this error, some rooms have been assigned to multiple customers for overlapping periods, leading to potential conflicts. The hotel management needs to rectify this mistake by contacting the affected customers and providing them with alternative arrangements.
-- Your task is to write an SQL query to identify the overlapping bookings for each room and determine the list of customers affected by these overlaps. For each room and overlapping date, the query should list the customers who have booked the room for that date. 
-- A booking's check-out date is not inclusive, meaning that if a room is booked from April 1st to April 4th, it is considered occupied from April 1st to April 3rd , another customer can check-in on April 4th and that will not be considered as overlap.
-- Order the result by room id, booking date. You may use calendar dim table which has all the dates for the year April 2024.
/*
Table : bookings
+----------------+-----------+
| COLUMN_NAME    | DATA_TYPE |
+----------------+-----------+
| room_id        | int       |
| customer_id    | int       |
| check_in_date  | date      |
| check_out_date | date      |
+----------------+-----------+
Table : calendar_dim
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| cal_date    | date      |
+-------------+-----------+
*/

with cte as
(select b.room_id, b.customer_id, c.cal_date as book_date
from bookings b
inner join calendar_dim c on c.cal_date between b.check_in_date and date_sub(check_out_date, interval 1 day))

select room_id, book_date, group_concat(customer_id order by customer_id asc separator ", ") as customers
from cte
group by room_id, book_date
having count(customer_id)>1
order by room_id
