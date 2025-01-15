

SELECT
    aisle,
    product_name,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'snacks' AND aisle = 'energy granola bars')
GROUP BY aisle, product_name
ORDER BY product_difference;

-- percent difference of negative products
WITH negative_energygranolabars AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'snacks' AND aisle = 'energy granola bars')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    product_name,
    product_difference,
    ROUND(product_difference / (SELECT SUM(product_difference) FROM negative_energygranolabars) * 100, 2)
FROM negative_energygranolabars;


-- organic analysis

WITH negative_energygranolabars AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'snacks' AND aisle = 'energy granola bars')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference),

    organic_energygranolabars AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'snacks' AND aisle = 'energy granola bars' AND product_name ILIKE '%organic%')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    ROUND((SELECT SUM(product_difference) FROM organic_energygranolabars) / (SELECT SUM(product_difference) FROM negative_energygranolabars) * 100, 2) AS percent_organic
FROM negative_energygranolabars
GROUP BY aisle