USE DA_SQL_Practice;
GO

SELECT * FROM products;
SELECT * FROM customers;


-- Q1: Classify products into 'Premium' if price > 30000,
-- 'Mid-Range' if price between 10000 and 30000,
-- otherwise 'Budget'.
-- Show product_name, price, and price_category.

SELECT 
    product_name,
    price,
    CASE
        WHEN price> 30000 THEN 'Premium'
        WHEN price BETWEEN 10000 AND 30000 THEN 'Mid-Range'
        ELSE 'Budget'
    END AS price_category
FROM products;



-- Q2: Create a column called region_priority.
-- If region = 'South', label it 'High Priority'.
-- Otherwise label it 'Standard'.
-- Show customer_name, region, and region_priority.

SELECT
    customer_name,
    region,
    CASE
        WHEN region = 'South' THEN 'High Priority'
        ELSE 'Standard'
    END AS region_priority
FROM customers;



-- Q3: Create price_tier:
-- If price >= 50000 - 'Tier 1'
-- If price between 20000 and 49999 - 'Tier 2'
-- Else - 'Tier 3'
-- Show product_name, price, and price_tier.

SELECT
    product_name,
    price,
    CASE
        WHEN price >= 50000 THEN 'Tier 1'
        WHEN price BETWEEN 20000 AND 49999 THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS price_tier
FROM products;



-- Q4: Label products as 'Expensive' if price > 40000.
-- Do not use ELSE.
-- Show product_name, price, and expense_label.

SELECT
    product_name,
    price,
    CASE
        WHEN price > 40000 THEN 'Expensive'
    END AS expense_label
FROM products;







