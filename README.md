# Urban Food Waste & Surplus Redistribution Analysis

## Project Overview

This project uses SQL to analyze restaurant food surplus data and identify patterns in food waste. It focuses on restaurant-level performance, food categories, and surplus trends over time.

## Business Problem

Restaurants may prepare more food than they sell, resulting in surplus food and potential waste. Analyzing surplus data can help identify where waste is concentrated and support better food preparation and redistribution decisions.

## Project Objectives

* Analyze total food surplus by restaurant.
* Identify food categories contributing to surplus.
* Compare restaurant surplus performance.
* Analyze daily, weekly, and monthly surplus trends.
* Apply SQL techniques to extract actionable insights.

## Database Tables

* `restaurents` — Restaurant details.
* `food_categories` — Food category information.
* `food_surplus` — Prepared, sold, and surplus food quantities with dates.

## SQL Concepts Used

* Aggregate functions: `SUM()`, `AVG()`, `MAX()`
* Filtering and grouping: `WHERE`, `GROUP BY`, `HAVING`
* Joins and subqueries
* Common Table Expressions (CTEs)
* Window functions: `RANK()`, `ROW_NUMBER()`, `LAG()`, `LEAD()`
* Date functions
* Conditional logic using `CASE`
* NULL handling using `COALESCE()` and `NULLIF()`

## Tools

* MySQL
* GitHub

## Business Applications

The analysis can help restaurants monitor surplus quantities, recognize recurring waste patterns, and identify opportunities to improve food preparation and redistribution.

## Project Status

SQL analysis completed. Query results and validated business findings will be added as the project is documented.



## 📊 Power BI Dashboard

An interactive Power BI dashboard built to analyze restaurant food preparation, sales, and surplus.

### Dashboard Preview

![Power BI Dashboard](dashboard_screenshot.png)

### Key Features

* **KPI Cards:** Total food prepared, food sold, food surplus, and surplus percentage.
* **Restaurant-wise Analysis:** Compare food surplus across restaurants.
* **Category-wise Analysis:** Analyze surplus across different food categories.
* **Daily Trend Analysis:** Track food surplus over time.

### Tools & Technologies

* MySQL
* Microsoft Power BI
* DAX
* GitHub

### Project Files

* `food_waste_analysis.sql` — SQL queries used for analysis.
* `Urban_Food_Waste_Analysis.pbix` — Power BI dashboard file.
* `dashboard_screenshot.png` — Dashboard preview.

