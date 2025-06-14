-- Write a SQL query to identify the users with valid passwords according to the conditions below.
-- The password must be at least 8 characters long.
-- The password must contain at least one letter (lowercase or uppercase).
-- The password must contain at least one digit (0-9).
-- The password must contain at least one special character from the set @#$%^&*.
-- The password must not contain any spaces.
/*
Table: user_passwords 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| user_id     | int         |    
| user_name   | varchar(10) |
| password    | varchar(20) |
+-------------+-------------+
*/

select user_id, user_name
from user_passwords
where length(password) >= 8
and regexp_like (password,'[A-Za-z]')
and regexp_like (password,'[0-9]')
and regexp_like (password,'[@#$%^&*]')
and not regexp_like (password,' ')
