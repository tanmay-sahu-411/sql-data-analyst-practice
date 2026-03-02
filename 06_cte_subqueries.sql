USE DA_SQL_Practice;
GO

-- Review Tables
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;



-- Q1: Show products whose price is greater than the average product price.
-- Show product_name and price.
SELECT 
	product_name, price
FROM products
WHERE price > (
	SELECT AVG(price)
	FROM products
);


-- Q2: Show products that have been ordered at least once.
-- Use a subquery (not JOIN).
SELECT 
	product_name
FROM products
WHERE product_id IN (
	SELECT product_id
	FROM order_items
);


-- Q3: Show customers who placed more orders than the average number of orders per customer.
-- Show customer_name and order_count.
SELECT 
    t.customer_name,
    t.order_count
FROM(
    SELECT
        c.customer_name,
        COUNT(o.order_id) AS order_count
    FROM customers c LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) t
WHERE t.order_count > (
    SELECT AVG(order_count)
    FROM (
        SELECT 
            COUNT(o.order_id) AS order_count
        FROM customers c
        LEFT JOIN orders o
            ON c.customer_id = o.customer_id
        GROUP BY c.customer_name
    ) x
);


-- Q4: Show product(s) whose revenue is equal to the maximum product revenue.
-- Show product_name and product_revenue.
SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS product_revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(oi.quantity * p.price) = (
    SELECT MAX(product_revenue)
    FROM (
        SELECT 
            SUM(oi.quantity * p.price) AS product_revenue
        FROM order_items oi
        INNER JOIN products p
            ON oi.product_id = p.product_id
        GROUP BY p.product_name
    ) t
);


-- Q5: Solve Q3 again using a CTE (cleaner approach).
WITH customer_orders AS (
    SELECT
        c.customer_name,
        COUNT(o.order_id) AS order_count
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)
SELECT
    customer_name,
    order_count
FROM customer_orders
WHERE order_count > (
    SELECT AVG(order_count)
    FROM customer_orders
)
ORDER BY order_count DESC;


-- Q6: Use a CTE to calculate product revenue once, then return the product(s) with max revenue.
WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(oi.quantity * p.price) AS product_revenue
    FROM order_items oi
    INNER JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    product_revenue
FROM product_revenue
WHERE product_revenue = (SELECT MAX(product_revenue) FROM product_revenue);