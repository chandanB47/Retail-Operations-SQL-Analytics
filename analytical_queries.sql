use retail_analystics;

show Tables;


DESCRIBE stores;
DESCRIBE employees;
DESCRIBE categories;
DESCRIBE products;
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_items;


# Task 01

select * from customers;

# Task 02

Select customer_id, full_name, email, city 
from customers;

# Task 03

select full_name , city
from customers
where city = 'Bengaluru';

# Task 04

select full_name, signup_date
from customers
order by signup_date desc;

# Task 05

select * from stores;

select city, state, is_active
from stores
where is_active = 1;


# Task 06

select * from products;

select product_id, product_name, stock_quantity 
from products
where stock_quantity > 0;

# Task 07

select product_id, product_name, stock_quantity 
from products
where stock_quantity = 0;

# Task 08

select customer_id, upper(full_name ) as Standardized_name, city 
from customers;

# Task 09

select customer_id, lower(email) as lower_email, city 
from customers;

# Task 10

SELECT 
    customer_id,
    phone,
    REPLACE(
        REPLACE(
            REPLACE(phone, '+91 ', ''),
            '+91-', ''
        ),
        '-', ''
    ) AS normalized_phone
FROM customers;

# Task 11

SELECT 
    customer_id,
    UPPER(full_name) AS standardized_name,
    LOWER(email) AS cleaned_email,
    REPLACE(
        REPLACE(
            REPLACE(phone, '+91 ', ''),
            '+91-', ''
        ),
        '-', ''
    ) AS normalized_phone,
    city
FROM customers;

# Task 12

select * from products;
select * from categories;

select p.product_name, p.retail_price, p.stock_quantity, c.category_name
from products p
inner Join categories c
on p.category_id = c.category_id;


# Task 13

select c.full_name, o.order_id, o.order_date, o.order_status
from customers c
inner join orders as o
on c.customer_id = o.customer_id;

# Task 14

select o.order_id, o.order_date, s.store_name, s.city
from orders o
inner join stores s
on o.store_id = s.store_id;

# Task 15

SELECT 
    e.emp_id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    s.store_name,
    COALESCE(CONCAT(m.first_name, ' ', m.last_name), 'DIRECTOR / NO MANAGER') AS reports_to
FROM employees e
LEFT JOIN employees m 
    ON e.manager_id = m.emp_id
LEFT JOIN stores s 
    ON e.store_id = s.store_id
ORDER BY 
    reports_to,
    employee_name;
    
# Task 16

SELECT 
    c.customer_id,
    c.full_name,
    c.email
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


# Task 17

select 
c.customer_id,
c.full_name,
c.email,
c.city,
c.signup_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


# Task 18

select 
first_name,
last_name,
manager_id
FROM employees
WHERE manager_id IS NULL;

# Task 19

select count(*) from customers;

# Task 20
select count(*) from orders;

# Task 21
select SUM(quantity)
FROM order_items;

# Task 22
select  avg(retail_price)
from products;

# Task 23
SELECT MAX(retail_price) AS highest_retail_price
FROM products;


# Task 24
SELECT MIN(retail_price) AS lowest_retail_price
FROM products;

# Task 25
SELECT city, COUNT(*)
FROM customers
GROUP BY city;


# Task 26
SELECT category_id, COUNT(*)
FROM products
GROUP BY category_id;

# Task 27
SELECT 
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status;

# Task 28

SELECT 
    s.store_id,
    s.store_name,
    SUM(
        oi.quantity * oi.unit_sale_price - oi.discount_amount
    ) AS total_revenue
FROM stores s
INNER JOIN orders o
    ON s.store_id = o.store_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY 
    s.store_id,
    s.store_name;
    
    
    # Task 29

SELECT 
    s.store_id,
    s.store_name,
    SUM(
        oi.quantity * oi.unit_sale_price - oi.discount_amount
    ) AS total_revenue
FROM stores s
INNER JOIN orders o
    ON s.store_id = o.store_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY 
    s.store_id,
    s.store_name
HAVING SUM(
    oi.quantity * oi.unit_sale_price - oi.discount_amount
) >= 15000;



# Task 30

SELECT 
    order_id,
    order_date,
    shipped_date,
    DATEDIFF(shipped_date, order_date) AS days_to_ship
FROM orders;

# Task 31

SELECT 
    order_id,
    order_date,
    shipped_date,
    CASE
        WHEN shipped_date IS NULL THEN 'Not Shipped'
        WHEN DATEDIFF(shipped_date, order_date) <= 2 
            THEN 'Fast Delivery (<= 2 Days)'
        ELSE 'Standard / Delayed Delivery'
    END AS fulfillment_category
FROM orders;


# Task 32

SELECT 
    order_id,
    order_date,
    shipped_date,
    DATEDIFF(shipped_date, order_date) AS fulfillment_days
FROM orders
WHERE order_status = 'DELIVERED';

# Task 33

SELECT 
    c.category_id,
    c.category_name,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(oi.quantity) AS total_units_sold,

    SUM(oi.quantity * oi.unit_sale_price) AS gross_sales_value,

    SUM(oi.discount_amount) AS total_discounts,

    SUM(
        oi.quantity * oi.unit_sale_price 
        - oi.discount_amount
    ) AS net_revenue

FROM categories c

INNER JOIN products p
    ON c.category_id = p.category_id

INNER JOIN order_items oi
    ON p.product_id = oi.product_id

INNER JOIN orders o
    ON oi.order_id = o.order_id

GROUP BY 
    c.category_id,
    c.category_name;
    
    
    
# Task 34

DESCRIBE order_items;
DESCRIBE products;


SELECT 
    c.category_id,
    c.category_name,

    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
    ) AS net_revenue,

    SUM(
        oi.quantity * p.unit_cost
    ) AS product_cost,

    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
        - oi.quantity * p.unit_cost
    ) AS estimated_profit

FROM categories c

INNER JOIN products p
    ON c.category_id = p.category_id

INNER JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY 
    c.category_id,
    c.category_name;
    
# Task 35

SELECT 
    s.store_id,
    s.store_name,
    s.city,

    COUNT(DISTINCT o.order_id) AS completed_orders,

    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
    ) AS store_revenue

FROM stores s

INNER JOIN orders o
    ON s.store_id = o.store_id

INNER JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE s.is_active = 1
  AND o.order_status = 'DELIVERED'

GROUP BY 
    s.store_id,
    s.store_name,
    s.city

HAVING SUM(
    oi.quantity * oi.unit_sale_price
    - oi.discount_amount
) >= 15000

ORDER BY store_revenue DESC

LIMIT 10;


# Task 36

SELECT 
    s.store_id,
    s.store_name,
    s.city,
    p.product_id,
    p.product_name,
    p.stock_quantity

FROM stores s

CROSS JOIN products p

WHERE s.is_active = 1
  AND p.stock_quantity > 0

ORDER BY 
    s.store_id,
    p.product_id;
    
    
    
# Task 37

SELECT 
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity = 0;


