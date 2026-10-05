# 🛒 Milestone Project 01: Retail Store Operations & Analytics

## 📌 Project Overview

A comprehensive, end-to-end **MySQL relational database project** built
around a realistic retail store operations and analytics system.

This project applies SQL concepts including:

-   Relational database design
-   Primary and Foreign Keys
-   `NOT NULL`, `UNIQUE`, `CHECK`, and `DEFAULT` constraints
-   Data insertion and transactional records
-   Data cleaning and string manipulation
-   Date calculations
-   Aggregate functions
-   `GROUP BY` and `HAVING`
-   `INNER JOIN` and `LEFT JOIN`
-   Anti-JOIN logic
-   `SELF JOIN`
-   `CROSS JOIN`
-   Business-oriented analytical queries

------------------------------------------------------------------------

## 🗄️ Database Structure

The project contains seven main tables:

  -----------------------------------------------------------------------
  Table                               Description
  ----------------------------------- -----------------------------------
  `stores`                            Retail store branches and locations

  `employees`                         Employees and manager hierarchy

  `categories`                        Product categories

  `products`                          Product catalog, pricing, cost, and
                                      inventory

  `customers`                         Customer profiles and contact
                                      information

  `orders`                            Customer orders and order status

  `order_items`                       Products, quantities, prices, and
                                      discounts within orders
  -----------------------------------------------------------------------

### 🔗 Main Relationships

``` text
stores
├── employees
└── orders

employees
└── manager_id → employees

categories
└── products

customers
└── orders

orders
└── order_items

products
└── order_items
```

------------------------------------------------------------------------

## 📚 Project Levels

### Level 1 → Level 8

**37 SQL Tasks**

Stored in:

``` text
analytical_queries.sql
```

Coverage:

-   Level 1 --- Task 01--07
-   Level 2 --- Task 08--11
-   Level 3 --- Task 12--15
-   Level 4 --- Task 16--18
-   Level 5 --- Task 19--24
-   Level 6 --- Task 25--29
-   Level 7 --- Task 30--32
-   Level 8 --- Task 33--37

### Level 9

**Business Questions Q1--Q7**

Stored in:

``` text
Business_Questions.sql
```

Topics include:

-   Customer data cleaning
-   Employee hierarchy
-   Inactive customers
-   Order fulfillment analysis
-   Category revenue and profit
-   Store performance
-   Product-store analysis

### Level 10

**Business Challenges 01--10**

Topics include:

-   Top customers
-   Top products
-   Category profitability
-   Store revenue
-   Repeat customers
-   Employee-manager relationships
-   Products with no sales
-   Average order value
-   Discount analysis
-   Store-level sales performance

------------------------------------------------------------------------

## 🎯 Key Analytical Problems Solved

### 1. Employee Hierarchy

Used `SELF JOIN` to analyze employee-manager relationships and reporting
structures.

### 2. Customer Analysis

Identified customers with no orders using `LEFT JOIN` and Anti-JOIN
logic.

### 3. Product & Category Analysis

Analyzed product sales, category revenue, discounts, costs, and
estimated profit.

### 4. Store Performance

Calculated store-level orders, units sold, gross sales, discounts, and
net revenue.

### 5. Order Fulfillment

Calculated shipping duration and categorized fulfillment performance
using date arithmetic and `CASE`.

### 6. Inventory Analysis

Identified products with zero stock and generated product-store
combinations using `CROSS JOIN`.

### 7. Business Analysis

Used aggregation, filtering, grouping, joins, and analytical SQL logic
to answer practical retail business questions.

------------------------------------------------------------------------

## 🛠️ Tools & Technologies

-   **Database:** MySQL
-   **Language:** SQL
-   **Version Control:** Git & GitHub
-   **SQL Environment:** MySQL-compatible SQL client

------------------------------------------------------------------------

## 📂 Project Files

``` text
Milestone_Project_01_Retail_Operations/
│
├── README.md
├── Task.md
├── Retail_Analytics_Table_Creations.sql
├── analytical_queries.sql
└── Business_Questions.sql
```

### File Purpose

  ----------------------------------------------------------------------------
  File                                     Purpose
  ---------------------------------------- -----------------------------------
  `README.md`                              Project documentation

  `Task.md`                                Project requirements and tasks

  `Retail_Analytics_Table_Creations.sql`   Database tables, relationships, and
                                           constraints

  `analytical_queries.sql`                 Level 1--8, Task 01--37

  `Business_Questions.sql`                 Level 9--10 business questions and
                                           challenges
  ----------------------------------------------------------------------------

------------------------------------------------------------------------

## 🚀 Execution Order

Run the SQL files in the following order.

### Step 1 --- Create the Database Structure

Run:

``` text
Retail_Analytics_Table_Creations.sql
```

This creates the required tables, relationships, and constraints.

### Step 2 --- Run Analytical Tasks

Run:

``` text
analytical_queries.sql
```

This contains:

**Level 1--8 → Task 01--37**

### Step 3 --- Run Business Questions

Run:

``` text
Business_Questions.sql
```

This contains:

**Level 9 → Q1--Q7**

**Level 10 → Challenge 01--10**

------------------------------------------------------------------------

## ✅ Skills Demonstrated

This project demonstrates practical SQL skills in:

-   Database and relational schema design
-   Constraints and relationships
-   Data cleaning
-   String manipulation
-   Date arithmetic
-   Aggregate functions
-   Grouping and filtering
-   Relational joins
-   Anti-JOIN logic
-   SELF JOIN
-   CROSS JOIN
-   Sales analysis
-   Customer analysis
-   Employee hierarchy analysis
-   Store performance analysis
-   Inventory analysis
-   Revenue and profitability analysis
-   Business-oriented SQL problem solving

------------------------------------------------------------------------

## 📌 Project Status

**Milestone Project 01 --- Completed ✅**
