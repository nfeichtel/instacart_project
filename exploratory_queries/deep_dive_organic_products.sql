




--nearly every single department saw a reduction in organic reorders
WITH organic_department AS 
(
    SELECT
        department,
        SUM(q2_reordered) AS q2_organic,
        SUM(q3_reordered) AS q3_organic,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference_organic,
        ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change_organic
    FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name ILIKE '%organic%')
    GROUP BY department
    ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
),

total_department AS
(
    SELECT
        department,
        SUM(q2_reordered) AS q2,
        SUM(q3_reordered) AS q3,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference,
        ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change
    FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')
    GROUP BY department
    ORDER BY ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2)
)

SELECT
    td.department,
    q2_organic,
    ROUND(q2_organic/q2 * 100, 2) AS q2_percent_organic,
    q3_organic,
    ROUND(q3_organic/q3 * 100, 2) AS q3_percent_organic,
    difference,
    difference_organic,
    ROUND((q3_organic - q2_organic)/q2_organic * 100, 2) AS organic_change
FROM organic_department AS od
JOIN total_department AS td
ON od.department = td.department
ORDER BY difference_organic ASC