SELECT *
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

ALTER TABLE `2024 qs world university rankings 1.2 (for qs.com) (3)`
DROP COLUMN `MyUnknownColumn_[1]`;

ALTER TABLE `2024 qs world university rankings 1.2 (for qs.com) (3)` 
DROP COLUMN `MyUnknownColumn_[3]`, 
DROP COLUMN `MyUnknownColumn_[4]`, 
DROP COLUMN `MyUnknownColumn_[5]`, 
DROP COLUMN `MyUnknownColumn_[7]`, 
DROP COLUMN `MyUnknownColumn_[8]`, 
DROP COLUMN `MyUnknownColumn_[10]`, 
DROP COLUMN `MyUnknownColumn_[11]`, 
DROP COLUMN `MyUnknownColumn_[12]`, 
DROP COLUMN `MyUnknownColumn_[13]`, 
DROP COLUMN `MyUnknownColumn_[14]`, 
DROP COLUMN `MyUnknownColumn_[15]`, 
DROP COLUMN `MyUnknownColumn_[16]`, 
DROP COLUMN `MyUnknownColumn_[17]`, 
DROP COLUMN `MyUnknownColumn_[18]`, 
DROP COLUMN `MyUnknownColumn_[19]`, 
DROP COLUMN `MyUnknownColumn_[20]`, 
DROP COLUMN `MyUnknownColumn_[22]`, 
DROP COLUMN `MyUnknownColumn_[23]`, 
DROP COLUMN `MyUnknownColumn_[24]`, 
DROP COLUMN `MyUnknownColumn_[25]`;

ALTER TABLE `2024 qs world university rankings 1.2 (for qs.com) (3)`
CHANGE `2024 QS World University Rankings` `2024_Ranking` VARCHAR(200);

DESCRIBE `2024 qs world university rankings 1.2 (for qs.com) (3)`;

ALTER TABLE `2024 qs world university rankings 1.2 (for qs.com) (3)`
CHANGE MyUnknownColumn `2023 Ranking` VARCHAR(200),
CHANGE `MyUnknownColumn_[0]` Uni_Name VARCHAR(200),
CHANGE `MyUnknownColumn_[2]` Country VARCHAR(200),
CHANGE `MyUnknownColumn_[6]` `Status` VARCHAR(200),
CHANGE `MyUnknownColumn_[9]` Employer_Reputation VARCHAR(200),
CHANGE `MyUnknownColumn_[21]` Employment_Outcomes VARCHAR(200);

DELETE 
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE Country = 'location';

DELETE 
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE Uni_Name = 'Institution Name';

SELECT Status, COUNT(*)
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
GROUP BY Status ;

/*ALTER TABLE `2024 qs world university rankings 1.2 (for qs.com) (3)`
MODIFY COLUMN Employer_Reputation INT;
MODIFY COLUMN Employment_Outcomes INT;*/

ALTER TABLE `2024 qs world university rankings 1.2 (for qs.com) (3)`
DROP COLUMN Status;

SELECT /*Uni_Name,*/ Country, COUNT(Country) 
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE -- Employment_Outcomes > 79
/*OR*/ Employer_Reputation > 49
GROUP BY Country
ORDER BY COUNT(Country) DESC;

SELECT PI() AS Π;

SELECT ABS(-243);

SELECT CEILING(Employer_Reputation)
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT FLOOR(Employer_Reputation)
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT CEILING(AVG(Employer_Reputation))
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT AVG(Employer_Reputation)
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT FLOOR(AVG(Employer_Reputation))
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT ROUND(34.5);
SELECT CEILING(34.5);
SELECT FLOOR(34.5);

SELECT SQRT(9);

SELECT CEILING(39/12);

SELECT(39%12) AS Remainder;

SELECT CONCAT('HELLO',' ', 'Ф', ' ', 'WORLD') AS Greeting;

SELECT SUBSTRING(Country, 2, 6) AS `First 4 letters`
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
ORDER BY `First 4 letters`;

SELECT Country, COUNT(Uni_Name) AS 'No. of Unis' 
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE `2024_Ranking` < 1
GROUP BY Country
ORDER BY 'No. of Unis' DESC;

DESCRIBE `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT Country, LENGTH(Country)
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT *, UPPER(Uni_Name) 
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT *, LOWER(Uni_Name) 
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT CONCAT(UPPER(SUBSTRING(Uni_Name, 1, 1)), LOWER(SUBSTRING(Uni_Name, 2))) AS `Sentence Case`
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT Country, REPLACE(Country, 'United States', 'US') AS 'US-Shortened'
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT *, CASE WHEN Employer_Reputation > 89 THEN 'Perfect Uni'
               WHEN Employment_Outcomes > 89 THEN 'Perfect Uni'
               ELSE 'N/A'
          END  AS Rating   
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT *, COALESCE(Employment_Outcomes, 0.0)
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

UPDATE `2024 qs world university rankings 1.2 (for qs.com) (3)`
SET Employment_Outcomes = NULLIF(Employment_Outcomes, 1);

SELECT *, IF(2024_Ranking <= 6, 'Top Uni', 'Naah') AS Choice
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

DESCRIBE `2024 qs world university rankings 1.2 (for qs.com) (3)`;

SELECT DATEPART(year, (SELECT CURRENT_DATE)); -- CURTIME() AS TIME;

SELECT CURTIME();

SELECT Country, 
       AVG(Employer_Reputation) OVER (PARTITION BY Country ORDER BY Employer_Reputation) AS 'Best Reputation'
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

DELIMITER $$
CREATE PROCEDURE Best_Reputation()
BEGIN
     SELECT Country, AVG(Employer_Reputation)
     FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
     WHERE Employer_Reputation > 70
     GROUP BY Country
     ORDER BY AVG(Employer_Reputation) DESC;
END $$
DELIMITER ;

CALL `universities`.`Best_Reputation`();

DELIMITER //
CREATE PROCEDURE `All`()
BEGIN
     SELECT *
     FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;
END //
DELIMITER ;

DESCRIBE `2024 qs world university rankings 1.2 (for qs.com) (3)`;

DELIMITER $$
CREATE PROCEDURE Uni_scores(IN Rep VARCHAR(200), Outc VARCHAR(200))
BEGIN
     SELECT *
     FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
     WHERE Employer_Reputation = Rep 
     AND Employment_Outcomes = Outc; 
END $$
DELIMITER ;

CALL `universities`.`Uni_scores`(100.0, 100);

CREATE VIEW UK_Unis AS
SELECT *
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE Country = "United Kingdom";

SELECT *
FROM Uk_Unis;

CREATE OR REPLACE VIEW UK_Unis AS
SELECT *
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE Country LIKE "United%";

SHOW INDEXES FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;

CALL `universities`.`All`();

EXPLAIN
SELECT *
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`
WHERE Employer_Reputation = 97.9;

SELECT *
FROM `2024 qs world university rankings 1.2 (for qs.com) (3)`;