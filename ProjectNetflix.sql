
CREATE TABLE netflix
(show_id VARCHAR(6),
type  VARCHAR(10),
title  VARCHAR (150),
director  VARCHAR (208),
Casts  VARCHAR (1000),
country  VARCHAR(150),
date_added VARCHAR(50),
release_year INT,
rating  VARCHAR(10),
duration  VARCHAR(15),
listed_in  VARCHAR(100),
description  VARCHAR(250)
);

SELECT * FROM netflix;

select count(*) as total_content 
from netflix; 
 


-- 1. count the number of movies vs TV shows

SELECT type, COUNT(*) as total_content 
FROM netflix 
GROUP BY type; 

-- 2. Find the most common rating in movies and tv shows.

SELECT
         type, rating, COUNT(*)			 
  FROM netflix
  GROUP BY 1, 2 
ORDER BY COUNT DESC


-- 3. List All Movies Released in a Specific Year (e.g., 2020)

SELECT * 
FROM netflix
WHERE release_year = 2020;

-- 4. Find the Top 5 Countries with the Most Content on Netflix

SELECT 
      UNNEST(STRING_TO_ARRAY(country, ',')),
      COUNT(*) AS total_content
  FROM netflix
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 5;

-- 5. Identify the Longest Movie

SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1):: INT DESC;

-- 6. Find content added in the last 5 years

SELECT *,
TO_DATE(date_added, 'Month dd, yyyy' )
FROM netflix
WHERE TO_DATE(date_added, 'Month dd, yyyy' ) >= CURRENT_DATE - INTERVAL '5 years';

SELECT CURRENT_DATE - INTERVAL '5 years';

-- 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

SELECT * FROM netflix
WHERE director LIKE '%Rajiv Chilaka%' ; 

-- 8. List All TV Shows with More Than 5 Seasons

SELECT * 
FROM (SELECT * FROM netflix WHERE type = 'TV Show')
WHERE SPLIT_PART(duration, ' ' , 1 ):: INT  >= 5 ; 

-- 9. Count the Number of Content Items in Each Genre

SELECT 
      UNNEST(STRING_TO_ARRAY(listed_in, ',')) ,
	  COUNT(*) 
	 FROM netflix
	 GROUP BY 1; 

-- 10.Find each year and the average numbers of content release in India on netflix.
     -- return

SELECT 
     EXTRACT ( YEAR FROM TO_DATE(date_added, 'Month dd,yyyy')),
	 COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1; 

-- 11. List All Movies that are Documentaries

SELECT * FROM netflix
WHERE type = 'Movie'
AND listed_in ILIKE '%Documentaries%';


-- 12. Find all content without a director

SELECT * FROM netflix
WHERE director IS NULL ; 

-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT * FROM 
    (SELECT *
     FROM netflix
     WHERE TO_DATE(date_added, 'Month dd, yyyy' ) >= CURRENT_DATE - INTERVAL '10 years' )
WHERE casts ILIKE '%salman khan%'; 

-- 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

SELECT
           UNNEST(STRING_TO_ARRAY(casts, ',')) ,
           COUNT(*) as i  
      FROM netflix
	  WHERE country ILIKE '%india'
      GROUP BY 1 
	  ORDER BY 2 DESC ;

	  
15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

SELECT 
    catagory,
	COUNT(*)
FROM
(SELECT *, 
  CASE
      WHEN 
         description ILIKE '% kill%' OR description ILIKE '%violence%'
		      THEN 'Bad content'
      ELSE 'Good content' 
  END catagory 		 
FROM netflix)
GROUP BY 1 ; 








