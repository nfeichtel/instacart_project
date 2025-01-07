/*
SELECT
    COUNT(product_name) AS organic_products,
    (SELECT COUNT(product_name) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')) AS total_products
    -- add percent of products that are organic

FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')
WHERE product_name ILIKE '%organic%';
*/

WITH organic_department AS 
(
    SELECT
        department,
        SUM(q2_reordered) AS q2_organic,
        SUM(q3_reordered) AS q3_organic,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference_organic,
        ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change_organic
    FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name ILIKE '%organic%')
    GROUP BY department
    ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
),

total_department AS
(
    SELECT
        department,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference,
        ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change
    FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')
    GROUP BY department
    ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
)

SELECT
td.department,
q2,
q2_organic,
q3,
q3_organic,
difference,
difference_organic
FROM organic_department AS od
JOIN total_department AS td
ON od.department = td.department
ORDER BY difference_organic