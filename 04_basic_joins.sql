USE DA_SQL_Practice;
GO

-- Review Tables
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM order_items;



-- Q1: Show order_id, order_date, and customer_name
-- using INNER JOIN between orders and customers.

SELECT o.order_id, 
    o.order_date, 
    c.customer_name
FROM orders o INNER JOIN  customers c
    ON o.customer_id = c.customer_id; 


-- Q2: Show all customers and their order_id.
-- Use LEFT JOIN.

SELECT
    c.customer_name,
    o.order_id
FROM customers c LEFT JOIN orders o
    ON o.customer_id= c.customer_id;


-- Q3: Show order_id, customer_name, and product_id
-- by joining orders, customers, and order_items.

SELECT
    o.order_id,
    c.customer_name,
    oi.product_id
FROM orders o INNER JOIN  customers c 
        ON o.customer_id= c.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id;


-- Q4: Show product_name and quantity
-- by joining products and order_items.
-- Use INNER JOIN.

SELECT
    p.product_name,
    oi.quantity
FROM products p INNER JOIN order_items oi ON p.product_id= oi.product_id;


-- Q5: Show customers who have NOT placed any orders.
-- Use LEFT JOIN and filter properly.

SELECT
    c.customer_name
FROM customers c LEFT JOIN  orders o ON c.customer_id= o.customer_id
WHERE o.order_id IS NULL;



