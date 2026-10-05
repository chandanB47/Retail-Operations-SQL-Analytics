
-- ==================================================
-- Project: Retail Store Operations & Analytics
-- Database: MySQL
-- Step 1: Database Setup
-- ==================================================

CREATE DATABASE IF NOT EXISTS retail_analytics;

USE retail_analytics;





-- Drop child tables before parent tables
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS stores;

-- 1. Stores
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- 2. Employees (Hierarchical Self-Reference)
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    store_id INT,
    manager_id INT,
    hire_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_emp_store FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE SET NULL,
    CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- 3. Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- 4. Products (Fixed: Table-level CHECK constraint for multi-column validation)
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category_id INT NOT NULL,
    unit_cost DECIMAL(10, 2) NOT NULL CHECK (unit_cost >= 0),
    retail_price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    CONSTRAINT fk_prod_category FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT chk_retail_vs_cost CHECK (retail_price >= unit_cost)
);

-- 5. Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50) NOT NULL,
    signup_date DATE DEFAULT (CURRENT_DATE)
);

-- 6. Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    order_date DATE NOT NULL,
    shipped_date DATE,
    order_status VARCHAR(20) DEFAULT 'PENDING' CHECK (order_status IN ('PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED')),
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_store FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- 7. Order Items
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_sale_price DECIMAL(10, 2) NOT NULL CHECK (unit_sale_price >= 0),
    discount_amount DECIMAL(10, 2) DEFAULT 0.00 CHECK (discount_amount >= 0),
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ==========================================================
-- Project: Retail Store Operations & Analytics
-- Step 3: Seed Data
-- Database: MySQL
-- ==========================================================

USE retail_analytics;

START TRANSACTION;

-- 1. STORES
INSERT INTO stores
(store_id, store_name, city, state, is_active)
VALUES
(1, 'Indiranagar Flagship', 'Bengaluru', 'Karnataka', TRUE),
(2, 'Hitec City Store', 'Hyderabad', 'Telangana', TRUE),
(3, 'Andheri West Hub', 'Mumbai', 'Maharashtra', TRUE),
(4, 'Koramangala Express', 'Bengaluru', 'Karnataka', FALSE);


-- 2. EMPLOYEES
-- Insert the top-level manager first because of manager_id FK
INSERT INTO employees
(emp_id, first_name, last_name, email, salary,
 store_id, manager_id, hire_date)
VALUES
(101, 'Aarav', 'Sharma', 'aarav.s@retail.in',
 140000.00, 1, NULL, '2023-01-10');

INSERT INTO employees
(emp_id, first_name, last_name, email, salary,
 store_id, manager_id, hire_date)
VALUES
(102, 'Neha', 'Patel', 'neha.p@retail.in',
 95000.00, 1, 101, '2023-05-15'),
(103, 'Rohan', 'Verma', 'rohan.v@retail.in',
 72000.00, 1, 102, '2024-02-01'),
(104, 'Priya', 'Nair', 'priya.n@retail.in',
 98000.00, 2, 101, '2023-08-12'),
(105, 'Vikram', 'Singh', 'vikram.s@retail.in',
 68000.00, 2, 104, '2024-06-20'),
(106, 'Ananya', 'Sen', 'ananya.s@retail.in',
 88000.00, 3, 101, '2024-01-15');


-- 3. CATEGORIES
INSERT INTO categories
(category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Stationery');


-- 4. PRODUCTS
INSERT INTO products
(product_id, product_name, category_id,
 unit_cost, retail_price, stock_quantity)
VALUES
(201, 'Wireless Mechanical Keyboard', 1, 2500.00, 4999.00, 45),
(202, 'Ergonomic Vertical Mouse', 1, 1200.00, 2499.00, 80),
(203, 'USB-C Dual 4K Dock', 1, 4200.00, 7999.00, 15),
(204, 'Standing Desk Converter', 2, 8500.00, 14999.00, 20),
(205, 'Mesh Executive Chair', 2, 7000.00, 12500.00, 12),
(206, 'Hardcover Dot Grid Journal', 3, 200.00, 599.00, 150),
(207, 'Aluminum Laptop Stand', 1, 900.00, 1899.00, 0);


-- 5. CUSTOMERS
INSERT INTO customers
(customer_id, full_name, email, phone, city, signup_date)
VALUES
(1, 'Chandan Kumar', 'chandan@test.com',
 '+91 9876543210', 'Bengaluru', '2025-10-10'),
(2, 'Aditi Rao', 'aditi.rao@gmail.com',
 '9876501234', 'Bengaluru', '2025-11-05'),
(3, 'Rajesh Gupta', 'r_gupta@outlook.com',
 '+91-9123456780', 'Hyderabad', '2026-01-15'),
(4, 'Meera Deshmukh', 'meera.d@techcorp.in',
 '022-23456789', 'Mumbai', '2026-03-01'),
(5, 'Suresh Menon', 'suresh.menon@yahoo.com',
 '9811122233', 'Chennai', '2026-04-10');


-- 6. ORDERS
INSERT INTO orders
(order_id, customer_id, store_id,
 order_date, shipped_date, order_status)
VALUES
(1001, 1, 1, '2026-07-01', '2026-07-03', 'DELIVERED'),
(1002, 2, 1, '2026-07-15', '2026-07-16', 'DELIVERED'),
(1003, 1, 1, '2026-08-01', '2026-08-05', 'DELIVERED'),
(1004, 3, 2, '2026-08-10', '2026-08-12', 'DELIVERED'),
(1005, 4, 3, '2026-08-25', '2026-08-28', 'DELIVERED'),
(1006, 2, 1, '2026-09-02', '2026-09-03', 'DELIVERED'),
(1007, 1, 2, '2026-09-10', NULL, 'SHIPPED'),
(1008, 3, 2, '2026-09-12', NULL, 'PENDING');


-- 7. ORDER_ITEMS
INSERT INTO order_items
(order_id, product_id, quantity,
 unit_sale_price, discount_amount)
VALUES
(1001, 201, 1, 4999.00, 200.00),
(1001, 202, 2, 2499.00, 0.00),
(1002, 204, 1, 14999.00, 1000.00),
(1003, 205, 1, 12500.00, 500.00),
(1003, 206, 3, 599.00, 0.00),
(1004, 201, 2, 4999.00, 500.00),
(1004, 203, 1, 7999.00, 300.00),
(1005, 202, 1, 2499.00, 0.00),
(1006, 201, 1, 4999.00, 0.00),
(1006, 203, 1, 7999.00, 500.00),
(1007, 205, 2, 12500.00, 1200.00),
(1008, 206, 5, 599.00, 100.00);

COMMIT;


USE retail_analytics;

SELECT 'stores' AS table_name, COUNT(*) AS total
FROM stores
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;



-- Check employees and their managers
SELECT
    emp_id,
    first_name,
    manager_id
FROM employees
ORDER BY emp_id;

-- Check customers with their orders
SELECT
    c.full_name,
    o.order_id,
    o.order_status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

-- Check products and categories
SELECT
    p.product_name,
    c.category_name,
    p.stock_quantity
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY p.product_id;



show tables;


DESCRIBE stores;
DESCRIBE employees;
DESCRIBE categories;
DESCRIBE products;
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_items;



SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'retail_analytics'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;

USE retail_analytics;

SHOW TABLES;

SELECT COUNT(*) AS store_count FROM stores;
SELECT COUNT(*) AS employee_count FROM employees;
SELECT COUNT(*) AS category_count FROM categories;
SELECT COUNT(*) AS product_count FROM products;
SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS order_count FROM orders;
SELECT COUNT(*) AS order_item_count FROM order_items;


select full_name from customers;


SELECT 
    customer_id,
    UPPER(full_name) AS standardized_name,
    LOWER(email) AS cleaned_email,
    REPLACE(REPLACE(REPLACE(phone, '+91 ', ''), '+91-', ''), '-', '') AS normalized_phone,
    city
FROM customers;

select customer_id, upper(full_name) as Name
from customers;

select customer_id, email, full_name, upper(full_name) as standardized_name, upper(email) as cleaned_email
from customers;


select * from customers;


SELECT 
    customer_id,
    UPPER(full_name) AS standardized_name,
    LOWER(email) AS cleaned_email,
    REPLACE(REPLACE(REPLACE(phone, '+91 ', ''), '+91-', ''), '-', '') AS normalized_phone,
    city
FROM customers;


