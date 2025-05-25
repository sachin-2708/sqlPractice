-- Given two tables: income_tax_dates and users, write a query to identify users who either filed their income tax returns late or completely skipped filing for certain financial years.

-- A return is considered late if the return_file_date is after the file_due_date.
-- A return is considered missed if there is no entry for the user in the users table for a given financial year (i.e., the user did not file at all).
-- Your task is to generate a list of users along with the financial year for which they either filed late or missed filing, and also include a comment column specifying whether it is a 'late return' or 'missed'. The result should be sorted by financial year in ascending order.

-- Table: income_tax_dates
+-----------------+------------+
| COLUMN_NAME     | DATA_TYPE  |
+-----------------+------------+
| financial_year  | varchar(4) |
| file_start_date | date       |
| file_due_date   | date       |
+-----------------+------------+
-- Table: users
+------------------+------------+
| COLUMN_NAME      | DATA_TYPE  |
+------------------+------------+
| user_id          | int        |
| financial_year   | varchar(4) |
| return_file_date | date       |
+------------------+------------+

WITH all_user_years AS
(SELECT u.user_id, i.financial_year, i.file_due_date 
FROM users u
CROSS JOIN income_tax_dates i
GROUP BY u.user_id, i.financial_year, i.file_due_date)

SELECT a.user_id, a.financial_year,
CASE WHEN u.return_file_date > a.file_due_date THEN 'late return' ELSE 'missed' END AS comment
FROM all_user_years a
LEFT JOIN users u on a.user_id = u.user_id
AND a.financial_year = u.financial_year
WHERE return_file_date is null
OR u.return_file_date > a.file_due_date
ORDER BY a.financial_year

