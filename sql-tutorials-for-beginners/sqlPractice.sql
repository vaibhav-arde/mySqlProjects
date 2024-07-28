use moviesdb;
SELECT * FROM actors;
select * from movies;
select count(*) from movies;
select distinct industry from movies;
select * from movies where title like "%THOR%";
select * from movies where studio ="";
select * from movies where imdb_rating >9;
select * from movies where imdb_rating >= 6 and imdb_rating <= 8;
select * from movies where imdb_rating between 6 and 8;
select * from movies where release_year = 2022 or release_year = 2019;
select * from movies where release_year in (2022, 2019);
select * from movies where imdb_rating is NULL;
select * from movies where imdb_rating is not NULL;
select * from movies where industry = "Bollywood" order by imdb_rating desc;

# Summary Analytics
-- (MIN, MAX, AVG, Group By)-- 
select count(*) from movies where industry="bollywood";
select max(imdb_rating) from movies where industry="bollywood";
select min(imdb_rating) from movies where industry="bollywood";
select round(avg(imdb_rating),2) as avg_rating from movies where industry="bollywood";
select max(imdb_rating)as max_rating, min(imdb_rating)as min_rating, round(avg(imdb_rating),2) as avg_rating from movies where industry="bollywood";

select industry, count(*) from movies group by industry;
select studio, count(*)as cnt from movies group by studio order by cnt desc;
select industry, count(industry), round(avg(imdb_rating), 2) from movies group by industry;
select studio, count(studio), round(avg(imdb_rating), 2)as avg_rating from movies group by studio order by avg_rating desc;

# Having Clause
-- Calculated columns

select release_year, count(*) as movies_count from movies
group by release_year having movies_count > 2 order by movies_count desc;

-- FROM --> WHERE --> GROUP BY --> HAVING --> ORDER BY -->
-- WHERE -- column on which where is applied that no need to be in select
-- HAVING -- column on which HAVING is applied that has to be in select, column used in HAVING is mostly derived column.

select * , (YEAR(CURDATE())- birth_year) as age from actors order by age DESC;

select *, (revenue - budget) as profit from financials;

select * , IF(currency='USD', profit * 80, profit) as profit_inr from 
(
	select *, (revenue - budget) as profit from financials
)t;

select distinct currency from financials;
select distinct unit from financials;
select * from financials;

select *,
	CASE
		WHEN unit ="Billions" THEN revenue/1000
        WHEN unit ="Thousands" THEN revenue*1000
        ELSE revenue
    END as revenue_mln
FROM financials;
    
# SQL Joins
-- Inner Join : recods available in both tables
select * from movies;
select * from financials;
select * from movies m JOIN financials f on m.movie_id = f.movie_id;
select * from movies m 
INNER JOIN financials f on m.movie_id = f.movie_id;

-- Left Join : table name immediate to FROM is left table, it will show all values of left table though its missing in right
select * from movies m 
LEFT JOIN financials f on m.movie_id = f.movie_id;

-- RIGHT Join : table name immediate to JOIN is right table, it will show all values of right table though its missing in left
select * from movies m 
RIGHT JOIN financials f on m.movie_id = f.movie_id;

-- FUll JOIN/ FUll OUTER JOIN : Show all values post join it inclue Inner Join, Left Join and RIGHT Join as well.
select * from movies m 
LEFT JOIN financials f on m.movie_id = f.movie_id

UNION

select * from movies m 
RIGHT JOIN financials f on m.movie_id = f.movie_id;