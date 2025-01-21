-- q2 non_organic reorders: 6491019
-- q3 non_organic reorders: 6131724
-- non_organic reorder difference: -359295 (-5.54%)
SELECT
    SUM(q2_reordered) AS q2_non_organic,
    SUM(q3_reordered) AS q3_non_organic,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference_non_organic,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change_non_organic
FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name NOT ILIKE '%organic%');



