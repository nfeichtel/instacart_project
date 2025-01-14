-- Investigating the large percent decrease in baby department reorders
-- Babies: 98.5% of the decrease came from a drop in baby food formula reorders
-- Bulk:
-- Alcohol:
-- Dairy eggs:

SELECT
    aisle,
    product_name,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS product_difference


-- Filter for desired department in the line below
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'cream')
GROUP BY aisle, product_name
ORDER BY product_difference 