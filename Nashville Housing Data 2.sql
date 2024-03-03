/* aya lezzz gooooo */

/* quick glance at the data */

SELECT * 
FROM nhd.`nashville housing data for data cleaning`;

/* standardise date*/
/* both queries returning null values */

SELECT DATE_FORMAT(SaleDate, 'm%-%d-%Y') AS formated_date
FROM nhd.`nashville housing data for data cleaning`;

SELECT CONVERT(SaleDate, DATE)
FROM nhd.`nashville housing data for data cleaning`;

/* PROPERTY ADRESS */

SELECT PropertyAddress
FROM nhd.`nashville housing data for data cleaning`;

/* replace blank property address column with null */

UPDATE nhd.`nashville housing data for data cleaning`
SET PropertyAddress = null
WHERE PropertyAddress = '';

/* do a self join and populate null values with an address as long as the parcelid is the same */

SELECT x.UniqueID, x.ParcelID, x.PropertyAddress, y.ParcelID, y.PropertyAddress, COALESCE(x.PropertyAddress, y.PropertyAddress)
FROM nhd.`nashville housing data for data cleaning` x
JOIN nhd.`nashville housing data for data cleaning` y
ON x.ParcelID = y.ParcelID
AND x.UniqueID <> y.UniqueID
WHERE x.PropertyAddress is null;

/* update the table */

UPDATE nhd.`nashville housing data for data cleaning` x
JOIN nhd.`nashville housing data for data cleaning` y
ON x.ParcelID = y.ParcelID
AND x.UniqueID <> y.UniqueID
SET x.PropertyAddress = COALESCE(x.PropertyAddress, y.PropertyAddress)
WHERE x.PropertyAddress is null;

/* split property address into street address and city */

SELECT SUBSTRING_INDEX(PropertyAddress, ',', 1) as street_address, 
SUBSTRING_INDEX(PropertyAddress, ',', -1) as city
FROM `nhd`.`nashville housing data for data cleaning`;

/* split street address into street name and street number */

SELECT SUBSTRING_INDEX(street_address, ' ', 1) as street_number, 
SUBSTRING_INDEX(street_address, ' ', -3) as street_name,
street_address
FROM (SELECT SUBSTRING_INDEX(PropertyAddress, ',', 1) as street_address, 
SUBSTRING_INDEX(PropertyAddress, ',', -1) as city
FROM `nhd`.`nashville housing data for data cleaning`) as temp;

/* create street address and city columns */

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
ADD street_address varchar(255) AFTER PropertyAddress,
ADD city varchar(255) AFTER street_address;

UPDATE `nhd`.`nashville housing data for data cleaning`
SET street_address = SUBSTRING_INDEX(PropertyAddress, ',', 1),
city = SUBSTRING_INDEX(PropertyAddress, ',', -1);

/* OWNER'S ADDRESS */

SELECT OwnerAddress
FROM `nhd`.`nashville housing data for data cleaning`;

/* split owner address into two */

SELECT SUBSTRING_INDEX(OwnerAddress, ',', 1) AS Owner_street_address,
SUBSTRING_INDEX(OwnerAddress, ',', -1) AS Owner_state,
OwnerAddress 
FROM `nhd`.`nashville housing data for data cleaning`;

/* split owner address further to owner city */

SELECT SUBSTRING_INDEX(OwnerAddress, ',', -2) AS Owner_city,
SUBSTRING_INDEX(OwnerAddress ',', -1) AS Owner_state,
Owner_street_address
FROM (SELECT SUBSTRING_INDEX(OwnerAddress, ',', 1) AS Owner_street_address,
SUBSTRING_INDEX(OwnerAddress, ',', -1) AS Owner_state,
OwnerAddress 
FROM `nhd`.`nashville housing data for data cleaning`) AS temp; 

/* add street address, city and state columns */

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
ADD Owner_street_address varchar(255) AFTER OwnerAddress,
ADD Owner_city varchar(255) AFTER Owner_street_address,
ADD Owner_state varcHAR(255) AFTER Owner_city;

UPDATE `nhd`.`nashville housing data for data cleaning`
SET Owner_street_address = SUBSTRING_INDEX(OwnerAddress, ',', 1),
Owner_city = SUBSTRING_INDEX(OwnerAddress, ',', -2),
Owner_state = SUBSTRING_INDEX(OwnerAddress, ',', -1);

/* futher split owner city to get actual city without state */

SELECT SUBSTRING_INDEX(Owner_city, ',', 1) AS new_owner_city
FROM `nhd`.`nashville housing data for data cleaning`;

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
ADD new_owner_city varchar(255) after owner_city;

UPDATE `nhd`.`nashville housing data for data cleaning`
SET new_owner_city = SUBSTRING_INDEX(Owner_city, ',', 1);

/* delete owner city column */

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
DROP COLUMN Owner_city;

/* SOLD AS VACANT */

/* peruse column */

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) 
FROM `nhd`.`nashville housing data for data cleaning`
GROUP BY SoldAsVacant
ORDER BY 2;

/* replace y and n with yes and no */

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END
FROM `nhd`.`nashville housing data for data cleaning`;

UPDATE `nhd`.`nashville housing data for data cleaning`
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END;
     
/* checking for duplicate unique ids */

SELECT UniqueID, COUNT(DISTINCT(UniqueID)) 
FROM `nhd`.`nashville housing data for data cleaning`     
GROUP BY UniqueID
HAVING COUNT(DISTINCT(UniqueID)) > 1;

/* delete unused columns */

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
DROP COLUMN PropertyAddress;

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
DROP COLUMN Owner_state;

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
DROP COLUMN OwnerAddress;

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
DROP COLUMN OwnerAddress;

/* change some column names */

ALTER TABLE `nhd`.`nashville housing data for data cleaning`
CHANGE street_address Property_street_address varchar(255),
CHANGE city Property_city varchar(255)
