-- You are planning to list a property on Airbnb. To maximize profits, you need to analyze the Airbnb data for the month of January 2023 to determine the best room type for each location. The best room type is based on the maximum average occupancy during the given month.

-- Write an SQL query to find the best room type for each location based on the average occupancy days. Order the results in descending order of average occupancy days, rounded to 2 decimal places.
/*Table: listings
+----------------+---------------+
| COLUMN_NAME    | DATA_TYPE     |
+----------------+---------------+
| listing_id     | int           |
| host_id        | int           |
| location       | varchar(20)   |
| room_type      | varchar(20)   |
| price          | decimal(10,2) |
| minimum_nights | int           |
+----------------+---------------+
Table: bookings
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| booking_id    | int       |
| checkin_date  | date      |
| checkout_date | date      |
| listing_id    | int       |
+---------------+-----------+
*/


WITH booked_days AS(
SELECT b.listing_id, b.checkin_date, b.checkout_date,
(b.checkout_date - b.checkin_date) AS booked_days
, l.location, l.room_type
FROM bookings b
JOIN listings l ON b.listing_id = l.listing_id
  )
,
total_booked AS (
SELECT listing_id, location, room_type, SUM(booked_days) AS total_booked_days
FROM booked_days
GROUP BY listing_id, location, room_type)
,
avg_booked AS (
SELECT location, room_type, ROUND(AVG(total_booked_days),2) AS avg_book_days,
RANK() OVER(PARTITION BY location ORDER BY AVG(total_booked_days) DESC) as rnk
FROM total_booked
GROUP BY location, room_type
)

SELECT location, room_type, avg_book_days
FROM avg_booked
WHERE rnk = 1
ORDER BY avg_book_days DESC
