
/* ayaa lezzz goooo */

/* delete whisker columns */

ALTER TABLE `world_happiness_report`.`w h r 2017`
DROP COLUMN `Whisker.high`, 
DROP COLUMN `Whisker.low`;

/* check for null values in the whole table */

SELECT *
FROM `world_happiness_report`.`w h r 2017`
WHERE `Happiness.Score` IS NULL 
   OR `Economy..GDP.per.Capita.` IS NULL 
   OR `Economy..GDP.per.Capita.` IS NULL
   OR Family IS NULL
   OR `Health..Life.Expectancy.` IS NULL
   OR Freedom IS NULL
   OR Generosity IS NULL
   OR `Trust..Government.Corruption.`IS NULL
   OR `Dystopia.Residual` IS NULL;
   
/* checking for duplicate countries */
   
SELECT Country, COUNT(Country)
FROM `world_happiness_report`.`w h r 2017`
GROUP BY Country
HAVING COUNT(Country) > 1;

/* shorten some long column names */

ALTER TABLE `world_happiness_report`.`w h r 2017`
CHANGE `Economy..GDP.per.Capita.` GDP_per_capita DECIMAL(15, 14),
CHANGE `Health..Life.Expectancy.` Life_expectancy DECIMAL(15, 14),
CHANGE `Trust..Government.Corruption.` Trust_Govt_Corruption DECIMAL(15, 14);

SELECT SUM(`Happiness.Score` * GDP_per_capita) - (SUM(`Happiness.Score`) * SUM(GDP_per_capita)) /
       SQRT(SUM(`Happiness.Score` * `Happiness.Score`) - (SUM(`Happiness.Score`) * SUM(`Happiness.Score`)) * 
       SUM(GDP_per_capita * GDP_per_capita) - (SUM(GDP_per_capita) * SUM(GDP_per_capita)))
       AS Correlation
FROM `world_happiness_report`.`w h r 2017`;
       
SELECT SUM(`Happiness.Score` - AVG(`Happiness.Score`)) * (GDP_per_capita - AVG(GDP_per_capita)) AS strd_dev_1
FROM `world_happiness_report`.`w h r 2017`;  

SELECT (`Happiness.Score` - AVG(`Happiness.Score`)) * (`Happiness.Score` - AVG(`Happiness.Score`)) AS strd_dev_2
FROM `world_happiness_report`.`w h r 2017`;     

SELECT (GDP_per_capita - AVG(GDP_per_capita)) * (GDP_per_capita - AVG(GDP_per_capita)) AS strd_dev_3
FROM `world_happiness_report`.`w h r 2017`;  

SELECT (`Happiness.Score` - (SELECT AVG(`Happiness.Score`) FROM `world_happiness_report`.`w h r 2017`)) * (GDP_per_capita - AVG(GDP_per_capita))
FROM `world_happiness_report`.`w h r 2017`
GROUP BY `Happiness.Score`;

SELECT `Happiness.Score` - (SELECT AVG(`Happiness.Score`) FROM `world_happiness_report`.`w h r 2017`) AS sd_1
FROM `world_happiness_report`.`w h r 2017`;

SELECT GDP_per_capita - (SELECT AVG(GDP_per_capita) FROM `world_happiness_report`.`w h r 2017`) AS sd_2
FROM `world_happiness_report`.`w h r 2017`;

SELECT 
    SUM((`Happiness.Score` - AVG(`Happiness.Score`)) * (GDP_per_capita - AVG(GDP_per_capita))) / 
    (COUNT(`Happiness.Score`) * STDDEV(`Happiness.Score`) * STDDEV(GDP_per_capita)) 
    AS correlation
FROM `world_happiness_report`.`w h r 2017`;


ALTER TABLE `world_happiness_report`.`w h r 2017`
ADD sd_1 DECIMAL (15, 14);
 
SELECT sd_1 * sd_2 
FROM `world_happiness_report`.`w h r 2017`;

SELECT 
 SUM((sub1.`Happiness.Score` - sub2.avg_`Happiness.Score`) * (sub1.GDP_per_capita - sub2.avg_GDP_per_capita)) / 
 (sub2.count_`Happiness.Score` * sub2.stddev_`Happiness.Score` * sub2.stddev_GDP_per_capita) AS correlation
FROM `world_happiness_report`.`w h r 2017` sub1
JOIN (SELECT AVG(`Happiness.Score`) AS avg_column1, AVG(column2) AS avg_column2, STDDEV(column1) AS stddev_column1, STDDEV(column2) AS stddev_column2, COUNT(column1) AS count_column1
      FROM table_name) sub2
ON 1=1;

SELECT 
 SUM((sub1.`Happiness.Score` - sub2.avg_column1) * (sub1.GDP_per_capita - sub2.avg_column2)) / 
 (sub2.count_column1 * sub2.stddev_column1 * sub2.stddev_column2) AS correlation
FROM `world_happiness_report`.`w h r 2017` sub1
JOIN (
  SELECT 
   AVG(`Happiness.Score`) AS avg_column1,
   AVG(GDP_per_capita) AS avg_column2,
   STDDEV(`Happiness.Score`) AS stddev_column1,
   STDDEV(GDP_per_capita) AS stddev_column2,
   COUNT(`Happiness.Score`) AS count_column1
  FROM `world_happiness_report`.`w h r 2017`
) sub2
ON 1=1;
