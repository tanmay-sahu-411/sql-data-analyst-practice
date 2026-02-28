USE DA_SQL_Practice;
GO

--- Show all columns from customers.
SELECT *
FROM customers;

--- Show customer_name and city
SELECT customer_name, city
FROM customers;

--– Customers from South region
SELECT *
FROM customers
WHERE region= 'South';

--– Products with price > 10000
SELECT *
FROM products
WHERE price > 10000;

--– Orders after 2024-06-30
SELECT *
FROM orders
WHERE order_date > '2024-06-30';

--– Products ordered by price (highest first)
SELECT *
FROM products
ORDER BY price DESC;

--– Top 2 most expensive products (SQL Server)
SELECT TOP 2 *
FROM products
ORDER BY price DESC;

--- Count how many customers are in each region.
SELECT region, COUNT(*) AS customer_count
FROM customers
GROUP BY region
ORDER BY customer_count DESC;

--- Average product price per category
SELECT
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

--- Categories with avg price > 10000
SELECT
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > 10000
ORDER BY avg_price DESC;
