/* You are working with a large dataset of out-of-stock (OOS) events for products across multiple marketplaces.Each record in the dataset represents an OOS event for a specific product (MASTER_ID) in a specific marketplace (MARKETPLACE_ID) on a specific date (OOS_DATE). The combination of (MASTER_ID, MARKETPLACE_ID, OOS_DATE) is always unique. Your task is to identify key OOS event dates for each product and marketplace combination.
Steps to identify key OOS events :
Identify the earliest OOS event for each (MASTER_ID, MARKETPLACE_ID).
Recursively find the next OOS event that occurs at least 7 days after the previous event.
Continue this process until no more OOS events meet the condition.

Table: DETAILED_OOS_EVENTS
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| MASTER_ID     | VARCHAR  |
| MARKETPLACE_ID| INTEGER  | 
| OOS_DATE      | DATE     | 
+---------------+----------+
Order the result by MASTER_ID, MARKETPLACE_ID, OOS_DATE
*/

WITH RECURSIVE oos_ordered AS (
    -- Step 1: sort events per product+marketplace
    SELECT 
        MASTER_ID,
        MARKETPLACE_ID,
        OOS_DATE,
        ROW_NUMBER() OVER (PARTITION BY MASTER_ID, MARKETPLACE_ID ORDER BY OOS_DATE) AS rn
    FROM DETAILED_OOS_EVENTS
),

oos_chain AS (
    -- Anchor: earliest event in each group
    SELECT 
        MASTER_ID,
        MARKETPLACE_ID,
        OOS_DATE,
        rn
    FROM oos_ordered
    WHERE rn = 1

    UNION ALL

    -- Recursive: next event >= 7 days after the last kept one
    SELECT 
        nxt.MASTER_ID,
        nxt.MARKETPLACE_ID,
        nxt.OOS_DATE,
        nxt.rn
    FROM oos_chain AS prev
    JOIN oos_ordered AS nxt
      ON nxt.MASTER_ID = prev.MASTER_ID
     AND nxt.MARKETPLACE_ID = prev.MARKETPLACE_ID
     AND nxt.rn = (
           SELECT MIN(rn)
           FROM oos_ordered
           WHERE MASTER_ID = prev.MASTER_ID
             AND MARKETPLACE_ID = prev.MARKETPLACE_ID
             AND OOS_DATE >= DATE_ADD(prev.OOS_DATE, INTERVAL 7 DAY)
             AND rn > prev.rn
       )
)

-- Final output
SELECT MASTER_ID, MARKETPLACE_ID, OOS_DATE
FROM oos_chain
ORDER BY MASTER_ID, MARKETPLACE_ID, OOS_DATE;
