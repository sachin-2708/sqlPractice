-- Suppose you are a data analyst working for Spotify (a music streaming service company). 
-- Your company is interested in analyzing user engagement with playlists and wants to identify the most popular tracks among all the playlists.
-- Write an SQL query to find the top 2 most popular tracks based on number of playlists they are part of. 
-- Your query should return the top 2 track ID along with total number of playlist they are part of , sorted by the same and  track id in descending order, 
-- Please consider only those playlists which were played by at least 2 distinct users.

/*Table: playlists
+---------------+--------------+
| COLUMN_NAME   | DATA_TYPE    |
+---------------+--------------+
| playlist_id   | int          |
| playlist_name | varchar(15) |
+---------------+--------------+
Table: playlist_tracks
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| playlist_id | int       |
| track_id    | int       |
+-------------+-----------+
Table: playlist_plays
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| playlist_id | int        |
| user_id     | varchar(2) |
+-------------+------------+*/


WITH unique_listners AS (
  SELECT playlist_id, COUNT(DISTINCT user_id) AS unique_listners
  FROM playlist_plays
  GROUP BY playlist_id)

SELECT pt.track_id, COUNT(DISTINCT pp.playlist_id) AS no_of_playlist 
FROM playlist_plays pp
JOIN playlist_tracks pt ON pt.playlist_id = pp.playlist_id
JOIN unique_listners u ON u.playlist_id = pp.playlist_id
WHERE unique_listners >= 2
GROUP BY pt.track_id
ORDER BY no_of_playlist DESC
LIMIT 2
