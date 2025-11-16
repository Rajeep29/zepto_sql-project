📦 Zepto SQL Data Exploration & Cleaning Project

This project showcases end-to-end SQL data cleaning, exploration, and analysis performed on a dataset extracted from Zepto (online grocery delivery platform).
The goal was to clean the data, understand product trends, handle inconsistencies, and generate insights like top product categories, revenue estimation, discount analysis, and more.

🗂️ Project Overview

In this project, I:

✔ Created and managed a MySQL database
✔ Cleaned raw data (renaming columns, handling nulls, fixing inconsistent values)
✔ Converted paise to rupees
✔ Removed invalid records
✔ Explored the dataset using SQL
✔ Performed category-level, discount-level, inventory and revenue analysis

🛠️ Technologies Used

MySQL
SQL Commands: DDL, DML, Aggregate Functions, CASE statements, Data Cleaning Queries

📑 Steps Performed

1️⃣ Database Setup
create database zepto;
use zepto;

rename table zepto_v2 to zepto_details;

2️⃣ Data Cleaning

Renamed incorrect column names
Added an auto-incrementing sku_id primary key
Fixed encoding issues
Removed records with invalid prices
Converted price values from paise to rupees
Standardized and validated categories

alter table zepto_details
rename column ï»¿category to category;

alter table zepto_details
add column sku_id int auto_increment primary key first;

update zepto_details
set mrp = mrp/100.0,
    discountedSellingPrice = discountedSellingPrice/100.0;

🔍 Data Exploration & Analysis
✔ Count rows
✔ View sample data
✔ Identify NULL values
✔ Find distinct product categories
✔ Check in-stock vs out-of-stock products
✔ Detect duplicate product names
✔ Identify products with price = 0
✔ Analyze discounts and pricing
✔ Category-wise revenue
✔ High-MRP out-of-stock items
✔ Price-per-gram analysis
✔ Weight-based categorization (low / medium / bulk)

📊 Key Insights Generated
🔹 Top 10 Best-Value Products

Sorted using highest discount percentage.

🔹 Out-Of-Stock High-Value Items

Useful for inventory restocking decisions.

🔹 Category-Wise Revenue Estimation

select category, 
       sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto_details
group by category;

🔹 Weight-Based Product Categorization
Using CASE statement:

case 
  when weightInGms > 1000 then 'low'
  when weightInGms < 5000 then 'medium'
  else 'bulk'
end

🔹 Price Per Gram Ranking

Find best-value items based on weight efficiency.

🚀 What I Learned

✔ How to clean raw datasets in SQL
✔ Handling inconsistent column names & encoding errors
✔ Working with pricing & discounts
✔ Deriving insights through aggregation
✔ Performing EDA only using SQL (no Python/Excel)
