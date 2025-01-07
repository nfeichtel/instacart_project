-- Comparing reorder rates between Q2 and Q3, segmented by aisle
-- Removed items in "missing" asile. Missing items make up less than % of total items

SELECT
    aisle,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change,
    ROUND(SUM(q2_reordered) / (SELECT SUM(q2_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')) * 100, 2) AS per_q2_reorders,
    ROUND(SUM(q3_reordered) / (SELECT SUM(q3_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')) * 100, 2) AS per_q3_reorders
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')
GROUP BY aisle
--ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
ORDER BY per_q2_reorders DESC