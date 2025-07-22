-- You're working for a retail company that sells various products. The company wants to identify seasonal trends in sales for its top-selling products across different regions. They are particularly interested in understanding the variation in sales volume across seasons for these products.
-- For each top-selling product in each region, calculate the total quantity sold for each season (spring, summer, autumn, winter) in 2023, display the output in ascending order of region name, product name & season name.
/*
Table: products
+--------------+-------------+
| COLUMN_NAME  | DATA_TYPE   |
+--------------+-------------+
| product_id   | int         |
| product_name | varchar(10) |
+--------------+-------------+
Table: sales
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| sale_id       | int         |
| product_id    | int         |
| region_name   | varchar(20) |
| sale_date     | date        |
| quantity_sold | int         |
+---------------+-------------+
Table: seasons
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| start_date  | date        |
| end_date    | date        |
| season_name | varchar(10) |
+-------------+-------------+
*/


with top_products as
(select s.product_id, s.region_name, p.product_name,
dense_rank()over(partition by region_name order by sum(s.quantity_sold) desc) as rn
from sales s
join products p on p.product_id=s.product_id
group by s.product_id, s.region_name, p.product_name)

select tp.region_name, tp.product_name, s1.season_name, sum(s.quantity_sold) as total_quantity_sold
from top_products tp
join sales s on s.product_id = tp.product_id
join seasons s1 on s.sale_date between s1.start_date and s1.end_date
where rn = 1
group by tp.region_name, tp.product_name, s1.season_name
order by tp.region_name, tp.product_name, s1.season_name
