
WITH organic_aisle AS
    (SELECT
        aisle AS aisle_organic,
        SUM(q2_reordered) AS q2_organic,
        SUM(q3_reordered) AS q3_organic,
        SUM(q3_reordered) - SUM(q2_reordered) organic_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS organic_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND product_name ILIKE '%organic%')
    GROUP BY aisle
    ORDER BY organic_difference),

    non_organic_aisle AS
    (SELECT
        aisle AS aisle_non_organic,
        SUM(q2_reordered) AS q2_non_organic,
        SUM(q3_reordered) AS q3_non_organic,
        SUM(q3_reordered) - SUM(q2_reordered) non_organic_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS non_organic_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND product_name NOT ILIKE '%organic%')
    GROUP BY aisle
    ORDER BY non_organic_difference),

    total_aisle AS
    (SELECT
        aisle AS aisle_total,
        SUM(q2_reordered) AS q2_total,
        SUM(q3_reordered) AS q3_total,
        SUM(q3_reordered) - SUM(q2_reordered) total_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS total_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND department = 'produce')
    GROUP BY aisle
    ORDER BY total_difference)

SELECT
    aisle_total,
    total_difference,
    non_organic_difference,
    organic_difference,
    total_percent_change,
    non_organic_percent_change,
    organic_percent_change
FROM total_aisle
JOIN organic_aisle
    ON aisle_total = aisle_organic
JOIN non_organic_aisle
    ON aisle_total = aisle_non_organic
ORDER BY total_difference
