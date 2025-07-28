-- You are given two tables, sales_amount and exchange_rate. The sales_amount table contains sales transactions in various currencies, and the exchange_rate table provides the exchange rates for converting different currencies into USD, along with the dates when these rates became effective.
-- Your task is to write an SQL query that converts all sales amounts into USD using the most recent applicable exchange rate that was effective on or before the sale date. Then, calculate the total sales in USD for each sale date.
/*
Table: sales_amount  
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| sale_date   | int      |    
| sales_amount| int      |
| currency    | varchar  |
+-------------+----------+
Table: exchange_rate  
+-----------------+----------+
| COLUMN_NAME     | DATA_TYPE|
+---------------+------------+
| from_currency | varchar    |    
| to_currency   | varchar    |
| exchange_rate | decimal    |
| effective_date| date       |
+-------------+--------------+
*/

with cte as
(select s.sale_date, s.currency, s.sales_amount, e.exchange_rate,
row_number()over(partition by sale_date, currency order by effective_date desc) as rn
from sales_amount s
join exchange_rate e on
s.currency = e.from_currency and e.effective_date <= s.sale_date)

select sale_date, sum(sales_amount*exchange_rate) as amount
from cte
where rn = 1
group by sale_date

-- alternate solution

select s.sale_date, sum(s.sales_amount*e.exchange_rate) as total_sales_in_usd
from sales_amount s
join exchange_rate e on e.from_currency = s.currency
and e.effective_date = (select max(effective_date)
                        from exchange_rate
                        where from_currency = s.currency
                        and effective_date <= s.sale_date)
group by s.sale_date
order by s.sale_date
