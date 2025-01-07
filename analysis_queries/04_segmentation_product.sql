SELECT
    product_name,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change,
    ROUND(SUM(q2_reordered) / (SELECT SUM(q2_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')) * 100, 2) AS per_q2_reorders,
    ROUND(SUM(q3_reordered) / (SELECT SUM(q3_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')) * 100, 2) AS per_q3_reorders
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department != 'missing')
GROUP BY product_name
HAVING SUM(q2_reordered) != 0
ORDER BY per_q2_reorders DESC

-- a lot of large reorder differences are organic products. Was there an increase in price that led to this drop off?
-- Look to see if any products containing "organic" had a positive difference
-- 17 of 20 top reordered products are produce
-- 15 of top 20 products are organic
-- some of the hass avocado sales could have gone to the regular avocado sales