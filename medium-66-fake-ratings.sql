-- As an analyst at Amazon, you are responsible for ensuring the integrity of product ratings on the platform. Fake ratings can distort the perception of product quality and mislead customers. To maintain trust and reliability, you need to identify potential fake ratings that deviate significantly from the average ratings for each product.
-- Write an SQL query to identify the single rating that is farthest (in absolute value) from the average rating value for each product, display rating details in ascending order of rating id.
/*
Table : product_ratings
+-------------+--------------+
| COLUMN_NAME | DATA_TYPE    |
+-------------+--------------+
| rating_id   | int          |
| product_id  | int          |
| user_id     | int          |
| rating      | decimal(2,1) |
+-------------+--------------+
*/


with cte as
(select *, 
avg(rating)over(partition by product_id) as avg_rating
from product_ratings),
cte2 as 
(select *,
row_number()over(partition by product_id order by abs(rating-avg_rating) desc) as rnk 
from cte)

select rating_id, product_id, user_id, rating
from cte2
where rnk = 1

--
