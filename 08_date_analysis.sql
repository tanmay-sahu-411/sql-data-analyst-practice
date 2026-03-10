USE DA_SQL_Practice;
GO

-- Review Tables
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;



-- Q1: Show total number of orders for each year and month.
-- Show order_year, order_month, and total_orders.
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;


-- Q2: Calculate total revenue for each year and month.
-- Show order_year, order_month, and total_revenue.
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * p.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;


-- Q3: Calculate average order value (AOV) for each month.
-- AOV = total revenue / total orders.
WITH order_revenue AS (
    SELECT
        o.order_id,
        o.order_date,
        SUM(oi.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY o.order_id, o.order_date
)

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    AVG(revenue) AS avg_order_value
FROM order_revenue
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;



-- Q4: Find the month with the highest total revenue.
-- Show order_year, order_month, and total_revenue.
SELECT TOP 1
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * p.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY total_revenue DESC;



-- Q5: Show cumulative revenue by order date (running total).
-- Show order_date, daily_revenue, cumulative_revenue.
WITH daily_revenue AS (
    SELECT
        o.order_date,
        SUM(oi.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY o.order_date
)

SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM daily_revenue
ORDER BY order_date;