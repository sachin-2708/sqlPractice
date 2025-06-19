-- Identify passengers with more than 5 flights from the same airport since last 1 year from current date. Display passenger id, departure airport code and number of flights.
/*
Table: passenger_flights
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| Passenger_id  | VARCHAR  |
| Flight_id     | VARCHAR  | 
| Departure_date| date     | 
+---------------+----------+
Table: flight_details
+-------------------+----------+
| COLUMN_NAME       | DATA_TYPE|
+-------------------+----------+
| Flight_id         | VARCHAR  |
| Departure_airport | VARCHAR  | 
| Arrival_airport   | date     | 
+-------------------+----------+
*/

select p.passenger_id, f.departure_airport_code, count(p.flight_id) as cnt
from passenger_flights p
join flight_details f on f.flight_id = p.flight_id
where departure_date between date_sub(curdate(), interval 1 year) and curdate()
group by p.passenger_id, f.departure_airport_code
having count(p.flight_id) >=5 

-- Alternate Solution

select p.passenger_id, f.departure_airport_code, count(p.flight_id) as cnt
from passenger_flights p
join flight_details f on f.flight_id = p.flight_id
where departure_date > date_sub(curdate(), interval 1 year)
group by p.passenger_id, f.departure_airport_code
having count(p.flight_id) >=5 
