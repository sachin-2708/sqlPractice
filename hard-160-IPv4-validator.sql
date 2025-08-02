/*
You are given a table logins containing IP addresses as plain text strings.
Each row represents an IP address from a user login attempt. Your task is to validate whether the IP address is a valid IPv4 address or not based on the following criteria:

1- The IP address must contain exactly 4 parts, separated by 3 dots (.).
2- Each part must consist of only numeric digits (no letters or special characters).
3- Each numeric part must be within the inclusive range of 0 to 255.
4- No part should contain leading zeros unless the value is exactly 0.

Table: logins
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| ip_address  | VARCHAR  |
+-------------+----------+
*/

SELECT 
  ip_address,
  CASE 
    WHEN 
      -- Condition 1: Must contain exactly 3 dots (i.e., 4 parts)
      LENGTH(ip_address) - LENGTH(REPLACE(ip_address, '.', '')) = 3
      AND 
      -- Split and validate each part: only digits
      SUBSTRING_INDEX(ip_address, '.', 1) REGEXP '^[0-9]+$'
      AND SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 2), '.', -1) REGEXP '^[0-9]+$'
      AND SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 3), '.', -1) REGEXP '^[0-9]+$'
      AND SUBSTRING_INDEX(ip_address, '.', -1) REGEXP '^[0-9]+$'
      AND
      -- Each part must be between 0 and 255
      CAST(SUBSTRING_INDEX(ip_address, '.', 1) AS UNSIGNED) BETWEEN 0 AND 255
      AND CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 2), '.', -1) AS UNSIGNED) BETWEEN 0 AND 255
      AND CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 3), '.', -1) AS UNSIGNED) BETWEEN 0 AND 255
      AND CAST(SUBSTRING_INDEX(ip_address, '.', -1) AS UNSIGNED) BETWEEN 0 AND 255
      AND
      -- No leading zeros (unless part is exactly '0')
      (
        SUBSTRING_INDEX(ip_address, '.', 1) = '0'
        OR SUBSTRING_INDEX(ip_address, '.', 1) NOT LIKE '0%'
      )
      AND (
        SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 2), '.', -1) = '0'
        OR SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 2), '.', -1) NOT LIKE '0%'
      )
      AND (
        SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 3), '.', -1) = '0'
        OR SUBSTRING_INDEX(SUBSTRING_INDEX(ip_address, '.', 3), '.', -1) NOT LIKE '0%'
      )
      AND (
        SUBSTRING_INDEX(ip_address, '.', -1) = '0'
        OR SUBSTRING_INDEX(ip_address, '.', -1) NOT LIKE '0%'
      )
    THEN '1'
    ELSE '0'
  END AS is_valid
FROM logins;
