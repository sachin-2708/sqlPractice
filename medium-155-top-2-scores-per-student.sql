-- You are given a table Students that stores each student's subject-wise marks. Your task is to calculate the total marks of the top-performing subjects for each student (sname), considering ties in marks.
-- A subject is considered a top-performing subject if its marks are among the top two distinct marks for that student. If multiple subjects share the same marks, they should all be included if their marks fall within the top two distinct values.
-- Return each student's name and the total marks of these top-performing subjects. order by student name.
/*
Table: scores
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| student_name | VARCHAR  | 
| subject_name | VARCHAR  |
| marks        | INT      | 
+-------------------------+
*/

with ranking as
(select student_name, subject_name, marks,
dense_rank()over(partition by student_name order by marks desc) as rn
from students)

select student_name, sum(marks) as total_top_marks
from ranking
where rn < 3
group by student_name
order by student_name
