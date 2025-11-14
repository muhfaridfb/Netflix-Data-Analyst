-- Solutions of Business Problems --
-- Business Problems --

/*1. Count Total Movies and TV Shows*/
SELECT
	type,
	COUNT(*) AS total_conttent
FROM netflix
GROUP BY type;

/*2. Find the Most Frequent Rating for Movies and TV Shows*/
SELECT 
    type,
    rating,
    COUNT(*) AS total
FROM netflix
GROUP BY type, rating
ORDER BY total DESC;

/*3. List All Movies Released in a Given Year (e.g., 2021)*/
SELECT *
FROM netflix 
WHERE type = 'Movie'
	AND release_year = 2021;
	
/*Find Top 5 Countries With the Most Titles*/
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY country_name
ORDER BY total_titles DESC
LIMIT 5;

/*5. Identify the Movie With the Longest Duration*/ KURANG
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) DESC
LIMIT 1;

/*6. Find Content Added in the Last 5 Years*/
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'DD-Mon-YY') >= CURRENT_DATE - INTERVAL '5 years';

/*7. List All Content Directed by a Specific Person (e.g., ‘Mike Flanagan’)*/
SELECT *
FROM netflix
WHERE director ILIKE '%Mike Flanagan%';


/*8. Find All TV Shows With More Than 3 Seasons*/
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 3;

/*9. Count Number of Titles per Genre*/
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY genre
ORDER BY total_titles DESC;

/*10. Find the Top 5 Years With the Highest Average Content Releases in India*/
SELECT 
    release_year,
    COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC
LIMIT 5;

/*11. List All Documentary Movies*/
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND listed_in ILIKE '%Documentaries%';

/*12. Find All Content Without a Listed Director*/
SELECT *
FROM netflix
WHERE director IS NULL
   OR director = '';

/*13. Count How Many Movies an Actor (e.g., 'Salman Khan') Appeared in the Last 10 Years*/
SELECT COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
  AND cast ILIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

/*14. Top 10 Most Frequent Actors in Indian Movies*/
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(cast, ','))) AS actor,
    COUNT(*) AS total_titles
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY actor
ORDER BY total_titles DESC
LIMIT 10;

/*15. Categorize Content as "Family Friendly" or "Non-Family" Based on Rating*/
SELECT 
    CASE 
        WHEN rating IN ('G', 'PG', 'PG-13', 'TV-Y', 'TV-Y7', 'TV-G') THEN 'Family Friendly'
        ELSE 'Non-Family'
    END AS category,
    COUNT(*) AS total
FROM netflix
GROUP BY category;
