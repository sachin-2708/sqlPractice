-- Company X is analyzing Airbnb listings to help travelers find the most affordable yet well-equipped accommodations in various neighborhoods. Many users prefer to stay in entire homes or apartments instead of shared spaces and require essential amenities like TV and Internet for work or entertainment.
-- Your task is to find the cheapest Airbnb listing in each neighborhood that meets the following criteria:
-- .The property type must be either "Entire home" or "Apartment".
-- .The property must include both "TV" and "Internet" in its list of amenities.
-- .Among all qualifying properties in a neighborhood, return the one with the lowest nightly cost.
-- .If multiple properties have the same lowest cost, return the one with more number of amenities.
-- .The results(neighborhood, property_id, cost_per_night) should be sorted by neighborhood for better readability.
/*
Table: airbnb_listings
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| property_id   | int      |
| neighborhood  | VARCHAR  | 
| cost_per_night| int      | 
| room_type     | VARCHAR  | 
| amenities     | TEXT     | 
+---------------+----------+
*/

with filtered as
(select 
	property_id,
 	neighborhood, 
 	cost_per_night, 
 	room_type, 
 	amenities, 
 	length(amenities)-length(replace(amenities,';',''))+1 as amenities_cnt 
from airbnb_listings
where 
	room_type in ('Entire home','Apartment') 
 	and upper(amenities) like '%TV%' 
 	and upper(amenities) like '%INTERNET%')
, ranked_property as
(select *,
rank()over(partition by neighborhood order by cost_per_night asc, amenities_cnt desc) as rn
from filtered)

select neighborhood, property_id, cost_per_night
from ranked_property
where rn = 1
order by neighborhood
