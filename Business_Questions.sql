-- ==================================================
-- Project: Retail Store Operations & Analytics
-- Database: MySQL
-- PROJECT BUSINESS QUESTIONS
-- ==================================================




# Q1
SELECT 
    customer_id,
    UPPER(full_name) AS standardized_name,
    LOWER(email) AS cleaned_email,
    REPLACE(REPLACE(REPLACE(phone, '+91 ', ''), '+91-', ''), '-', '') AS normalized_phone,
    city
FROM customers;

# Q2
SELECT 
    e.emp_id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    s.store_name,
    COALESCE(
        CONCAT(m.first_name, ' ', m.last_name),
        'DIRECTOR / NO MANAGER'
    ) AS manager_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id
LEFT JOIN stores s
    ON e.store_id = s.store_id
ORDER BY 
    employee_name;
    
    
# Q3
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    c.signup_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

# Q4
SELECT 
    order_id,
    order_date,
    shipped_date,
    order_status,

    DATEDIFF(shipped_date, order_date) AS fulfillment_days,

    CASE
        WHEN shipped_date IS NULL 
            THEN 'Not Shipped'

        WHEN DATEDIFF(shipped_date, order_date) <= 2
            THEN 'Fast Delivery (<= 2 Days)'

        ELSE 'Standard / Delayed Delivery'
    END AS fulfillment_category

FROM orders;


# Q5
SELECT 
    order_id,
    order_date,
    shipped_date,
    order_status,

    DATEDIFF(shipped_date, order_date) AS fulfillment_days,

    CASE
        WHEN shipped_date IS NULL 
            THEN 'Not Shipped'

        WHEN DATEDIFF(shipped_date, order_date) <= 2
            THEN 'Fast Delivery (<= 2 Days)'

        ELSE 'Standard / Delayed Delivery'
    END AS fulfillment_category

FROM orders;



# Q6
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

ORDER BY store_revenue DESC;


# Q7
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
    
    
    
    # Challenge Questions
    
    # Challenge 01
    
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS order_count
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.full_name
ORDER BY order_count DESC
LIMIT 1;


# Challenge 02
SELECT 
    p.product_id,
    p.product_name,
    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
    ) AS net_revenue
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY 
    p.product_id,
    p.product_name
ORDER BY net_revenue DESC
LIMIT 1;


# Challenge 03
SELECT 
    c.category_id,
    c.category_name,

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
    c.category_name

ORDER BY estimated_profit DESC
LIMIT 1;



# Challenge 04

SELECT 
    s.store_id,
    s.store_name,

    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
    ) AS total_revenue

FROM stores s

INNER JOIN orders o
    ON s.store_id = o.store_id

INNER JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY 
    s.store_id,
    s.store_name

ORDER BY total_revenue DESC
LIMIT 1;


# Challenge 05
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS order_count
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.full_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

# Challenge 06
SELECT 
    e.emp_id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employees e
INNER JOIN employees m
    ON e.manager_id = m.emp_id
WHERE CONCAT(m.first_name, ' ', m.last_name) = 'Aarav Sharma';


# Challenge 07
SELECT 
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


# Challenge 08
SELECT 
    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
    ) / COUNT(DISTINCT o.order_id) AS average_order_value

FROM orders o

INNER JOIN order_items oi
    ON o.order_id = oi.order_id;
    
    
# Challenge 09
SELECT 
    SUM(oi.discount_amount) AS total_discounts,

    SUM(
        oi.quantity * oi.unit_sale_price
    ) AS gross_sales,

    (
        SUM(oi.discount_amount)
        /
        NULLIF(
            SUM(oi.quantity * oi.unit_sale_price),
            0
        )
    ) * 100 AS discount_percentage

FROM order_items oi;



# Challenge 10
SELECT 
    s.store_name,
    s.city,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    SUM(oi.quantity) AS units_sold,
    SUM(
        oi.quantity * oi.unit_sale_price
    ) AS gross_sales,

    SUM(
        oi.discount_amount
    ) AS discounts,

    SUM(
        oi.quantity * oi.unit_sale_price
        - oi.discount_amount
    ) AS net_revenue

FROM stores s
INNER JOIN orders o
    ON s.store_id = o.store_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE s.is_active = 1
GROUP BY 
    s.store_id,
    s.store_name,
    s.city
ORDER BY net_revenue DESC;