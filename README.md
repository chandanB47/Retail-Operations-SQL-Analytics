# 🛒 Retail Operations SQL Analytics

> An end-to-end MySQL analytics project for analyzing retail customers, products, stores, sales, inventory, employees, discounts, profitability, and order fulfillment.

![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analytics-336791?style=for-the-badge)
![GitHub](https://img.shields.io/badge/GitHub-Portfolio-181717?style=for-the-badge&logo=github&logoColor=white)
![Status](https://img.shields.io/badge/Project-Completed-success?style=for-the-badge)

---

## 📌 Project Overview

**Retail Operations SQL Analytics** is an end-to-end MySQL project built around a realistic retail business environment.

The project combines relational database design, data cleaning, SQL analysis, and business problem solving to answer practical questions about:

- Customer behavior
- Product performance
- Store performance
- Sales and revenue
- Discounts
- Profitability
- Inventory
- Employee hierarchy
- Order fulfillment

The project progresses from SQL fundamentals to business-oriented analytical queries.

---

## 🎯 Business Problem

A retail company needs to understand how its customers, products, stores, employees, and orders are performing.

This project answers questions such as:

- Which customers are inactive?
- Which customers place repeat orders?
- Which products generate the highest net revenue?
- Which categories generate the highest estimated profit?
- Which stores generate the highest revenue?
- How much revenue is affected by discounts?
- Which products have never appeared in an order?
- How quickly are orders fulfilled?
- What is the average order value?
- How are employees connected to their managers?

The objective is to transform operational retail data into structured business analysis using SQL.

---

# 🗄️ Database Architecture

The database contains **7 main tables**:

| Table | Purpose |
|---|---|
| `stores` | Retail store branches and locations |
| `employees` | Employees, salaries, stores, and manager hierarchy |
| `categories` | Product categories |
| `products` | Product catalog, pricing, cost, and inventory |
| `customers` | Customer profiles and contact information |
| `orders` | Customer orders and fulfillment information |
| `order_items` | Products, quantities, sale prices, and discounts |

### 🔗 Main Relationships

```text
stores
├── employees
└── orders

employees
└── manager_id → employees.emp_id

categories
└── products

customers
└── orders

orders
└── order_items

products
└── order_items
```

The employee table contains a self-referencing `manager_id` relationship, while orders connect customers and stores and order items connect orders with products.

---

# 📊 Business Analysis

## 👥 Customer Analytics

The project analyzes customer information and purchasing behavior.

Key analysis includes:

- Customer name standardization
- Email normalization
- Phone number normalization
- Customers with no orders
- Repeat customers
- Customer order frequency

---

## 🛍️ Product & Category Analytics

Product and category performance is analyzed using sales, pricing, cost, discount, and inventory information.

Key metrics include:

- Units sold
- Gross sales
- Discounts
- Net revenue
- Estimated profit
- Product revenue
- Products with no sales
- Inventory availability

---

## 🏪 Store Performance

Store-level analysis compares the performance of retail branches.

Analysis includes:

- Number of orders
- Units sold
- Gross sales
- Discounts
- Net revenue
- Revenue thresholds
- Active-store performance

---

## 🚚 Order Fulfillment

The project evaluates order fulfillment performance using order and shipping dates.

Analysis includes:

- Order date
- Shipped date
- Fulfillment days
- Fast delivery classification
- Standard/delayed delivery classification
- Orders that have not yet shipped

---

## 👔 Employee Hierarchy

Employee reporting structures are analyzed using a self-referencing relationship.

The analysis identifies:

- Employees
- Managers
- Reporting relationships
- Employee-store relationships

---

# 🔍 Core Business Questions

The project contains **7 core business questions**.

| Question | Business Analysis |
|---|---|
| Q1 | Standardize customer names, emails, and phone numbers |
| Q2 | Map employees to managers and stores |
| Q3 | Identify customers who have never placed an order |
| Q4 | Calculate fulfillment time and classify delivery performance |
| Q5 | Analyze category revenue, discounts, net revenue, and profitability |
| Q6 | Identify active stores meeting the revenue threshold |
| Q7 | Generate active-store and in-stock-product combinations |

---

# 🧠 Advanced Business Challenges

The project also contains **10 advanced challenges**:

1. Find the customer with the most orders.
2. Find the product with the highest net revenue.
3. Find the category with the highest estimated profit.
4. Find the store with the highest revenue.
5. Identify customers with more than one order.
6. Find employees reporting directly to a specific manager.
7. Identify products that have never appeared in an order.
8. Calculate average order value.
9. Calculate total discount percentage.
10. Create a complete store-level sales performance report.

These challenges use aggregation, joins, `GROUP BY`, `HAVING`, ordering, filtering, and business calculations.

---

# 🧮 Key Business Metrics

### Gross Sales

```text
Quantity × Unit Sale Price
```

### Net Revenue

```text
Gross Sales − Discounts
```

### Estimated Profit

```text
Net Revenue − Product Cost
```

### Average Order Value

```text
Total Net Revenue ÷ Number of Orders
```

### Discount Percentage

```text
Total Discounts ÷ Gross Sales × 100
```

---

# 🛠️ SQL Techniques Demonstrated

## SQL Fundamentals

- `SELECT`
- `WHERE`
- `ORDER BY`
- Aliases
- Filtering
- Sorting

## Data Cleaning

- `UPPER()`
- `LOWER()`
- `REPLACE()`
- String standardization

## Aggregation

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `HAVING`

## Joins

- `INNER JOIN`
- `LEFT JOIN`
- Anti-JOIN
- `SELF JOIN`
- `CROSS JOIN`

## Business Logic

- `CASE`
- `COALESCE`
- `DATEDIFF()`
- Revenue calculations
- Profit calculations
- KPI calculations

## Database Design

- Primary Keys
- Foreign Keys
- `NOT NULL`
- `UNIQUE`
- `CHECK`
- `DEFAULT`
- Composite Primary Keys
- Self-referencing relationships

---

# 📚 Project Scope

```text
37 SQL Analytical Tasks
        +
7 Business Questions
        +
10 Advanced Business Challenges
```

### Analytical progression

```text
SQL Fundamentals
       ↓
Data Cleaning
       ↓
Joins
       ↓
Aggregations
       ↓
Date & Conditional Analysis
       ↓
Advanced SQL
       ↓
Business Questions
       ↓
Business Analysis
```

---

# 📂 Repository Structure

```text
Retail-Operations-SQL-Analytics/
│
├── README.md
│
├── database/
│   └── Retail_Analytics_Table_Creations.sql
│
└── sql/
    ├── analytical_queries.sql
    └── Business_Questions.sql
```

> The SQL files can be organized into `database/` and `sql/` folders as the next repository cleanup step.

---

# 🚀 How to Run the Project

## Step 1 — Create the Database

Open **MySQL Workbench** or another MySQL-compatible SQL environment.

Run:

```sql
CREATE DATABASE IF NOT EXISTS retail_analytics;
USE retail_analytics;
```

The database setup script then creates the seven required tables, constraints, primary keys, foreign keys, and relationships.

## Step 2 — Run the Database Setup Script

Run:

```text
Retail_Analytics_Table_Creations.sql
```

This creates the database structure and inserts the project data.

## Step 3 — Run the Analytical Queries

Run:

```text
analytical_queries.sql
```

This contains the 37 SQL tasks covering fundamentals through advanced analytical queries.

## Step 4 — Run the Business Questions

Run:

```text
Business_Questions.sql
```

This contains the 7 core business questions and 10 advanced challenges.

---

# 💡 Business Value

This project demonstrates how SQL can be used to support real business analysis rather than only retrieve records.

The analysis can help a retail business understand:

- Revenue performance
- Customer engagement
- Product performance
- Store performance
- Profitability
- Discount impact
- Inventory gaps
- Fulfillment efficiency
- Employee reporting structures

The main objective is to convert **raw operational data into structured business insights**.

---

# 🎓 Skills Demonstrated

### Technical Skills

- MySQL
- SQL
- Relational Database Design
- Data Cleaning
- Data Analysis
- Git
- GitHub

### Analytical Skills

- Business problem solving
- KPI analysis
- Revenue analysis
- Customer analysis
- Product analysis
- Store performance analysis
- Profitability analysis
- Operational analysis

---

# 📌 Project Status

**Completed ✅**

This project demonstrates a progression from SQL fundamentals to advanced, business-oriented retail analytics.

---

# 👨‍💻 Author

## Chandan B

**Aspiring Data Analyst**

**Skills:** SQL • Power BI • Excel • Python • Data Analytics

GitHub: [@chandanB47](https://github.com/chandanB47)

---

⭐ If you find this project useful, consider giving the repository a star.
