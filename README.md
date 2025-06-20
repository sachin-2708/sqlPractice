# sqlPractice

# NamasteSQL Practice Solutions

This repo contains my SQL solutions from NamasteSQL challenges.  
I am solving problems of various difficulty levels to improve my data querying skills and build a strong portfolio.

## My Goals
- Master advanced SQL queries
- Understand real-world business case studies
- Prepare for SQL interviews

## Progress Tracker

| Problem Name          | Difficulty | Status    | Notes                          |
|-----------------------|------------|-----------|--------------------------------|
| [LinkedIn Top Voice](https://github.com/sachin-2708/sqlPractice/blob/main/medium-3-linkedIn-top-voice-Q3.sql)    | Medium     | Completed | Learned to use DATE_FORMAT, Year and Month functions |
| [Electricity Consumption](https://github.com/sachin-2708/sqlPractice/blob/main/easy-06-electricity-consumption.sql)    | Easy     | Completed | Practised Agg functions SUM and AVG and string function LEFT |
| [Math Champion](https://github.com/sachin-2708/sqlPractice/blob/main/easy-11-math-champion.sql)| Easy     | Completed | Used Subquery to find overall Avg value to use in the main query |
| [Deliveroo Top Customer](https://github.com/sachin-2708/sqlPractice/blob/main/easy-12-deliveroo-top-customer.sql)    | Easy     | Completed | Revised Order By and Limit functions |
| [Employee Salary Levels](https://github.com/sachin-2708/sqlPractice/blob/main/easy-30-employee-salary-levels.sql) | Easy     | Completed | Learned to use CTE, CASE WHEN statements and AVG and GROUP BY functions |
| [Income Tax Returns](https://github.com/sachin-2708/sqlPractice/blob/main/medium-27-income-tax-returns.sql) | Medium     | Completed | Used CTE and CROSS JOIN to identify missed return and Used Case When condition with operators and applied Multiple ON conditions to join the CTE to main table |
| [Software vs Data Analytics Engineers](https://github.com/sachin-2708/sqlPractice/blob/main/medium-29-software-vs-data-analytics-engineers.sql) | Medium     | Completed | Practised SUM and CASE WHEN statements with wildcard |
| Malware Detection | Hard     | Completed | Learned ROW_NUMBER, LEAD and COUNT window functions, used it in CTE to query data based on the given conditions |
| [Warikoo 20-6-20](https://github.com/sachin-2708/sqlPractice/blob/main/medium-32-warikoo-20-6-20.sql) | Medium     | Completed | Practised Cross Join and Group Concat function and employed arthimetic logics |
| [Average Order Value](https://github.com/sachin-2708/sqlPractice/blob/main/medium-33-average-order-value.sql) | Medium     | Completed | Used ROW_NUMBER AND MAX() OVER() functions to find difference of min and max avg values |
| [Employee vs Manager](https://github.com/sachin-2708/sqlPractice/blob/main/medium-34-employee-vs-manager.sql) | Medium     | Completed | Practised Self Join which is critical if you only have one table for analysis |
| Cancellation vs Return | Hard     | Completed | CTE & CASE WHEN THEN statement utilised. Understood concept of order returned and no returned, cancelled and not cancelled |
| GAP Sales | Easy     | Completed | Practised Group By 2 columns and sum |
| Walmart Sales Pattern | Hard     | Completed | Used multiple CTEs to come up with the solution; incorporated RANK window function in first CTE and then CASE WHEN, MAX function in the next CTE |
| Zomato Customer Behavior | Hard     | Completed | Used multiple CTEs, DAYOFWEEK, CASE WHEN and SUM, AVG functions to come up with solution |
| Electronics Items Sale | Easy     | Completed | Practiced multiple conditions in Having clause after using AVG aggregation |
| [AirBnB Business](https://github.com/sachin-2708/sqlPractice/blob/main/medium-36-airbnb-business.sql) | Medium     | Completed | Used 3 CTEs and RANK windows function to come up with the AVG occupancy rate of rooms |
| Domain Names | Easy     | Completed | Practised the Substring_Index string function to get the domain name after @ |
| Subject Average Score | Easy     | Completed | Tricky Question -- Required Sub-query, used DISTINCT function and HAVING |
| [Spotify Popular Tracks](https://github.com/sachin-2708/sqlPractice/blob/main/medium-37-spotify-popular-tracks.sql) | Medium     | Completed | Used COUNT DISTINCT in CTE as well as in the Main Query to filter the accurate data and used Limit to get top 2 entries. Alternatively a subquery can also be used. |
| [Uber Driver Ratings](https://github.com/sachin-2708/sqlPractice/blob/main/medium-40-uber-driver-ratings.sql) | Medium     | Completed | Used NTILE() window function to divide the data into a group based on performance parameters |
| [Excess/insufficient Inventory](https://github.com/sachin-2708/sqlPractice/blob/main/medium-44-excess-insufficient-inventory.sql) | Medium     | Completed | Learnt Union function, CHAR function and hard-coding value into a row when you want overall value |
| [Zomato Membership](https://github.com/sachin-2708/sqlPractice/blob/main/medium-45-zomato-membership.sql) | Medium     | Completed | Used a subquery in a CTE and joined multiple CTEs to come at a solution -- With two Alternate Solution, one using CASE WHEN and another using ROW_NUMBER window function |
| [Female Contribution](https://github.com/sachin-2708/sqlPractice/blob/main/medium-48-female-contribution.sql) | Medium     | Completed | Practiced CTE with SUM and CASE WHEN statements |
| [Premium Customers](https://github.com/sachin-2708/sqlPractice/blob/main/medium-4-premium-customers.sql) | Medium     | Completed | Used sub_query in Having clause to filter data; alternatively used CTE and AVG window function to compare values |
| CIBIL Score | Hard     | Completed | Used UNION to combine Loan and Credit tables, hard coded values. Used 3 CTEs to arrive at the solution. |
| [Airbnb Top Hosts](https://github.com/sachin-2708/sqlPractice/blob/main/medium-7-airbnb-top-hosts.sql) | Medium   | Completed | Simple solution using Count Distinct and Having condition, alternatively used Count windows function in CTE to filter the data in the main query. |
| [Best Employee Award](https://github.com/sachin-2708/sqlPractice/blob/main/medium-13-best-employee-award.sql) | Medium   | Completed | Used 2 CTEs and understood the logic for ranking from the hint |
| [Business Expansion](https://github.com/sachin-2708/sqlPractice/blob/main/medium-17-business-expansion.sql) | Medium   | Completed | Practised Min function to find the 1st date and then used it as CTE |
| [Hero Products](https://github.com/sachin-2708/sqlPractice/blob/main/medium-18-hero-products.sql) | Medium   | Completed | Used two order by conditions in the row number window function to identify product and category |
| [Account Balance](https://github.com/sachin-2708/sqlPractice/blob/main/medium-24-account-balance.sql) | Medium   | Completed | Union to join same table with transactions credited and debited and then use it in CTE to find the final balance. |
| [Adverse Reactions](https://github.com/sachin-2708/sqlPractice/blob/main/medium-50-adverse-reactions.sql) | Medium   | Completed | Two approaches used, first using CTE to filter data while second was just using left join to multiple on condition |
| [Balanced Team](https://github.com/sachin-2708/sqlPractice/blob/main/medium-51-balanced-team.sql) | Medium   | Completed | Using Sum Windows function, calculated running total and then using that CTE, first identified Seniors and then using Union All Juniors and Seniors were added to it. |
| [Loan Repayment](https://github.com/sachin-2708/sqlPractice/blob/main/medium-52-loan-repayment.sql) | Medium   | Completed | Using Max and Sum in CTE to calculate the repayment amount and last date, joined to the main table. Alternatively, used case when statement in another case when statement for calculations  |
| [Employees Payout](https://github.com/sachin-2708/sqlPractice/blob/main/medium-54-employees-payout.sql) | Medium   | Completed | JOIN, CTE and CASE WHEN statements used to get the solution |
| [Expenses Excluding MasterCard](https://github.com/sachin-2708/sqlPractice/blob/main/medium-56-expenses-excluding-masterCard.sql) | Medium   | Completed | Created two CTEs to seperate the expenses and then joined the two CTEs to find the final result |
| Order Lead Time | Medium   | Completed | Learnt Date_add, datediff functions to calculate revised dates, using them in CTEs to find final solution. Learnt to join table using between dates. Alternate solution is to calculate the days between revised order and ship dates and subtract the holidays between them. |
| Instagram Marketing Agency | Medium   | Completed | Simple CASE WHEN and AVG funnction used to calculate the output |
| Fake Ratings | Medium   | Completed | Employed AVG Windor funnction to get average in a column to subtract from the main value and then ranked using ROW_NUMBER to get the solution |
| Food Preparation Time | Medium   | Completed | Learnt the TIMESTAMPDIFF and MINUTE function to calculate the avg food prep time. |
| Late Food Deliveries | Medium   | Completed | Tricky Question, had to find order which were delayed due to riders but calculation on time prepared orders. |
| Country Indicators | Medium   | Completed | UNION ALL to flatten the table by shifting multiple years columns only one column and then using ROW_NUMBERS partitioned by country and indicator to get the ranks necessary for the solution. |
| 2022 vs 2023 vs 2024 Sales | Medium   | Completed | Using case when statements, the years wise data was brought into columns and then compared |
| Hotel Booking Mistake | Medium   | Completed | Flattening the tables by joining the Date Dimension table to the main table, and grouping the number of bookings for the customers for the same room, using Group_Concat to get the comma seperated list of affected customers  |
| Child and Parents | Medium   | Completed | Joined the same table two times with conditions to get mother and father assigned to child ID. Used SQL trick to aggregate child_id column to avoid NULL values on mother and father columns |
| Netflix Device Type (PART-1) | Medium   | Completed | Used COUNT window function to get the device count and then did sum for aggregation. Alternative solution was to use Case When statement|
| Netflix Device Type (PART-2) | Medium   | Completed | Grouped the counting by user_id and title to get the number of times the title was watched and then used case when to identify multiple device viewed and single device viewed cases  |
| Election Winner | Medium   | Completed | Various alternate solutions, important was two tables can also be joined using a comma in the Where Clause itself. Cross join can also be used if only one row table is to be joined to another table |
| OTT Viewership | Medium   | Completed | Sum the duration and Rank the top two shows in each genre. Practiced CTEs |
| Busiest Airline Route | Medium   | Completed | Used Case When to update values for Return flight tickets. Alternatively, origin and destination columns can be interchanged when it is a return flight and then the busiest route can be found. |
| Credit Card Transactions (Part-2) | Medium   | Completed | Ranked using Window Function the highest and lowest amount credit cards, then using this in CTE, used Max to aggregate the data where we get 0 or null in the case when statements to collapse the entire columns into group of cities |
| Loyal Customers | Medium   | Completed | Count Distinct products in orders table should be equal to count of products in products table to identify the customers who purchased all products and then putting them in Having statement |
| Users With Valid Passwords | Medium   | Completed | Learnt a new function REGEXP_LIKE and [] array to identify the characters in that array; REGEXP can also be used here |
| Student Major Subject | Medium   | Completed | Used a subquery to identify students with 1 subject and used it in where clause with OR to get them with students with more than 1 subject; Can also use alternate solution to rank the cases based on flags Y or N using the Case When statement by assigning flag values 1 and 0 |
| boAt Lifestyle Marketing | Medium   | Completed | Created multiple CTEs based on the required conditions and then joined them; used two alternate solutions |
| Products Sold in All Cities | Medium   | Completed | Find the product and city combination and then compare it to the number of cities in the city table. |
| Top 5 Single-Purchase Spendings | Medium   | Completed | Simple solution using Max aggregation at customer level and then limiting it to top 5 rows; Alternately Rank window function was also used to identify purchases at customer level and ordering it at the main level. |
| Reel Daily View Averages by State | Medium   | Completed | Used Max to find the highest cumulative views and then divided it by the no of days to find the avg daily views  |
| Goals Scored in Each Game | Medium   | Completed | Joined the games and goals table and then used it in CTE; from this CTE, used Case When statement to sum the teams 1 and 2 goals scored.  |
| COVID Risk by Age | Medium   | Completed | Created age groups using the Case When statement, and then summed the cases based on severity criteria  |
| Recurring Monthly Customers | Medium   | Completed | Used Count and Count Distinct in the Having clause to filter data and get the correct solution |
| Third Highest Salary | Medium   | Completed | Used Rank function in the CTE to get the 3rd ranking salary dept wise and then left joined cte to the main table and on condition having rank = 3; alternative solution - Using Case when rnk = 3 else null, we aggregate the data at departments using max and get the solution. |
| Top 3 Netflix Shows | Medium   | Completed | Using Sum and Count Distinct for watch time and unique users, used rank function in CTE to identify top 3 users |
| Employees Status Change(Part-1) | Medium   | Completed | Left Joininig both tables to each other 2 times by interchanging each other, we get details for new hire as well as resigned cases by using Union and then using it in CTE to fine solution based on the conditions. |
| Employees Status Change(Part-2) | Medium   | Completed | Similar to part1 with only one table, Used LEAD, LAG, and CTEs to identify employee promotion, resignation, and new hires based on year-wise designation changes. |
| Projects Source System | Medium   | Completed | Used Case When statement in the Order By of Window Function to rank the data based on the conditions and used it in CTE to get the rn = 1 results |
| Music Lovers | Medium   | Completed | Using Distinct Count to count the distinct number of days for login and then comparing it with the difference in days between user's first login and current date using CURDATE() to identify daily logins |
| Myntra Campaign Effectiveness | Medium   | Completed | Used logic to find the last month and 3rd month from current date to identify customers in the previous 3 months excluding current month; Alternate solution is to use Date_sub and Date_format to compare dates with start of current month using curdate(), %Y-%m-01 |
| Customer Data Cleaning | Medium   | Completed | Trim, lower, coalesce and regex_replace(phone,[^0-9],'') used to clean the data and row number used to identify the duplicate entries  |
| Frequent Flyers | Medium   | Completed | Used inner join to join two tables and used date_sub and curdate() to put 1 year condition and then counted th combination of passenger id and airport and filter 5 or more flights from same airport using having   |
| SQL Champions | Medium   | Completed | Used Subquery to identify users who don't have SQL skills and then main query identified students not in sub query; alternately, count window function can be used to identify only one skill that is SQL. |
| Individual Contributors | Medium   | Completed | Found the unique manager ids and then compared it with employee ids to identify employees who are not managers yet; Alternatively, we can use left join distinct manager ID to main table and then identify the null values |
| Employees Not Promoted | Medium   | Completed | Identify the max promotion date for all the employees and then filter it further by putting the condition that max promotion date is before 1 year from today; alternate solution is to identify the emp promoted in last year and joining them to employee table and then again joining them to employee table |
| Active Viewers by Day | Medium   | Completed | Join the two tables and then for viewer_id and view_date combination count distinct authors and articles |
| Grand Slam Titles | Medium   | Completed | Flatten the championships table using union all and then join it with players and then aggregate it using count |
| Top 2 Scores per Student | Medium   | Completed | Using Dense Rank, order the data for students and then sum the top 2 marks for each students |
| Sequence Expansion | Medium   | Completed | Practised Recursive CTE |
| [New and Repeat Customers](https://github.com/sachin-2708/sqlPractice/blob/main/hard-9-new-and-repeat-customers-Q3.sql) | Hard   | Completed | Identifying the 1st order of customers in cte and then joining it to the main table to compare first order and repeat order in case when statements |

