-- Joined the order_products table and created a new table to speed up query times
CREATE TABLE total_reorders AS
    WITH q2_reorders AS 
        (
        SELECT
            product_name,
            aisle,
            department,
            SUM(q2.reordered) AS q2_reordered
        FROM products AS p
        JOIN aisles AS a
            ON p.aisle_id = a.aisle_id
        JOIN department AS d 
            ON p.department_id = d.department_id
        JOIN order_products_prior AS q2
            ON p.product_id = q2.product_id
        GROUP BY
            product_name,
            aisle,
            department
        ),

    q3_reorders AS
        (
        SELECT
            product_name,
            aisle,
            department,
            SUM(q3.reordered) AS q3_reordered
        FROM products p
        JOIN aisles a
            ON p.aisle_id = a.aisle_id
        JOIN department d
            ON p.department_id = d.department_id
        JOIN order_products_q3 AS q3
            ON p.product_id = q3.product_id
        GROUP BY
            product_name,
            aisle,
            department
        )

    SELECT
        q2.product_name,
        q2.aisle,
        q2.department,
        q2_reordered,
        q3_reordered
    FROM q2_reorders AS q2
    FULL OUTER JOIN q3_reorders AS q3
        ON q2.product_name = q3.product_name