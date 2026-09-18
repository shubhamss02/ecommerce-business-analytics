# E-Commerce Business Analytics

An end-to-end **E-Commerce Business Analytics** project using **SQL, Python, and Power BI** to analyze sales performance, customer behavior, product performance, and business trends.

The project focuses on answering practical business questions from raw e-commerce data and converting the analysis into actionable insights through an interactive Power BI report.

---

## 📌 Project Overview

E-commerce businesses generate large amounts of data across customers, orders, products, reviews, and user interactions.

The objective of this project is to analyze this data from multiple business perspectives and answer questions such as:

* Which customers generate the most revenue?
* How is revenue changing over time?
* Which products and categories contribute the most revenue?
* What is the distribution of order statuses?
* How can customers be segmented based on spending?
* Which products perform well within their categories?
* Which products have strong customer ratings?
* Which products receive high interest but relatively low purchases?
* What does the rolling revenue trend look like?

The analysis is divided into four major business areas:

**Overview → Sales → Products → Customers**

---

## 🛠️ Tools & Technologies

| Tool                 | Purpose                                                               |
| -------------------- | --------------------------------------------------------------------- |
| **SQL (PostgreSQL)** | Data analysis, business queries, aggregations, CTEs, window functions |
| **Python**           | Data exploration, cleaning, and customer analytics                    |
| **Pandas & NumPy**   | Data manipulation and analysis                                        |
| **Matplotlib**       | Exploratory visualizations                                            |
| **Power BI**         | Interactive business dashboard and reporting                          |
| **GitHub**           | Project documentation and version control                             |

---

## 📂 Dataset

The project contains six related datasets:

| Dataset           |   Rows | Description                                             |
| ----------------- | -----: | ------------------------------------------------------- |
| `users.csv`       | 10,000 | Customer information                                    |
| `products.csv`    |  2,000 | Product, category, brand, price, and rating information |
| `orders.csv`      | 20,000 | Order-level information                                 |
| `order_items.csv` | 43,525 | Individual items within orders                          |
| `reviews.csv`     | 15,000 | Customer product reviews and ratings                    |
| `events.csv`      | 80,000 | Customer product interaction events                     |

### Main Relationships

```text
Users
  │
  ├────────────── Orders
  │                  │
  │                  └────────────── Order Items
  │                                      │
  │                                      └──────── Products
  │
  ├────────────── Reviews ─────────────── Products
  │
  └────────────── Events ──────────────── Products
```

---

# 🔍 Analysis Workflow

The project follows an end-to-end analytics workflow:

```text
Raw Data
   ↓
Data Exploration & Cleaning
   ↓
SQL Business Analysis
   ↓
Python Customer Analysis
   ↓
Power BI Data Modeling & DAX
   ↓
Interactive Business Report
   ↓
Business Insights
```

---

# 1. SQL Analysis

SQL was used to answer business questions that required aggregations, joins, CTEs, ranking, segmentation, and window functions.

### Key Analysis Areas

### Customer Revenue

Identified the customers generating the highest revenue by joining customers with completed orders and ranking customers based on total revenue.

### Revenue Trend & MoM Growth

Calculated monthly revenue and compared each month with the previous month using the `LAG()` window function to identify month-over-month revenue changes.

### Product & Category Performance

Analyzed revenue contribution by:

* Individual products
* Product categories
* Products within each category

### Customer Segmentation

Customers were divided into four spending groups:

```text
Platinum
Gold
Silver
Bronze
```

The segmentation uses `NTILE(4)` to divide customers into four groups according to total spending.

### Product Ranking

Used window functions to identify the **Top 3 products within each category** based on revenue.

### Product Ratings

Analyzed average customer ratings while applying a minimum review-count threshold to avoid relying on products with very few reviews.

### Product Interest vs Purchases

Compared customer interaction events such as:

```text
View
Cart
```

against completed purchases to identify products receiving significant customer interest but relatively low purchasing activity.

### Rolling Revenue

Calculated a **3-month rolling revenue trend** using a window frame to understand broader revenue movement rather than relying only on individual monthly values.

---

# 2. Python Analysis

Python was used for exploratory data analysis and customer-focused analysis.

### Libraries Used

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
```

The analysis included:

* Dataset inspection
* Shape and structure checks
* Data type validation
* Date conversion
* Customer-level analysis
* Exploratory analysis of the available datasets

The notebook works with:

```text
events
order_items
orders
products
reviews
users
```

---

# 3. Power BI Dashboard

The final analysis was converted into a multi-page Power BI business report.

The report follows a consistent layout and focuses on answering a different business question on each page rather than repeating the same visuals.

## 📊 Page 1 — Overview

### Business Question

**What is happening in the business?**

The Overview page provides an executive-level view of overall business performance.

It includes:

* Revenue
* Orders
* Customers
* Average Order Value
* Completed Orders
* Cancelled Orders
* Revenue Trend
* Revenue by Category
* Order Status Distribution
* Top Products

---

## 📈 Page 2 — Sales

### Business Question

**How are sales performing and changing over time?**

This page focuses on sales performance and revenue trends.

Key analysis areas include:

* Revenue performance
* Order performance
* Average Order Value
* Revenue trends
* Month-over-month growth
* Category performance
* Quarterly performance
* Sales trends over time

The page is designed to help understand both the current sales position and how performance is changing.

---

## 🛍️ Page 3 — Products

### Business Question

**Which products, categories, and brands are driving performance?**

The Products page analyzes product-level performance.

Key analysis areas include:

* Product revenue
* Category revenue
* Brand performance
* Top-performing products
* Top-performing brands
* Product ratings
* Revenue vs customer rating
* Product-level performance within categories

This helps identify products that contribute significantly to business revenue as well as products with strong customer reception.

---

## 👥 Page 4 — Customers

### Business Question

**How are customers behaving and contributing to the business?**

The Customers page focuses on customer value and behavior.

Key analysis areas include:

* Customer revenue
* Customer spending
* Customer segmentation
* High-value customers
* Customer distribution
* Customer purchasing behavior

Customers are segmented into:

```text
Platinum → Gold → Silver → Bronze
```

based on their spending.

---

# 🧮 SQL & DAX Concepts Used

### SQL

The project demonstrates practical SQL concepts including:

* `SELECT`
* `JOIN`
* `LEFT JOIN`
* `GROUP BY`
* `ORDER BY`
* `WHERE`
* `HAVING`
* `CASE`
* `CTE`
* Aggregate functions
* `LAG()`
* `ROW_NUMBER()`
* `NTILE()`
* Window functions
* Window frames
* `DATE_TRUNC()`
* `FILTER`
* `COALESCE()`

### Power BI / DAX

The Power BI report uses measures for business KPIs and analytical calculations such as:

* Revenue
* Orders
* Customers
* Average Order Value
* Completed Orders
* Cancelled Orders
* Revenue growth
* Product and category performance
* Customer-level metrics

---

# 💡 Key Business Questions

The project answers **10 core SQL business questions**:

1. Which customers generated the highest revenue?
2. How has company revenue changed month over month?
3. Which products contribute the most to total revenue?
4. Which product categories generate the highest revenue?
5. What percentage of orders falls under each order status?
6. How can customers be segmented based on total spending?
7. What are the Top 3 products within each category?
8. Which products have the highest average customer rating among products with at least 20 reviews?
9. Which products receive high customer interest but relatively low purchases?
10. What is the rolling 3-month revenue trend?

---

# 📁 Project Structure

```text
E-Commerce-Business-Analytics/
│
├── data/
│   ├── users.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── reviews.csv
│   └── events.csv
│
├── sql/
│   └── ecommerce.sql
│
├── python/
│   └── customer_analytics.ipynb
│
├── powerbi/
│   └── ecommerce_dashboard.pbix
│
├── screenshots/
│   ├── overview.png
│   ├── sales.png
│   ├── products.png
│   └── customers.png
│
└── README.md
```

---

# 🎯 Business Value

This project demonstrates how an analyst can move from raw transactional and behavioral data to business-focused reporting.

The analysis can help a business understand:

* Revenue performance
* Sales trends
* Product and category contribution
* Customer value
* Customer segmentation
* Product popularity
* Customer interest
* Product ratings
* Potential gaps between product interest and purchases

The goal is not simply to create visualizations, but to use data to answer specific business questions and support decision-making.

---

# 📌 What I Learned

Through this project, I practiced:

* Writing business-oriented SQL queries
* Working with multiple related datasets
* Using joins to combine transactional data
* Using CTEs for structured analysis
* Applying SQL window functions
* Performing customer segmentation
* Conducting exploratory analysis with Python
* Building DAX measures in Power BI
* Designing a multi-page business report
* Translating analytical results into business insights
* Building a portfolio project around realistic business questions

---

# 🚀 Future Improvements

Potential extensions to the analysis include:

* Customer retention analysis
* Purchase frequency analysis
* Conversion funnel analysis
* Repeat customer analysis
* Cohort analysis
* More detailed product conversion analysis

---

## 👨‍💻 Project Focus

**Core Skills Demonstrated:**

`SQL` · `Python` · `Pandas` · `Power BI` · `DAX` · `Data Analysis` · `Business Analytics` · `Data Visualization`

---

## ⭐ Project Summary

**E-Commerce Business Analytics** is an end-to-end analytics project that combines SQL, Python, and Power BI to transform e-commerce data into a business-focused analytical report.

The project covers four major perspectives:

**Overview → Sales → Products → Customers**

and demonstrates the complete process of exploring data, performing analysis, creating KPIs, identifying patterns, and presenting findings through an interactive Power BI report.
