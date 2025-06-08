-- In the realm of global indicators and country-level assessments, it's imperative to identify the years in which certain indicators hit their lowest values for each country. Leveraging a dataset provided by government, which contains indicators across multiple years for various countries, your task is to formulate an SQL query to find the following information:
-- For each country and indicator combination, determine the year in which the indicator value was lowest, along with the corresponding indicator value. Sort the output by country name and indicator name.
/*
Table: country_data 
+----------------+--------------+
| COLUMN_NAME    | DATA_TYPE    |
+----------------+--------------+
| country_name   | varchar(15)  |
| indicator_name | varchar(25)  |
| year_2010      | decimal(3,2) |
| year_2011      | decimal(3,2) |
| year_2012      | decimal(3,2) |
| year_2013      | decimal(3,2) |
| year_2014      | decimal(3,2) |
+----------------+--------------+
*/

with cte as 
(select country_name, indicator_name, year_2010 as indicator_value, 2010 as year_number 
from country_data
union all
select country_name, indicator_name, year_2011 as indicator_value, 2011 as year_number 
from country_data
union all
select country_name, indicator_name, year_2012 as indicator_value, 2012 as year_number 
from country_data
union all
select country_name, indicator_name, year_2013 as indicator_value, 2013 as year_number 
from country_data
union all
select country_name, indicator_name, year_2014 as indicator_value, 2014 as year_number 
from country_data)
,
rnking as(
select country_name, indicator_name, indicator_value, year_number,
row_number()over(partition by country_name, indicator_name order by indicator_value) as rnk
from cte)

select country_name, indicator_name, indicator_value, year_number
from rnking
where rnk = 1
