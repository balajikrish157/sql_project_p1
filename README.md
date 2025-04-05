# Retail Sales SQL Analysis Project

## 📊 Project Overview

This SQL project focuses on analyzing a fictional retail sales dataset to derive insights related to customer behavior, category performance, time-based trends, and business operations. The dataset includes transactional data such as date, time, customer ID, product category, quantity, price, and total sale value.

---

## 🗃️ Dataset Structure

**Table Name:** `retail_sales`

| Column           | Data Type     | Description                               |
| ---------------- | ------------- | ----------------------------------------- |
| transactions\_id | INT           | Unique transaction identifier             |
| sale\_date       | DATE          | Date of the transaction                   |
| sale\_time       | TIME          | Time of the transaction                   |
| customer\_id     | INT           | Unique ID of the customer                 |
| gender           | VARCHAR(10)   | Gender of the customer                    |
| age              | INT           | Age of the customer                       |
| category         | VARCHAR(50)   | Product category (e.g., Clothing, Beauty) |
| quantity         | INT           | Quantity sold                             |
| price\_per\_unit | DECIMAL(10,2) | Price per item                            |
| cogs             | DECIMAL(10,2) | Cost of goods sold                        |
| total\_sale      | DECIMAL(10,2) | Total revenue from transaction            |

---

## 🔍 Data Cleaning

- Checked for NULL values in all columns.
- Verified data consistency.

```sql
SELECT * FROM retail_sales
WHERE
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
```

---

## 🔎 Data Exploration Queries

### 1. Total Transactions

```sql
SELECT COUNT(*) AS total_sale FROM retail_sales;
```

### 2. Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
```

### 3. Product Categories

```sql
SELECT DISTINCT category FROM retail_sales;
```

---

## 🧠 Business Problem Solving with SQL

### Q1: Sales on a Specific Date

Retrieve all sales made on '2022-11-05'.

```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

### Q2: Clothing Transactions with High Quantity in Nov 2022

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
AND quantity > 3;
```

### Q3: Total Sales by Category

```sql
SELECT category, SUM(total_sale) AS totalsales, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### Q4: Average Age of Beauty Category Customers

```sql
SELECT category, ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### Q5: Transactions with High Total Sales

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

### Q6: Transaction Count by Gender and Category

```sql
SELECT category, gender, COUNT(transactions_id) AS transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### Q7: Average Sales Per Month & Best Selling Month by Year

```sql
SELECT YEAR, MONTH, avg_revenue FROM
(
    SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month,
           AVG(total_sale) AS avg_revenue,
           RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranks
    FROM retail_sales  
    GROUP BY YEAR, MONTH
) AS t1
WHERE ranks = 1;
```

### Q8: Top 5 Customers by Total Sale

```sql
SELECT customer_id, SUM(total_sale) AS Highest_Sale
FROM retail_sales
GROUP BY customer_id
ORDER BY Highest_Sale DESC
LIMIT 5;
```

### Q9: Unique Customers per Category

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

### Q10: Orders by Time Shift (Morning, Afternoon, Evening)

```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

## 📌 Insights (Sample)

- Most sales are generated in the **Afternoon** time slot.
- **Clothing** is the top-selling category by both volume and revenue.
- The best-performing months differ by year, based on average monthly revenue.
- A few **repeat customers** generate significantly high revenue.

---

## 🧾 Final Notes

This project showcases real-world data exploration and business query solving using SQL. It can be extended with visualizations using Tableau, Power BI, or Python libraries like Matplotlib/Seaborn.

---

## 🚀 How to Use

1. Load the dataset into your MySQL server.
2. Run the table creation and data exploration scripts.
3. Explore insights by running business problem queries.

Feel free to fork and star this repo if you found it helpful! ⭐

---

Author: Balaji Krishna
