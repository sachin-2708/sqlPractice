-- Write an SQL to get the date of the last Sunday as per today's date. 
-- If you are solving the problem on Sunday then it should still return the date of last Sunday (not current date).
-- Note : Dates are displayed as per UTC time zone.


select date_sub(current_date(), interval (weekday(current_date())+1) day) as last_sunday
-- Alternate Solution
select date_sub(date(now()), interval case when dayofweek(now()) = 1 then 7 else dayofweek(now())-1 end day) as last_sunday
