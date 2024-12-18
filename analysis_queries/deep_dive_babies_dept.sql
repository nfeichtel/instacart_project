-- Investigating the large percent decrease in baby department reorders
-- 98.5% of the decrease came from a drop in baby food formula reorders

SELECT
    aisle,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies' )
GROUP BY aisle
ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)