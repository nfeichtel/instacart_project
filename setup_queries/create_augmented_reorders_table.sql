CREATE TABLE total_reorders_augmented AS
    WITH reorders_augmented AS 
    (
    SELECT
        product_name,
        aisle,
        department,
        q2_reordered,
        Round(q3_reordered * 23.475, 0)
    FROM total_reorders
    WHERE q2_reordered IS NOT NULL
        AND q3_reordered IS NOT NULL
    )

    SELECT *
    FROM reorders_augmented