# Urban Food Waste & Surplus Redistribution Analysis

## 1. Project Overview

This project uses MySQL to analyze restaurant food surplus, identify categories with high surplus, compare restaurant-level performance, and examine daily surplus trends.

## 2. Restaurant-Wise Surplus Analysis

| Restaurant       | Total Surplus (kg) |
| ---------------- | -----------------: |
| Annapoorna Hotel |              2,658 |
| Royal Biryani    |              1,720 |
| Spice Garden     |              1,665 |
| Food Street      |                105 |
| Green Leaf       |                 65 |

### Key Insight

Annapoorna Hotel recorded the highest total surplus at 2,658 kg, followed by Royal Biryani at 1,720 kg and Spice Garden at 1,665 kg.

These restaurants could be prioritized for further investigation into food preparation quantities and demand forecasting.

## 3. Food Category Analysis

| Food Category | Total Surplus (kg) | Surplus Percentage |
| ------------- | -----------------: | -----------------: |
| Bread         |                135 |                75% |

### Key Insight

The category analysis returned Bread with 135 kg of surplus and a reported surplus percentage of 75%.

The calculation and category-ranking logic should be validated before drawing broader conclusions about the highest-surplus food category.

## 4. Restaurant Surplus Percentage

| Restaurant       | Prepared Food (kg) | Surplus (kg) | Surplus Percentage |
| ---------------- | -----------------: | -----------: | -----------------: |
| Annapoorna Hotel |              6,020 |        2,658 |             44.15% |
| Royal Biryani    |              4,210 |        1,720 |             40.86% |
| Spice Garden     |              4,100 |        1,665 |             40.61% |
| Food Street      |                320 |          105 |             32.81% |
| Green Leaf       |                230 |           65 |             28.26% |

### Key Insight

All five restaurants recorded a surplus percentage above 20%.

Annapoorna Hotel had the highest reported surplus percentage at 44.15%. Restaurant managers could review production planning and demand forecasting to understand the causes of these surplus levels.

Recorded surplus does not necessarily mean all the food was discarded.

## 5. Daily Surplus Trend Analysis

* Highest recorded daily surplus: 800 kg on 10 December 2026.
* Second-highest recorded daily surplus: 740 kg on 10 November 2026.
* Third-highest recorded daily surplus: 550 kg on 5 May 2026.
* Lowest recorded daily surplus: 10 kg on 15 May 2027.
* Number of distinct recorded dates: 42.
* Dataset date range: 1 January 2026 to 15 May 2027.

### Key Insight

Daily surplus varied considerably, ranging from 10 kg to 800 kg in the supplied results.

High-surplus dates could be investigated to identify potential opportunities for improved production planning and surplus redistribution.

## 6. Tools and SQL Concepts

* MySQL
* SELECT and WHERE
* GROUP BY and ORDER BY
* Aggregate functions
* JOIN operations
* Subqueries
* CASE expressions
* Percentage calculations
* Date-based analysis

## 7. Recommendations

1. Investigate the reasons for high-surplus days.
2. Review production planning at restaurants with high surplus percentages.
3. Explore redistribution opportunities for safe, edible surplus food.
4. Validate food-category percentage calculations.
5. Build a Power BI dashboard to visualize restaurant performance, food categories, and daily trends.

## 8. Data Limitations

* The analysis is based on the records available in the project database.
* The dataset includes dates extending into the future relative to October 2026. Confirm whether these are simulated or planned records before interpreting them as historical results.
* Surplus is not necessarily equivalent to discarded food.
* The results describe the supplied data and should not automatically be generalized to all restaurants.

## 9. Project Status

* [x] Database created
* [x] SQL analysis queries completed
* [x] SQL file uploaded to GitHub
* [x] Initial findings documented
* [ ] Power BI dashboard
* [ ] Dashboard screenshots and project documentation
* [ ] Final portfolio and resume integration
