-- Created a table with the removed duplicates and clean values from order_products_curr

CREATE TABLE order_products_Q3 AS
    WITH order_products_curr_clean AS 
    (
        SELECT 
            order_id,
            product_id,
            SUM(reordered) / 2 AS reordered
        FROM  order_products_curr
        GROUP BY
            order_id,
            product_id
        ORDER BY
            order_id,
            product_id
    )

    SELECT *
    FROM order_products_curr_clean