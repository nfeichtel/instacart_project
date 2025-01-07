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
ORDER BY SUM(q3_reordered) - SUM(q2_reordered) DESC

-- a lot of large reorder differences are organic products. Was there an increase in price that led to this drop off?
-- Look to see if any products containing "organic" had a positive difference