-- You are given a table named assessments that contains information about candidate evaluations for various technical tasks. Each row in the table represents a candidate and includes their years of experience, along with scores for three different tasks: SQL, Algorithms, and Bug Fixing. A NULL value in any of the task columns indicates that the candidate was not required to solve that specific task.
-- Your task is to analyze this data and determine, for each experience level, the total number of candidates and how many of them achieved a "perfect score." A candidate is considered to have achieved a "perfect score" if they score 100 in every task they were requested to solve.
-- The output should include the experience level, the total number of candidates for each level, and the count of candidates who achieved a "perfect score." The result should be ordered by experience level.
/*
Table: assessments 
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| candidate_id | int      |
| experience   | int      |
| sql_score    | int      |
| algo         | int      |
| bug_fixing   | int      |
+--------------+----------+
*/

select 
  experience, 
  count(*) as total_condidates,
  sum(case when (sql_score = 100 or sql_score is null) 
  and (algo = 100 or algo is null)
  and (bug_fixing = 100 or bug_fixing is null)
  then 1 else 0 end) as perfect_score_candidates
from assessments
group by experience
order by experience

-- Alternate Solution

select 
  experience, 
  count(*) as total_condidates,
  sum(case when 
          (case when sql_score = 100 or sql_score is null then 1 else 0 end 
          + case when algo = 100 or algo is null then 1 else 0 end 
          + case when bug_fixing = 100 or bug_fixing is null then 1 else 0 end)=3 
          then 1 else 0 end) 
  as perfect_score_candidates
from assessments
group by experience
order by experience
