USE DA_SQL_Practice;
GO

-- Review Tables
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM products;



-- Q1: Calculate revenue for each product and assign a row number based on revenue
-- from highest to lowest using ROW_NUMBER().
-- Show product_name, revenue, and row_number.
SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) AS row_number
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name;


-- Q2: Calculate revenue for each product and rank the products based on revenue
-- from highest to lowest using RANK().
-- Show product_name, revenue, and revenue_rank.
SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) AS revenue_rank
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name;


-- Q3: Calculate revenue for each product and rank the products
-- from highest to lowest using DENSE_RANK().
-- Show product_name, revenue, and revenue_dense_rank.
SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue,
    DENSE_RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) AS revenue_dense_rank
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name;


-- Q4: Calculate revenue for each product and assign a row number within each category
-- based on revenue from highest to lowest.
-- Show category, product_name, revenue, and row_num.
WITH product_revenue AS(
    SELECT 
        p.category,
        p.product_name,
        SUM(oi.quantity * p.price) AS revenue
    FROM order_items oi 
    JOIN products p
        on oi.product_id= p.product_id
    GROUP BY p.category, p.product_name
)
SELECT
    category,
    product_name,
    revenue,
    ROW_NUMBER() OVER (
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS row_num
FROM product_revenue;


-- Q5: Calculate revenue for each order and show the running total of revenue
-- based on order_date and order_id.
-- Show order_date, order_id, revenue, and running_total.
WITH product_revenue AS(
    SELECT
        o.order_date, 
        o.order_id,
        SUM(oi.quantity * p.price) AS revenue
    FROM order_items oi 
    JOIN orders o
        ON oi.order_id= o.order_id
    JOIN products p
        ON oi.product_id=p.product_id
    GROUP BY o.order_date, o.order_id
)
SELECT
    order_date,
    order_id,
    revenue,
    SUM(revenue) OVER (ORDER BY order_date, order_id) AS running_total
FROM product_revenue;


-- Q6: Calculate revenue per order and show the previous order's revenue
-- using LAG().
-- Show order_date, order_id, revenue, and previous_revenue.
WITH order_revenue AS (
    SELECT
        o.order_date,
        o.order_id,
        SUM(oi.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY o.order_date, o.order_id
)
SELECT
    order_date,
    order_id,
    revenue,
    LAG(revenue) OVER (ORDER BY order_date, order_id) AS previous_revenue
FROM order_revenue;


-- Q7: Find the highest revenue product in each category.
-- Show category, product_name, revenue.
WITH product_revenue AS (
    SELECT
        p.category,
        p.product_name,
        SUM(oi.quantity * p.price) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.category, p.product_name
),

ranked_products AS (
    SELECT
        category,
        product_name,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS row_num
    FROM product_revenue
)

SELECT
    category,
    product_name,
    revenue
FROM ranked_products
WHERE row_num = 1;