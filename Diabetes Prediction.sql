SELECT *
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

/* aayyaaaaaa lezzzz gooooooooooo*/

/* WHAT IS THE DISTRIBUTION OF DIABETES CASES BY GENEDER? */

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 0;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1;

SELECT gender, COUNT(diabetes), 
       (COUNT(diabetes)/
       (SELECT COUNT(*) 
       FROM `diabetes_prediction`.`diabetes_prediction_dataset`)) * 100 AS tot_population_percentage_with_diabetes
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
GROUP BY gender;

SELECT gender, COUNT(diabetes), 
       TRUNCATE
       (ROUND(
       (COUNT(diabetes)/(SELECT COUNT(diabetes) FROM `diabetes_prediction`.`diabetes_prediction_dataset` WHERE diabetes = 1)),3),3) * 100 AS diabetes_patients_compostion
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
GROUP BY gender;

SELECT gender, COUNT(gender)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
GROUP BY gender;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1;

SELECT COUNT(*)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

/* HOW DOES AGE AFFECT THE LIKELIHOOD OF HAVING DIABETES */

SELECT AVG(age), diabetes
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
GROUP BY diabetes;

SELECT AVG(age)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

SELECT MAX(age), MIN(age), AVG(age)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1;

SELECT MAX(age), MIN(age), AVG(age)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 0;

SELECT COUNT(*)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE age = 80;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 70 AND 81;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 60 AND 69;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 50 AND 59;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 40 AND 49;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 30 AND 39;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 20 AND 29;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 10 AND 19;

SELECT COUNT(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1
AND age BETWEEN 0 AND 9;

/* IS THERE A RELATIONSHIP BETWEEN HYPERTENSION AND DIABETES? */

SELECT SUM(hypertension)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

SELECT COUNT(hypertension)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE hypertension = 1;

SELECT COUNT(hypertension)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE hypertension = 0
AND diabetes = 1;

SELECT COUNT(hypertension)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE hypertension = 1
AND diabetes = 1;

SELECT hypertension,
       ((SELECT COUNT(hypertension)
           FROM `diabetes_prediction`.`diabetes_prediction_dataset`
          WHERE hypertension = 1
            AND diabetes = 1)/
	    (SELECT SUM(diabetes)
		  FROM `diabetes_prediction`.`diabetes_prediction_dataset`)) * 100
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
GROUP BY hypertension;

SELECT hypertension,
       ((SELECT COUNT(hypertension) FROM `diabetes_prediction`.`diabetes_prediction_dataset` WHERE hypertension = 0 AND diabetes = 1)
         /
	    (SELECT SUM(diabetes) FROM `diabetes_prediction`.`diabetes_prediction_dataset`)) * 100
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
GROUP BY hypertension;

/* IS THER A RELATIONSHIP BETWEEN BMI AND HbA1c LEVELS */

SELECT CORR(bmi, HbA1c_level)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

/* HOW DOES SMOKING HISTORY IMOACT THE LIKELIHOOD OF HAVING DIABETES? */

SELECT DISTINCT smoking_history
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

SELECT smoking_history, SUM(diabetes), 
       SUM(diabetes)/(SELECT SUM(diabetes) FROM `diabetes_prediction`.`diabetes_prediction_dataset`) * 100
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
GROUP BY smoking_history;

SELECT SUM(diabetes)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

/* WHAT IS THE DISTRIBUTION OF HbA1c LEVELS AMONG INDIVIDUALS WITH DIABETES? */

SELECT DISTINCT HbA1c_level
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;

SELECT AVG(HbA1c_level), MIN(HbA1c_level), MAX(HbA1c_level)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
WHERE diabetes = 1;

SELECT diabetes, AVG(HbA1c_level)
FROM `diabetes_prediction`.`diabetes_prediction_dataset`
GROUP BY diabetes;

SELECT *
FROM `diabetes_prediction`.`diabetes_prediction_dataset`;