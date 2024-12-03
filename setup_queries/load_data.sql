-- Load Data

COPY aisles
FROM '/Users/nickfeichtel/Desktop/Portfolio_Projects/instacart_data/aisles.csv'
DELIMITER ',' CSV HEADER;

COPY department
FROM '/Users/nickfeichtel/Desktop/Portfolio_Projects/instacart_data/departments.csv'
DELIMITER ',' CSV HEADER;

COPY order_products_prior
FROM '/Users/nickfeichtel/Desktop/Portfolio_Projects/instacart_data/order_products__prior.csv'
DELIMITER ',' CSV HEADER;

COPY order_products_curr
FROM '/Users/nickfeichtel/Desktop/Portfolio_Projects/instacart_data/order_products__train.csv'
DELIMITER ',' CSV HEADER;

COPY orders
FROM '/Users/nickfeichtel/Desktop/Portfolio_Projects/instacart_data/orders.csv'
DELIMITER ',' CSV HEADER;

COPY products 
FROM '/Users/nickfeichtel/Desktop/Portfolio_Projects/instacart_data/products.csv'
DELIMITER ',' CSV HEADER;

