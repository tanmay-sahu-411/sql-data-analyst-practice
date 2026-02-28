CREATE DATABASE DA_SQL_Practice;
GO

USE DA_SQL_Practice;
GO



CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



INSERT INTO customers VALUES
(1, 'Tanmay', 'Bangalore', 'South', '2024-01-10'),
(2, 'Rahul', 'Mumbai', 'West', '2024-02-15'),
(3, 'Amit', 'Delhi', 'North', '2024-03-20'),
(4, 'Sneha', 'Chennai', 'South', '2024-04-05'),
(5, 'Priya', 'Kolkata', 'East', '2024-05-12');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 60000),
(2, 'Phone', 'Electronics', 30000),
(3, 'Headphones', 'Accessories', 2000),
(4, 'Chair', 'Furniture', 5000),
(5, 'Desk', 'Furniture', 10000);

INSERT INTO orders VALUES
(101, 1, '2024-06-01'),
(102, 2, '2024-06-05'),
(103, 3, '2024-06-10'),
(104, 1, '2024-07-01'),
(105, 4, '2024-07-15'),
(106, 5, '2024-08-01');

INSERT INTO order_items VALUES
(1, 101, 1, 1),
(2, 101, 3, 2),
(3, 102, 2, 1),
(4, 103, 4, 3),
(5, 104, 2, 2),
(6, 105, 5, 1),
(7, 106, 1, 1);



