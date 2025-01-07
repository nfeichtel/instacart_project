-- Comparing reorder rates between Q2 and Q3, segmented by aisle
-- Removed items in "missing" asile. Missing items make up less than % of total items

SELECT
    aisle,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')
GROUP BY aisle
ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)