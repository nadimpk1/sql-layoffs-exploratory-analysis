-- =========================================================
-- Layoffs Dataset Exploratory Data Analysis
-- Author: Nadim Abdu Nassar
-- Tool: MySQL
--
-- Objective:
-- Perform exploratory data analysis on the cleaned layoffs
-- dataset to identify patterns in layoffs across companies,
-- industries, countries, and time periods.
--
-- Dataset:
-- layoffs_staging2 (cleaned dataset)
-- =========================================================


-- ---------------------------------------------------------
-- 1. Explore dataset structure
-- ---------------------------------------------------------

SELECT *
FROM layoffs_staging2;



-- ---------------------------------------------------------
-- 2. Maximum layoffs and percentage laid off
-- ---------------------------------------------------------

SELECT
MAX(total_laid_off) AS max_layoffs,
MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_staging2;



-- ---------------------------------------------------------
-- 3. Companies where 100% of employees were laid off
-- ---------------------------------------------------------

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;



-- ---------------------------------------------------------
-- 4. Total layoffs by company
-- ---------------------------------------------------------

SELECT company,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;



-- ---------------------------------------------------------
-- 5. Identify time span of the dataset
-- ---------------------------------------------------------

SELECT
MIN(`date`) AS start_date,
MAX(`date`) AS end_date
FROM layoffs_staging2;



-- ---------------------------------------------------------
-- 6. Total layoffs by country
-- ---------------------------------------------------------

SELECT country,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;



-- ---------------------------------------------------------
-- 7. Layoffs by year
-- ---------------------------------------------------------

SELECT YEAR(`date`) AS year,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY year
ORDER BY year DESC;



-- ---------------------------------------------------------
-- 8. Layoffs by company stage
-- ---------------------------------------------------------

SELECT stage,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;



-- ---------------------------------------------------------
-- 9. Average percentage of layoffs by company
-- ---------------------------------------------------------

SELECT company,
AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY avg_percentage_laid_off DESC;



-- ---------------------------------------------------------
-- 10. Layoffs by month
-- ---------------------------------------------------------

SELECT
SUBSTRING(`date`,1,7) AS month,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month
ORDER BY month ASC;



-- ---------------------------------------------------------
-- 11. Rolling total of layoffs over time
-- ---------------------------------------------------------

WITH Rolling_Total AS (
SELECT
SUBSTRING(`date`,1,7) AS month,
SUM(total_laid_off) AS monthly_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month
)

SELECT
month,
monthly_layoffs,
SUM(monthly_layoffs) OVER(ORDER BY month) AS rolling_total_layoffs
FROM Rolling_Total;



-- ---------------------------------------------------------
-- 12. Layoffs by company and year
-- ---------------------------------------------------------

SELECT
company,
YEAR(`date`) AS year,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company, year
ORDER BY total_layoffs DESC;



-- ---------------------------------------------------------
-- 13. Top 5 companies with the most layoffs each year
-- ---------------------------------------------------------

WITH Company_Year AS (
SELECT
company,
YEAR(`date`) AS year,
SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company, year
),

Company_Year_Rank AS (
SELECT *,
DENSE_RANK() OVER(
PARTITION BY year
ORDER BY total_layoffs DESC
) AS ranking
FROM Company_Year
WHERE year IS NOT NULL
)

SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5;