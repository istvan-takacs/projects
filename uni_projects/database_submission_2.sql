/*5A*/
/*Ranking the countries from largest to smallest in terms of population while still ordering the output by country*/
SELECT country, "2012",
 RANK() OVER(order by "2012" DESC) AS Popl_rank_in_2012
FROM world.world_population
WHERE "2012" IS NOT NULL
ORDER BY country;

/*5B*/
/*Creating the set of countries that are top 20 populationwise in 2012*/
SELECT country FROM (SELECT country, "2012", RANK() OVER(ORDER BY "2012" DESC) AS Popl_rank_in_2012
FROM world.world_population
WHERE "2012" IS NOT NULL)
WHERE Popl_rank_in_2012 <= 20
MINUS -- Subtracting the sets of countries
/*Creating the set of countries that are top 20 populationwise in 1962*/
SELECT country FROM (SELECT country, "1962", RANK() OVER(ORDER BY "1962" DESC) AS Popl_rank_in_1962
FROM world.world_population
WHERE "1962" IS NOT NULL
ORDER BY Popl_rank_in_1962)
WHERE Popl_rank_in_1962 <= 20;

/*5C*/
/*Uses the LAG function to see how much 
the 5 smallest countries in the world would need to grow in terms of population size to move
‘up’ the population rankings table*/
SELECT pop_order, country, pop_2012, Larger_than
FROM
(
SELECT RANK() OVER(order by "2012") AS pop_order,
 country,
 to_char("2012" ,'999G999G999G990') pop_2012, --Converting the numbers into a more easily digestible format
 /*Taking the lagging country to calculate the number by which it would need to grow to move 'up' the population rankings*/
 to_char(LAG("2012", 1) over (order by "2012" DESC) - "2012",'999G999G999G999G999G990') Larger_than 
FROM world.world_population
Where "2012" is not null
ORDER BY pop_order
) x
where pop_order <6; -- Only the first 5 countries are diaplyed

/*5D*/
SELECT country, "2012",
       RANK() OVER(ORDER BY "2012" DESC) AS Popl_rank_in_2012,
       ROUND(("2012" / SUM("2012") OVER()) * 100, 2) AS Popl_percent
FROM world.world_population
WHERE "2012" IS NOT NULL
ORDER BY Popl_percent DESC;
/*This is a piece of code I have written as an extension of the first exercise to see if I could
add another column that calculates the percentage of the world population that a country occupies in comparison
to the sum of all countries.
This can be an interesting aspect as this not only allows for viewgin raw data but allows for the large numbers to be
put into perspective and percentages to be displayed.*/
