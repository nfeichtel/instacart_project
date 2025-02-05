
WITH organic_aisle AS
    (SELECT
        department AS department_organic,
        aisle AS aisle_organic,
        SUM(q2_reordered) AS q2_organic,
        SUM(q3_reordered) AS q3_organic,
        SUM(q3_reordered) - SUM(q2_reordered) organic_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS organic_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND product_name ILIKE '%organic%')
    GROUP BY department, aisle
    ORDER BY organic_difference),

    non_organic_aisle AS
    (SELECT
        department AS department_non_organic,
        aisle AS aisle_non_organic,
        SUM(q2_reordered) AS q2_non_organic,
        SUM(q3_reordered) AS q3_non_organic,
        SUM(q3_reordered) - SUM(q2_reordered) non_organic_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS non_organic_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE aisle != 'missing' AND product_name NOT ILIKE '%organic%')
    GROUP BY department, aisle
    ORDER BY non_organic_difference),

    total_aisle AS
    (SELECT
        department AS department_total,
        aisle AS aisle_total,
        SUM(q2_reordered) AS q2_total,
        SUM(q3_reordered) AS q3_total,
        SUM(q3_reordered) - SUM(q2_reordered) total_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS total_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE aisle != 'missing')
    GROUP BY department, aisle
    ORDER BY total_difference)

SELECT
    department_total AS department_name,
    aisle_total AS aisle_name,
    q2_total,
    q3_total,
    q2_non_organic,
    q3_non_organic,
    q2_organic,
    q3_organic
FROM total_aisle
left JOIN non_organic_aisle
    ON department_total = department_non_organic AND aisle_total = aisle_non_organic
left JOIN organic_aisle
    ON department_non_organic = department_organic AND aisle_non_organic = aisle_organic
ORDER BY department_total
