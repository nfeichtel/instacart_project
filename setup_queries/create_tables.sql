-- Creates all tables

CREATE TABLE aisles (
    aisle_id INT,
    aisle VARCHAR(255)
);

CREATE TABLE department (
    department_id INT,
    department VARCHAR(255)
);

CREATE TABLE order_products_prior (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

CREATE TABLE order_products_curr (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

CREATE TABLE orders (
    order_id INT,
    user_id INT,
    eval_set VARCHAR(255),
    order_number INT,
    order_dow INT,
    order_hour_of_day INT,
    days_since_prior_order INT
);

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(500),
    aisle_id INT,
    department_id INT
);

