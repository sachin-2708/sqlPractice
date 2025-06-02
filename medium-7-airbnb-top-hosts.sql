-- Suppose you are a data analyst working for a travel company that offers vacation rentals similar to Airbnb. Your company wants to identify the top hosts with the highest average ratings for their listings. This information will be used to recognize exceptional hosts and potentially offer them incentives to continue providing outstanding service.
-- Your task is to write an SQL query to find the top 2 hosts with the highest average ratings for their listings. However, you should only consider hosts who have at least 2 listings, as hosts with fewer listings may not be representative.
-- Display output in descending order of average ratings and round the average ratings to 2 decimal places.

/*Table: listings
+----------------+---------------+
| COLUMN_NAME    | DATA_TYPE     |
+----------------+---------------+
| host_id        | int           |
| listing_id     | int           |
| minimum_nights | int           |
| neighborhood   | varchar(20)   |
| price          | decimal(10,2) |
| room_type      | varchar(20)   |
+----------------+---------------+
Table: reviews
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| listing_id  | int       |
| rating      | int       |
| review_date | date      |
| review_id   | int       |
+-------------+-----------+
*/



select host_id, count(distinct r.listing_id) as no_of_listings, round(avg(rating),2) as avg_rating
from reviews r
join listings l on l.listing_id = r.listing_id
group by host_id
having count(distinct r.listing_id)>=2
order by avg_rating desc
limit 2

-- Alternate Solution

with cte as
(select host_id, listing_id,
count(*)over(partition by host_id) as no_of_listings
from listings)

select host_id, no_of_listings, round(avg(rating),2) as avg_rating
from cte
inner join reviews r on r.listing_id = cte.listing_id
where no_of_listings > 1
group by host_id
order by avg_rating desc
limit 2
