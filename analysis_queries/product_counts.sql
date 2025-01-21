
WITH organic_count AS
    (SELECT 
        department,
        ROUND(COUNT(product_name), 0) AS organic_count
    FROM (SELECT * FROM total_reorders_augmented WHERE product_name ILIKE '%organic%')
    GROUP BY department),

    non_organic_count AS
    (SELECT 
        department,
        ROUND(COUNT(product_name), 0) AS non_organic_count
    FROM (SELECT * FROM total_reorders_augmented WHERE product_name NOT ILIKE '%organic%')
    GROUP BY department),

    total_count AS
    (SELECT 
        department,
        ROUND(COUNT(product_name), 0) AS total_count
    FROM (SELECT * FROM total_reorders_augmented)
    GROUP BY department)

SELECT
    tc.department,
    total_count,
    non_organic_count,
    ROUND(non_organic_count/total_count * 100, 2) AS percent_products_non_organic,
    organic_count,
    ROUND(organic_count/total_count * 100, 2) AS percent_products_organic
FROM total_count tc
JOIN non_organic_count nc
    ON tc.department = nc.department
JOIN organic_count oc
    ON tc.department = oc.department
ORDER BY percent_products_organic DESC