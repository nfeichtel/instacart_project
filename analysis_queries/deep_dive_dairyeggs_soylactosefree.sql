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
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'soy lactosefree')
GROUP BY aisle, product_name
ORDER BY product_difference;

-- percent difference of negative products
WITH negative_soylactosefree AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'soy lactosefree')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    product_name,
    product_difference,
    ROUND(product_difference / (SELECT SUM(product_difference) FROM negative_soylactosefree) * 100, 2)
FROM negative_soylactosefree;


-- organic analysis
-- only 4 negative organic soy lactosefree products
WITH negative_soylactosefree AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'soy lactosefree')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference),

    organic_soylactosefree AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'soy lactosefree' AND product_name ILIKE '%organic%')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    ROUND((SELECT SUM(product_difference) FROM organic_soylactosefree) / (SELECT SUM(product_difference) FROM negative_soylactosefree) * 100, 2) AS percent_organic
FROM negative_soylactosefree
GROUP BY aisle