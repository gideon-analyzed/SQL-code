SELECT *
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;

/* ayaaaa lezzzz gooooooo */

/* rename first column to age */

ALTER TABLE `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`
RENAME COLUMN ï»¿Column1 TO Age;

SELECT COLUMN_NAME
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`
TABLE NAME = `wa_fn-usec_-hr-employee-attrition` 


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`
ORDER BY ORDINAL_POSITION;

SELECT `COLUMN_NAME` 
FROM `INFORMATION_SCHEMA`.`COLUMNS` 
WHERE `TABLE_SCHEMA`=Attrition;

SELECT *, ROW_NUMBER() OVER (ORDER BY EmployeeCount) AS Row_Id
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;

CREATE TABLE ibm_attrition
AS (SELECT *, ROW_NUMBER() OVER (ORDER BY EmployeeCount) AS Row_Id
      FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`);

CREATE TABLE ibm_attrition AS
SELECT *, ROW_NUMBER() OVER (ORDER BY EmployeeCount) AS Row_Id
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;

DESCRIBE `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;

SET @row_number = 0;

SELECT @row_number := @row_number + 1 AS RowId
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;

SET @row_number = 0;

SELECT *, @row_number := @row_number + 1 AS RowId
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;

ALTER TABLE `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition` 
ADD COLUMN RowId INT;

SET @row_number = 0;

UPDATE `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`
SET RowId = (@row_number := @row_number + 1);

SELECT * 
FROM `ibm_hr_attrition_analytics`.`wa_fn-usec_-hr-employee-attrition`;
