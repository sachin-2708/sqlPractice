-- In a content platform, users (viewers) can read various articles, and each article may be written by one or more authors (co-authors). The platform tracks which articles a viewer reads on each date, and also maintains information about which authors contributed to which articles.
-- You are tasked with identifying the dates on which a viewer read multiple different articles, and those articles were authored by more than one distinct author. Note that an article can be co-authored by multiple authors.
-- Return all (viewer_id, view_date) pairs where the viewer read **more than one unique article** on the same date, and those articles were written by **at least two different authors**. Sort the result by both columns respectively. 
/*
Table: articles
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| article_id   | INT      |
| author_id    | INT      | 
+-------------------------+
Table: views
+--------------+----------+
| COLUMN_NAME  | DATA_TYPE|
+--------------+----------+
| viewer_id    | INT      | 
| view_date    | date     |
| article_id   | INT      | 
+-------------------------+
*/

select v.viewer_id, v.view_date
from views v
join articles a on v.article_id = a.article_id
group by viewer_id, view_date
having count(distinct v.article_id) > 1 
and count(distinct a.author_id) > 1
