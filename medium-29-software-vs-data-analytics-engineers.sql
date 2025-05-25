-- You are given the details of employees of a new startup. Write an SQL query to retrieve number of Software Engineers , Data Professionals and Managers in the team to separate columns. Below are the rules to identify them using Job Title. 
-- 1- Software Engineers  :  The title should starts with “Software”
-- 2- Data Professionals :  The title should starts with “Data”
-- 3- Managers : The title should contain "Managers"
-- Tables: Employees
/*
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| EmployeeID  | int         |
| Name        | varchar(20) |
| JoinDate    | date        |
| JobTitle    | varchar(20) |
+-------------+-------------+
*/

SELECT  
SUM(CASE 
      WHEN jobtitle LIKE 'Software%' THEN 1 END) AS Software_Engineers,
SUM(CASE 
      WHEN jobtitle LIKE 'Data%' THEN 1 END) AS Data_Professionals,
SUM(CASE 
      WHEN jobtitle LIKE '%Manager%' THEN 1 END) as Managers
FROM employees; 





