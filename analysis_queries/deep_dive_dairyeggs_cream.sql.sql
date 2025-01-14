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
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'cream')
GROUP BY aisle, product_name
ORDER BY product_difference;

-- percent difference of negative products
WITH negative_cream AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'cream')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    product_name,
    product_difference,
    ROUND(product_difference / (SELECT SUM(product_difference) FROM negative_cream) * 100, 2)
FROM negative_cream;


-- organic analysis
-- only 4 negative organic cream products
WITH negative_cream AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'cream')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference),

    organic_cream AS
    (SELECT
        aisle,
        product_name,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'dairy eggs' AND aisle = 'cream' AND product_name ILIKE '%organic%')
    GROUP BY 
        aisle, 
        product_name
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

    
  

    SELECT
        aisle,
        (SELECT SUM(product_difference) FROM organic_cream) /  (SELECT SUM(product_difference) FROM negative_cream)
    FROM negative_cream
    GROUP BY aisle