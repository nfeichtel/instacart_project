UPDATE total_reorders_augmented
SET product_name = REPLACE(product_name, '&', 'and');

UPDATE total_reorders_augmented
SET product_name = REPLACE(product_name, 'And', 'and');