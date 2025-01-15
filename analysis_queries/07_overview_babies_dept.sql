-- Investigating the large percent decrease in baby department reorders
-- Babies: 98.5% of the decrease came from a drop in baby food formula reorders
-- Bulk:
-- Alcohol:
-- babies:

SELECT
    aisle,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies')
GROUP BY aisle
ORDER BY product_difference;

-- percent difference of negative products
WITH negative_babies AS
    (SELECT
        aisle,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS product_difference
    FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'babies')
    GROUP BY 
        aisle
    HAVING  SUM(q3_reordered) - SUM(q2_reordered) < 0
    ORDER BY product_difference)

SELECT
    aisle,
    product_difference,
    ROUND(product_difference / (SELECT SUM(product_difference) FROM negative_babies) * 100, 2) AS percent_of_decrease
FROM negative_babies;


