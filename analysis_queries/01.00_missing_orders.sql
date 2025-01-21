-- Calculate the percent of missing reorder data for each quarter
-- Q2 missing percent = 0.14%
-- Q3 missing percent = 0.38%
SELECT
    ROUND((SELECT SUM(q2_reordered) AS q2_not_missing
        FROM total_reorders_augmented
        WHERE aisle = 'missing') / SUM(q2_reordered) * 100, 2) AS q2_percent_missing,
    ROUND((SELECT SUM(q3_reordered) AS q3_not_missing
        FROM total_reorders_augmented
        WHERE aisle = 'missing') / SUM(q3_reordered) * 100, 2) AS q3_percent_missing   
FROM total_reorders_augmented;


