SELECT
    ROUND(COUNT(product_name), 2) AS organic_products_offered,
    ROUND((SELECT COUNT(product_name) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')), 2) - ROUND(COUNT(product_name), 2) AS non_organic_products_offered,
    ROUND((SELECT COUNT(product_name) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')), 2) AS total_products_offered,
    ROUND(ROUND(COUNT(product_name), 2) / ROUND((SELECT COUNT(product_name) FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')), 2) * 100, 2) AS percent_organic_products_offered
FROM (SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')
WHERE product_name ILIKE '%organic%';