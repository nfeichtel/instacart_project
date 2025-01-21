
WITH organic_department AS
    (SELECT
        department AS department_organic,
        SUM(q2_reordered) AS q2_organic,
        SUM(q3_reordered) AS q3_organic,
        SUM(q3_reordered) - SUM(q2_reordered) organic_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS organic_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name ILIKE '%organic%')
    GROUP BY department
    ORDER BY organic_difference),

    non_organic_department AS
    (SELECT
        department AS department_non_organic,
        SUM(q2_reordered) AS q2_non_organic,
        SUM(q3_reordered) AS q3_non_organic,
        SUM(q3_reordered) - SUM(q2_reordered) non_organic_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS non_organic_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name NOT ILIKE '%organic%')
    GROUP BY department
    ORDER BY non_organic_difference),

    total_department AS
    (SELECT
        department AS department_total,
        SUM(q2_reordered) AS q2_total,
        SUM(q3_reordered) AS q3_total,
        SUM(q3_reordered) - SUM(q2_reordered) total_difference,
        CASE WHEN SUM(q2_reordered) != 0 THEN ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
            ELSE NULL
        END AS total_percent_change
    FROM(SELECT * FROM total_reorders_augmented WHERE department != 'missing')
    GROUP BY department
    ORDER BY total_difference),

    quarterly_reorder_percentages AS 
    (SELECT
        department,
        ROUND(SUM(q2_reordered) / (SELECT SUM(q2_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')) * 100, 2) AS percent_q2_reorders,
        ROUND(SUM(q3_reordered) / (SELECT SUM(q3_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')) * 100, 2) AS percent_q3_reorders
    FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')
    GROUP BY department)


SELECT
    department_total AS department,
    total_difference,
    total_percent_change,
    percent_q2_reorders,
    percent_q3_reorders,
    non_organic_difference,
    non_organic_percent_change,
    organic_difference,
    organic_percent_change
FROM total_department
JOIN organic_department
    ON department_total = department_organic
JOIN non_organic_department
    ON department_total = department_non_organic
JOIN quarterly_reorder_percentages
    ON department_total = quarterly_reorder_percentages.department
ORDER BY total_difference
