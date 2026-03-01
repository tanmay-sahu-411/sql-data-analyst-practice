USE DA_SQL_Practice;
GO

-- Review Tables
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;



-- Q1: Calculate total revenue of the business.
-- Revenue = quantity * price.
SELECT 
    SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id;



-- Q2: Calculate total revenue per product.
-- Show product_name and revenue.
SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS product_revenue
FROM order_items oi 
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;



-- Q3: Calculate total revenue per customer.
-- Show customer_name and total_revenue.
SELECT 
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;



-- Q4: Calculate total number of orders.
SELECT COUNT(*) AS total_orders
FROM orders;



-- Q5: Calculate revenue per order.
-- Show order_id and order_revenue.
SELECT
    o.order_id,
    SUM(oi.quantity * p.price) AS order_revenue
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY o.order_id
ORDER BY order_revenue DESC;



-- Q6: Calculate Average Order Value (AOV).
-- AOV = total revenue / total number of orders.
SELECT
    CAST(SUM(oi.quantity * p.price) AS DECIMAL(18,2)) 
    / NULLIF(COUNT(DISTINCT o.order_id), 0) AS avg_order_value
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;




-- Q7: Calculate revenue contribution percentage for each product.
-- Show product_name, product_revenue, and contribution_percentage.
-- Contribution % = (product revenue / total revenue) * 100
SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS product_revenue,
    CAST(
        SUM(oi.quantity * p.price) * 100.0 /
        SUM(SUM(oi.quantity * p.price)) OVER ()
    AS DECIMAL(10,2)) AS contribution_percentage
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY contribution_percentage DESC;



-- Q8: Find the customer who generated the highest total revenue.
-- Show customer_name and total_revenue.
SELECT TOP 1
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;

