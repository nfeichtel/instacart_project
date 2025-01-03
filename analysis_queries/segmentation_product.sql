SELECT
    product_name,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department != 'missing')
GROUP BY product_name
HAVING SUM(q2_reordered) != 0
--ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
ORDER BY SUM(q2_reordered) DESC