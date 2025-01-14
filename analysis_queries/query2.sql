WITH organic_reordered AS (
    SELECT
        SUM(q2_reordered) AS q2_organic_reordered,
        SUM(q3_reordered) AS q3_organic_reordered,
        SUM(q3_reordered) - SUM(q2_reordered) difference_organic_reordered,
        ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) percent_change_organic_reordered
    FROM total_reorders_augmented
    WHERE department != 'missing' AND product_name ILIKE '%organic%'
)

SELECT
(SELECT q2_organic_reordered FROM organic_reordered)/ SUM(q2_reordered),
(SELECT q3_organic_reordered FROM organic_reordered)/ SUM(q3_reordered)
FROM total_reorders_augmented



