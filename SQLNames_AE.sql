/*
SQL Names Assignment 
Abigail Ezell
*/

-- 1. How many rows are in the names table?
SELECT COUNT(*) 
FROM names;
-- There are 1,957,046 rows in the names table

-- 2. How many total registered people appear in the dataset?
SELECT SUM(num_registered) 
FROM names;
-- There are a total of 351,653,025 people registered in the dataset.

-- 3. Which name had the most appearances in a single year in the dataset?
select name, num_registered, year 
from names
order by num_registered DESC
limit 1;
-- Linda had the most appearances in a single year, with 99,689 registered Lindas in 1947.

-- 4. What range of years are included?
SELECT MIN(year), MAX(year)
FROM names;
-- The dataset contains years from 1880 to 2018.

-- 5. What year has the largest number of registrations?
SELECT year, SUM(num_registered) as totalreg
FROM names
GROUP BY year
ORDER BY totalreg DESC
LIMIT 1;
-- 1957 had the largest number of registrations, with 4,200,022 total registrations.

-- 6. How many different (distinct) names are contained in the dataset?
SELECT COUNT(DISTINCT name)
FROM names;
-- There are 98,400 unique names in the dataset. 

-- 7. Are there more males or more females registered?
SELECT gender, SUM(num_registered) as totalreg
FROM names
GROUP BY gender
ORDER BY totalreg DESC
LIMIT 1;
-- There are more males registered than females in the dataset.

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT DISTINCT ON (gender) gender, name, SUM(num_registered) as total_registered
FROM names
GROUP BY name, gender
ORDER BY gender, total_registered DESC;

-- The most popular male name overall is James; the most popular female name overall is Mary.

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT DISTINCT ON (gender) gender, name, SUM(num_registered) as total_registered
FROM names
WHERE year BETWEEN 2000 AND 2009
GROUP BY name, gender
ORDER BY gender, total_registered DESC;
-- The most popular boy name of 2000-2009 was Jacob; the most popular girl name during that time period was Emily.

-- 10. Which year had the most variety in names (i.e. had the most distinct names)?
SELECT year, COUNT(DISTINCT names) as distinctnames
FROM names
GROUP BY year
ORDER BY distinctnames DESC
LIMIT 1;
-- 2008 had the greatest number of distinct names, with 35,079 unique names registered.

-- 11. What is the most popular name for a girl that starts with the letter X?
SELECT name, sum(num_registered) as totalreg
FROM names
WHERE gender = 'F' AND name LIKE 'X%'
GROUP BY name
ORDER BY totalreg DESC;
-- The most popular name for a girl that starts with the letter X is Ximena.

-- 12. Write a query to find all (distinct) names that start with a 'Q' but whose second letter is not 'u'.
SELECT DISTINCT(name)
FROM names
WHERE name LIKE 'Q%' AND name NOT LIKE '_u%';

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, SUM(num_registered) as totalreg
FROM names
WHERE name IN ('Stephen', 'Steven')
GROUP BY name
ORDER BY totalreg DESC
LIMIT 1;
-- Steven is the more popular spelling.

-- 14. Find all names that are "unisex" - that is all names that have been used both for boys and for girls.
SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT gender) > 1;
-- There are 10,773 total unisex names in the dataset. 

-- 15. Find all names that have made an appearance in every single year since 1880.
SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = (2018-1880+1);
-- There are 921 total names that have made an appearance in every single year since 1880 in our dataset, such as Webster and Una.

-- 16. Find all names that have only appeared in one year.
SELECT name
FROM names
GROUP BY name
HAVING COUNT(year) = 1;
-- There are 21,100 names that have only appeared in one year, such as Irland and Dennita.

-- 17. Find all names that only appeared in the 1950s.
SELECT name
FROM names
GROUP BY name
HAVING MIN(year) >= 1950 AND MAX(year) <= 1959; 
-- There are 661 names that only appeared in the 1950s, such as Binky and Delba.

-- 18. Find all names that made their first appearance in the 2010s.
SELECT name
FROM names
GROUP BY name
HAVING MIN(year) >= 2010; 
-- There were 11,270 names that made their first appearance in the 2010s, such as Tynley and Michla.

-- 19. Find the names that have not be used in the longest.
SELECT name, MAX(year) as mostrecent
FROM names
GROUP BY name
ORDER BY mostrecent;
-- Zilpah and Roll have not been used in the longest, with the last appearance in 1881.

-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
-- Which boy and girl name from the 1800s was most popular in the 2010s?
SELECT name, gender, sum(num_registered) as totalreg
FROM names 
WHERE name IN (
SELECT name
FROM names
GROUP BY name
HAVING MIN(year) < 1900
) AND year >= 2010
GROUP BY name, gender
ORDER BY totalreg DESC;
-- The most popular girl name from the 1800s in the 2010s was Emma; the most popular boy name from the 1800s in the 2010s was Noah.


