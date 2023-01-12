SELECT *
FROM `edu vs income`.`us counties - education vs per capita personal income`;

/* aya lezzzzz gooo */

/* remove state from county */

SELECT SUBSTRING_INDEX(county, ',', 1) AS county_edited
FROM `edu vs income`.`us counties - education vs per capita personal income`;

/* create new county column */

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
ADD COLUMN county_edited varchar(255);

/* now move new column next to the county column */

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
CHANGE county_edited county_edited varchar(255) after county;

/* fill column with values */

UPDATE `edu vs income`.`us counties - education vs per capita personal income`
SET county_edited = SUBSTRING_INDEX(county, ',', 1);

/* delete old county column */

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
DROP COLUMN county;

/* states and the number of counties listed */

SELECT state, COUNT(state)
FROM `edu vs income`.`us counties - education vs per capita personal income`
GROUP BY state
ORDER BY 2 DESC;

/* move county column next county FIPS */

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
CHANGE county_edited county_edited VARCHAR(255) AFTER county_FIPS;

/* check for duplcate FIPS codes */

SELECT county_FIPS, COUNT(county_FIPS)
FROM `edu vs income`.`us counties - education vs per capita personal income`
GROUP BY county_FIPS
HAVING COUNT(county_FIPS) = 1;

/* find the population of the counties(rounded off to the nearest whole number) from 2016 to 2020
-assuming associate degree % was calculated by (total number of associate degrees/ total population) 
and nobody holds both a bachelors and associates degree */

SELECT county_edited, ROUND((100 * associate_degree_numbers_2016_2020) / associate_degree_percentage_2016_2020, 0) AS county_population
FROM `edu vs income`.`us counties - education vs per capita personal income`;

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
ADD county_population VARCHAR(255) AFTER county_edited;

UPDATE `edu vs income`.`us counties - education vs per capita personal income`
SET county_population = ROUND((100 * associate_degree_numbers_2016_2020) / associate_degree_percentage_2016_2020, 0);

/* accuracy check for popu.ation */

SELECT county_edited, (associate_degree_numbers_2016_2020 + bachelor_degree_numbers_2016_2020) AS deg_total
FROM `edu vs income`.`us counties - education vs per capita personal income`
WHERE (associate_degree_numbers_2016_2020 + bachelor_degree_numbers_2016_2020) > county_population;

/* find average per capita personal income(PCPI) */

SELECT state, county_edited, ROUND((per_capita_personal_income_2019 + per_capita_personal_income_2020 + per_capita_personal_income_2021) / 3, 0) AS avg_PCPI_2019_to_2021
FROM `edu vs income`.`us counties - education vs per capita personal income`;

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
ADD avg_PCPI_2019_to_2021 INT AFTER per_capita_personal_income_2021;

UPDATE `edu vs income`.`us counties - education vs per capita personal income`
SET avg_PCPI_2019_to_2021 = ROUND((per_capita_personal_income_2019 + per_capita_personal_income_2020 + per_capita_personal_income_2021) / 3, 0);

/* find % of county population with degree */

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
ADD deg_total INT AFTER bachelor_degree_numbers_2016_2020;

UPDATE `edu vs income`.`us counties - education vs per capita personal income`
SET deg_total = (associate_degree_numbers_2016_2020 + bachelor_degree_numbers_2016_2020);

SELECT ROUND((deg_total / county_population) * 100, 2) AS percentage_of_county_with_deg
FROM `edu vs income`.`us counties - education vs per capita personal income`;

ALTER TABLE `edu vs income`.`us counties - education vs per capita personal income`
ADD percentage_of_county_with_deg DECIMAL AFTER deg_total;

UPDATE `edu vs income`.`us counties - education vs per capita personal income`
SET percentage_of_county_with_deg = ROUND((deg_total / county_population) * 100, 2);

SELECT *
FROM `edu vs income`.`us counties - education vs per capita personal income`;