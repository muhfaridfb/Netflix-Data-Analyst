# Netflix-Data-Analyst

![Netflix-logo](https://github.com/muhfaridfb/Netflix-Data-Analyst/blob/main/netflixlogo.jpg)

## 📌 Overview
This project focuses on analyzing Netflix data using SQL. The dataset includes movies and TV shows from around the world. The main objective is to extract key insights related to content patterns, country activity, genres, actors, directors, and yearly release trends. The results provide a comprehensive overview of Netflix’s content strategy and help identify production patterns and market behavior.

## 🎯 Objectives

- Analyze the distribution of movies and TV shows.
- Identify the most common ratings.
- Explore trends by country and release year.
- Determine the most popular genres.
- Identify content with extreme durations.
- Categorize content based on keywords or patterns.
- Analyze contributions by directors, actors, and countries.

## 📂 Dataset

The data is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## 🗂️ Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## 📊 Business Problems and Solutions

### 1. Count Total Movies and TV Shows

```sql
SELECT type, COUNT(*) AS total_content
FROM netflix
GROUP BY type;
```

**Objective:** Measure content distribution by type.

### 2. Find the Most Frequent Rating

```sql
SELECT type, rating, COUNT(*) AS total
FROM netflix
GROUP BY type, rating
ORDER BY total DESC;
```

**Objective:** Objective: Identify the most commonly used ratings.

### 3. List All Movies Released in a Given Year (e.g., 2021)

```sql
SELECT *
FROM netflix 
WHERE type = 'Movie' AND release_year = 2021;
```

**Objective:** Objective: Retrieve movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
       COUNT(*) AS total_titles
FROM netflix
GROUP BY country_name
ORDER BY total_titles DESC
LIMIT 5;
```

**Objective:** Objective: Identify the most active content-producing countries.

### 5. Movie With the Longest Duration

```sql
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) DESC
LIMIT 1;
```

**Objective:** Find the longest movie duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'DD-Mon-YY') >= CURRENT_DATE - INTERVAL '5 years';
```

**Objective:** Analyze recent content additions.

### 7. Content Directed by a Specific Director

```sql
SELECT *
FROM netflix
WHERE director ILIKE '%Mike Flanagan%';
```

**Objective:** Retrieve content by certain directors 'Mike Flanagan'.

### 8. TV Shows With More Than 3 Seasons

```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 3;
```

**Objective:** Identify TV shows with more than 3 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre,
       COUNT(*) AS total_titles
FROM netflix
GROUP BY genre
ORDER BY total_titles DESC;
```

**Objective:** Measure genre popularity.

### 10.Top 5 Most Productive Years for Indian Content

```sql
SELECT release_year, COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC
LIMIT 5;
```

**Objective:** Identify peak production years for Indian content.

### 11. List All Movies that are Documentaries

```sql
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND listed_in ILIKE '%Documentaries%';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Content Without a Director

```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```

**Objective:** Find content missing director information.

### 13. Find Movies Featuring an Actor in the Last 10 Years

```sql
SELECT COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
  AND casts ILIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Track actor activity.

### 14. Find the Top 10 Most Frequent Actors in Indian Movies

```sql
SELECT TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
       COUNT(*) AS total_titles
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY actor
ORDER BY total_titles DESC
LIMIT 10;
```

**Objective:** Identify the most active actors.

### 15. Categorize Content as Family-Friendly vs Non-Family

```sql
SELECT 
    CASE 
        WHEN rating IN ('G', 'PG', 'PG-13', 'TV-Y', 'TV-Y7', 'TV-G')
        THEN 'Family Friendly'
        ELSE 'Non-Family'
    END AS category,
    COUNT(*) AS total
FROM netflix
GROUP BY category;
```

**Objective:** Classify content by rating category.

## Findings and Conclusion

- **Content Distribution:** Movies and TV shows are distributed fairly evenly, showing strong content variety.
- **Rating Insight:** The most common ratings reflect Netflix’s main target audiences.
- **Geographical Patterns:** India, the US, and the UK dominate content production.
- **Genre Popularity:** Dramas, International TV Shows, and Documentaries appear frequently.
- **Actor/Director Trends:** Many titles lack director data, but certain actors are dominant regionally.
- **Keyword Categorization:** Useful for identifying family-safe and violence-themed content.
- **Yearly Trends:** Peaks in content production occur during specific years.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.