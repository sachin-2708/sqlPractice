-- In a bustling city, Uber operates a fleet of drivers who provide transportation services to passengers. As part of Uber's policy, drivers are subject to a commission deduction from their total earnings. The commission rate is determined based on the average rating received by the driver over their recent trips. This ensures that drivers delivering exceptional service are rewarded with lower commission rates, while those with lower ratings are subject to higher commission rates. 
-- Commission Calculation: For the first 3 trips of each driver, a standard commission rate of 24% is applied.
-- After the first 3 trips, the commission rate is determined based on the average rating of the driver's last 3 trips before the current trip:
-- If the average rating is between 4.7 and 5 (inclusive), the commission rate is 20%.
-- If the average rating is between 4.5 and 4.7 (inclusive), the commission rate is 23%.
-- For any other average rating, the default commission rate remains at 24%.

-- Write an SQL query to calculate the total earnings for each driver after deducting Uber's commission, considering the commission rates as per the given criteria, display the output in ascending order of driver id.
/*
Table: trips 
+-------------+--------------+
| COLUMN_NAME | DATA_TYPE    |
+-------------+--------------+
| trip_id     | int          |
| driver_id   | int          |
| fare        | int          |
| rating      | decimal(3,2) |
+-------------+--------------+
*/

with cte as
(select *,
row_number()over(partition by driver_id order by trip_id) as rn,
avg(rating)over(partition by driver_id order by trip_id rows between 3 preceding and 1 preceding) as avg_rating
from trips)
, cte2 as
(select driver_id, fare,
case when rn <= 3 or avg_rating <=4.5 then fare*0.24
when avg_rating <= 4.7 then fare*0.23
else fare*0.2 end as commission
from cte)

select driver_id, sum(fare-commission) as total_earnings
from cte2
group by driver_id
