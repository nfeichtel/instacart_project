-- q2 organic reorders: 6491019
-- q3 organic reorders: 6131724
-- organic reorder difference: -359295 (-5.54%)
SELECT
    SUM(q2_reordered) AS q2_organic,
    SUM(q3_reordered) AS q3_organic,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference_organic,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change_organic
FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name ILIKE '%organic%');



