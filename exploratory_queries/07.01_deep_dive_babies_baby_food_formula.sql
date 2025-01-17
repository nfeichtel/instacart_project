

SELECT
    aisle,
    product_name,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies' AND aisle = 'baby food formula')
GROUP BY aisle, product_name
ORDER BY product_difference;

-- percent difference of negative products
WITH negative_babyfoodformula AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies' AND aisle = 'baby food formula')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    product_name,
    product_difference,
    ROUND(product_difference / (SELECT SUM(product_difference) FROM negative_babyfoodformula) * 100, 2)
FROM negative_babyfoodformula;


-- organic analysis

WITH negative_babyfoodformula AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies' AND aisle = 'baby food formula')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference),

    organic_babyfoodformula AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies' AND aisle = 'baby food formula' AND product_name ILIKE '%organic%')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    ROUND((SELECT SUM(product_difference) FROM organic_babyfoodformula) / (SELECT SUM(product_difference) FROM negative_babyfoodformula) * 100, 2) AS percent_organic
FROM negative_babyfoodformula
GROUP BY aisle