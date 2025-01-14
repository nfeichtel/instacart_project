-- Comparing reorder rates between Q2 and Q3 segmented by department
-- Removed missing depeartment
-- Top negative change: babies(-22.3%), bulk(-7.39%), alcohol(-6%), dairy eggs(-5.09%)
SELECT
    department,
    SUM(q2_reordered) AS q2,
    SUM(q3_reordered) AS q3,
    SUM(q3_reordered) - SUM(q2_reordered) AS difference,
    ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2) AS percent_change,
    ROUND(SUM(q2_reordered) / (SELECT SUM(q2_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')) * 100, 2) AS per_q2_reorders,
    ROUND(SUM(q3_reordered) / (SELECT SUM(q3_reordered) FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')) * 100, 2) AS per_q3_reorders
FROM (SELECT * FROM total_reorders_augmented WHERE department != 'missing')
GROUP BY department
ORDER BY difference DESC; --ROUND((SUM(q3_reordered) - SUM(q2_reordered)) / SUM(q2_reordered) * 100, 2);

