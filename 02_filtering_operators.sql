USE DA_SQL_Practice;
GO

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


--- Show all unique regions from customers.
SELECT DISTINCT region 
FROM customers;

--- Show customers from South and West regions.
SELECT *
FROM customers
WHERE region IN ('South', 'West');

--- Show products priced between 5000 and 30000.
SELECT *
FROM products
WHERE price BETWEEN 5000 AND 30000;

--- Show customers whose name starts with 'T'.
SELECT *
FROM customers
WHERE customer_name LIKE 'T%';

--- Show customers whose name contains 'a'.
SELECT *
FROM customers
WHERE customer_name LIKE '%a%';



--- NULL Handling
UPDATE customers
SET city = NULL
WHERE customer_id = 5;

--- Show customers where city IS NULL
SELECT *
FROM customers
WHERE city IS NULL;
--- Show customers where city IS NOT NULL
SELECT *
FROM customers
WHERE city IS NOT NULL;




