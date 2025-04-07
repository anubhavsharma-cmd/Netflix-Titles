
-- ================================================
-- FULL SQL DATA ANALYSIS: Netflix Titles Dataset (MySQL Version)
-- Author: Anubhav Sharma
-- Source: netflix_titles.csv
-- ================================================

-- STEP 1: TABLE CREATION
DROP TABLE IF EXISTS netflix_titles;
CREATE TABLE netflix_titles (
    show_id VARCHAR(20) PRIMARY KEY,
    type VARCHAR(50),
    title VARCHAR(255),
    director TEXT,
    cast TEXT,
    country VARCHAR(100),
    date_added VARCHAR(100),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    listed_in TEXT,
    description TEXT
);

-- STEP 2: DATA IMPORT (via MySQL Workbench or LOAD DATA)
-- Example:
-- LOAD DATA INFILE 'path_to_csv/netflix_titles.csv'
-- INTO TABLE netflix_titles
-- FIELDS TERMINATED BY ','
-- OPTIONALLY ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- STEP 3: INITIAL EXPLORATION

-- 3.1: View structure
DESCRIBE netflix_titles;

-- 3.2: Sample data
SELECT * FROM netflix_titles LIMIT 10;

-- 3.3: Total records
SELECT COUNT(*) AS total_rows FROM netflix_titles;

-- 3.4: Count NULLs per column
SELECT
  SUM(CASE WHEN director IS NULL OR director = '' THEN 1 ELSE 0 END) AS null_director,
  SUM(CASE WHEN cast IS NULL OR cast = '' THEN 1 ELSE 0 END) AS null_cast,
  SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END) AS null_country,
  SUM(CASE WHEN date_added IS NULL OR date_added = '' THEN 1 ELSE 0 END) AS null_date_added,
  SUM(CASE WHEN rating IS NULL OR rating = '' THEN 1 ELSE 0 END) AS null_rating,
  SUM(CASE WHEN duration IS NULL OR duration = '' THEN 1 ELSE 0 END) AS null_duration
FROM netflix_titles;

-- STEP 4: DATA CLEANING

-- 4.1: Remove duplicate titles
DELETE FROM netflix_titles
WHERE show_id NOT IN (
    SELECT show_id FROM (
        SELECT MIN(show_id) AS show_id
        FROM netflix_titles
        GROUP BY title, type, release_year
    ) AS deduped
);

-- 4.2: Convert date format (MySQL version doesn't allow direct conversion if format is inconsistent)
-- Assume further standardization can be done in Tableau or scripts

-- 4.3: Replace NULLs and blanks with 'Unknown'
UPDATE netflix_titles SET director = 'Unknown' WHERE director IS NULL OR director = '';
UPDATE netflix_titles SET cast = 'Unknown' WHERE cast IS NULL OR cast = '';
UPDATE netflix_titles SET country = 'Unknown' WHERE country IS NULL OR country = '';
UPDATE netflix_titles SET date_added = 'Unknown' WHERE date_added IS NULL OR date_added = '';
UPDATE netflix_titles SET rating = 'Unknown' WHERE rating IS NULL OR rating = '';
UPDATE netflix_titles SET duration = 'Unknown' WHERE duration IS NULL OR duration = '';

-- STEP 5: FEATURE ENGINEERING

-- 5.1: Add and populate year_added
ALTER TABLE netflix_titles ADD COLUMN year_added INT;

UPDATE netflix_titles
SET year_added = CAST(LEFT(date_added, 4) AS UNSIGNED)
WHERE date_added != 'Unknown';

-- STEP 6: EXPLORATORY DATA ANALYSIS

-- 6.1: Movies vs TV Shows
SELECT type, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;

-- 6.2: Titles added per year
SELECT year_added, COUNT(*) AS titles_added
FROM netflix_titles
WHERE year_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- 6.3: Top 10 contributing countries
SELECT country, COUNT(*) AS total
FROM netflix_titles
WHERE country != 'Unknown'
GROUP BY country
ORDER BY total DESC
LIMIT 10;

-- 6.4: Content ratings distribution
SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
ORDER BY total DESC;

-- 6.5: Top 10 genres
SELECT listed_in, COUNT(*) AS genre_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY genre_count DESC
LIMIT 10;

-- 6.6: Average movie duration
SELECT 
    AVG(CAST(REPLACE(duration, ' min', '') AS UNSIGNED)) AS avg_movie_duration
FROM netflix_titles
WHERE type = 'Movie' AND duration LIKE '%min%';

-- 6.7: TV Show Season Count
SELECT 
    duration AS seasons,
    COUNT(*) AS show_count
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY duration
ORDER BY show_count DESC;

-- 6.8: Top 10 directors
SELECT director, COUNT(*) AS titles_directed
FROM netflix_titles
WHERE director != 'Unknown'
GROUP BY director
ORDER BY titles_directed DESC
LIMIT 10;

-- 6.9: Movie releases per year
SELECT release_year, COUNT(*) AS movie_count
FROM netflix_titles
WHERE type = 'Movie'
GROUP BY release_year
ORDER BY release_year DESC;

-- 6.10: Titles with multiple genres
SELECT COUNT(*) AS multi_genre_titles
FROM netflix_titles
WHERE listed_in LIKE '%,%,%';

-- ================================================
-- END OF MYSQL ANALYSIS SCRIPT
-- ================================================
