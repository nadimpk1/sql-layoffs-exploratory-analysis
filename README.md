# Layoffs Exploratory Data Analysis (SQL)

## Project Overview

This project performs exploratory data analysis on a layoffs dataset using SQL.  
The objective is to analyze trends in layoffs across companies, industries, countries, and time periods.

By applying SQL aggregation, window functions, and analytical queries, the project explores patterns in workforce reductions and highlights trends that could be relevant for business analysis and economic insights.

---

## Dataset

The dataset contains information about layoffs reported by companies across multiple industries and locations.

Key columns in the dataset include:

- **company** – Name of the company
- **location** – City or region where layoffs occurred
- **industry** – Industry sector of the company
- **total_laid_off** – Number of employees laid off
- **percentage_laid_off** – Percentage of workforce affected
- **date** – Date when layoffs occurred
- **stage** – Funding stage of the company
- **country** – Country where the company operates
- **funds_raised_millions** – Total funding raised by the company

The analysis is performed on the cleaned dataset created in the previous data cleaning project.

---

## Analysis Objectives

The exploratory analysis aims to answer questions such as:

- Which companies experienced the largest layoffs?
- Which countries had the highest total layoffs?
- How have layoffs changed over time?
- Which company stages experienced the most layoffs?
- Which companies had the highest layoffs each year?

---

## SQL Skills Demonstrated

This project demonstrates analytical SQL techniques commonly used in data analysis workflows:

- Aggregations using **SUM** and **AVG**
- Time-based analysis using **YEAR()**
- Grouping and ordering data
- Window functions such as **DENSE_RANK**
- **Common Table Expressions (CTEs)**
- Rolling totals using window functions
- Identifying trends in datasets

---

## Tools Used

- SQL (MySQL dialect)
- GitHub for version control and project sharing

---

## Example Query

Example query used to calculate the rolling total of layoffs over time:

```sql
WITH Rolling_Total AS (
SELECT
SUBSTRING(date,1,7) AS month,
SUM(total_laid_off) AS monthly_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(date,1,7) IS NOT NULL
GROUP BY month
)

SELECT
month,
monthly_layoffs,
SUM(monthly_layoffs) OVER(ORDER BY month) AS rolling_total_layoffs
FROM Rolling_Total;
```

---

## Key Insights

Several insights were derived from the analysis of the agricultural production dataset:

- Certain companies experienced significantly larger layoffs compared to others.
- Layoffs vary considerably across industries and funding stages.
- Some companies reported laying off their entire workforce.
- Layoffs show noticeable fluctuations across different years and months.
- Ranking companies by layoffs each year highlights which organizations were most impacted during specific periods.

---

## Data Source

The layoffs dataset used in this project is derived from the dataset used in the SQL Data Cleaning and Analysis tutorials by Alex The Analyst.

The dataset is used for educational purposes to practice SQL data analysis and exploratory techniques.

---

## Course Context

This project was completed while following the Exploratory Data Analysis in SQL tutorial from the Alex The Analyst YouTube channel.

The tutorial demonstrates how SQL can be used to explore datasets, identify patterns, and generate analytical insights.

---

## Author

Nadim Abdu Nassar

Business Analyst | SQL | Excel | Power BI

GitHub: https://github.com/nadimpk1
