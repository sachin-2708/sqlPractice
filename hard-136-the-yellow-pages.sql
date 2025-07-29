/*To enhance the functionality of "The Yellow Pages" website, create a SQL query to generate a report of companies, including their phone numbers and ratings. The query must account for the following:
Columns in the output:
name: The company name as per below rules:
    For promoted companies:
        Format: [PROMOTED] <company_name>.
    For non-promoted companies:
        Format: <company_name>.
phone: The company phone number.
rating: The overall star rating of the company as per rules below:
    Promoted companies : should always have NULL as their rating.
    For non-promoted companies:
        Format: <#_stars> (<average_rating>, based on <total_reviews> reviews), where:
        <#_stars>: Rounded down average rating to the nearest whole number.
        <average_rating>: Exact average rating rounded to 1 decimal place.
        <total_reviews>: Total number of reviews across all categories for the company.
Rules: Non-promoted companies should only be included if their average rating is 1 star or higher.
Results should be sorted:
By promotion status (promoted first).
In descending order of the average rating (before rounding).
By the total number of reviews (descending).
Table: companies
+------------+----------+
| COLUMN_NAME| DATA_TYPE|
+------------+----------+
| id         | int      |
| name       | VARCHAR  | 
| phone      | VARCHAR  | 
| is_promoted| int      | 
+------------+----------+
Table: categories
+------------+----------+
| COLUMN_NAME| DATA_TYPE|
+------------+----------+
| company_id | int      |
| name       | VARCHAR  | 
| rating     | decimal  | 
+------------+----------+
*/

with ratings as
(select c.id, c.name, c.phone, c.is_promoted,
count(cat.rating) as total_reviews,
avg(rating) as avg_rating
from companies c
inner join categories cat on c.id = cat.company_id
group by c.id, c.name, c.phone, c.is_promoted)

select 
	case when is_promoted = 1 then concat('[PROMOTED] ',name)
    else name end as name,
	phone,
	case when is_promoted = 1 then NULL
    else concat(repeat('*',floor(avg_rating)), '(',round(avg_rating,1), ', based on ',total_reviews, 'reviews)')
    end as rating
from ratings
where is_promoted = 1 or avg_rating >= 1
order by is_promoted desc, avg_rating desc, total_reviews desc
