WITH total_negative_rank AS
    (SELECT
        product_name,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference,
        RANK() OVER(ORDER BY SUM(q3_reordered) - SUM(q2_reordered)) AS ranks
    FROM(SELECT * FROM total_reorders_augmented WHERE department != 'missing')
    GROUP BY product_name),

    non_organic_negative_rank AS
    (SELECT
        product_name,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference,
        RANK() OVER(ORDER BY SUM(q3_reordered) - SUM(q2_reordered)) AS ranks
    FROM(SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name NOT ILIKE '%organic%')
    GROUP BY product_name)

  /*  organic_negative_rank AS
    (SELECT
        product_name,
        SUM(q3_reordered) - SUM(q2_reordered) AS difference,
        RANK() OVER(ORDER BY SUM(q3_reordered) - SUM(q2_reordered)) AS ranks
    FROM(SELECT * FROM total_reorders_augmented WHERE department != 'missing' AND product_name ILIKE '%organic%')
    GROUP BY product_name)*/

SELECT
    tnr.product_name,
    tnr.ranks AS total_neg_rank,
    nonr.ranks AS total_non_organic_neg_rank
    --onr.ranks AS total_organic_neg_rank
FROM total_negative_rank tnr
JOIN non_organic_negative_rank nonr
    ON tnr.product_name = nonr.product_name
--JOIN organic_negative_rank onr
   -- ON tnr.product_name = onr.product_name
ORDER BY total_neg_rank

