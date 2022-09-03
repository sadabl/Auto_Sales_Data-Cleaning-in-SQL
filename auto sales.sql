

-- Automobile sales data cleaning project 

-- Step 1: Inspecting the "fuel type" to ensure there is no invalid/erroneous type of fuel recored
SELECT DISTINCT fuel_type
FROM cars


-- Step 2: Inspecting the "length" to be sure it contains values between 141.1 to 208.1 
SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM cars


-- Step 3: Checking if the "num of doors" column contains any missing values. 
-- Two missing values were found for Dodge and Mazda cars
SELECT *
FROM cars 
WHERE num_of_doors IS NULL


-- Step 4: Updating the table so that all Dodge, gas and sedans have four doors 
UPDATE cars
SET num_of_doors = 'four'
WHERE make = 'dodge'
  AND fuel_type = 'gas'
  AND body_style = 'sedan'


-- Step 5: Updating the table so that all Mazda diesel sedans have four doors 
UPDATE cars
SET num_of_doors = 'four'
WHERE make = 'Mazda'
  AND fuel_type = 'diesel'
  AND body_style = 'sedan'


-- Step 6: Identifying potential errors in the number of cylinders 
SELECT 
  DISTINCT num_of_cylinders
FROM cars;


-- Step 7: Correcting mispelled number of cylinders from "tow" to "Two" 
UPDATE cars
SET num_of_cylinders = 'two'
WHERE num_of_cylinders = 'tow'


--Instecpting if the update worked worked
SELECT
  DISTINCT num_of_cylinders
FROM cars;


-- Step 8: Checking if the values for compression_ratio is outside the expected range of 7-23.  
SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM cars;
  

-- Step 9: Checking how many records have compression ratio more than 23 before they are deleted. 
-- This will prevent deleting significant data points. 
SELECT
   COUNT(*) AS num_of_rows_to_delete
FROM cars
WHERE compression_ratio > 23;

-- Deleting records with compression_ratio > 23
DELETE cars
WHERE compression_ratio >23;


-- Step 10: Checking the drive_wheels column for inconsistencies.
-- "4wd" appears twice in results, suggesting an extra space.  
SELECT
  DISTINCT drive_wheels
FROM cars;


-- Step 10: Determining the length of the "drive_wheels" string variable.
SELECT
  DISTINCT drive_wheels,
  LEN(drive_wheels) AS drive_wheels_length
FROM cars;


-- Step 11: One of the "4wd" string has four characters instead of the expected three
-- Using TRIM function to remove all extra spaces in the drive_wheels column
UPDATE cars
SET drive_wheels = TRIM(drive_wheels)
WHERE LEN(drive_wheels) = 4;

SELECT
  DISTINCT drive_wheels
FROM cars;


-- Adding auto manufacturers' countries of origin
ALTER TABLE cars
ADD automaker_country VARCHAR(255);


Update cars
SET automaker_country = 'Japan'
Where 
	make = 'toyota' OR
	make = 'honda'  OR
	make = 'isuzu'	OR 
	make = 'mazda'	OR
	make = 'mitsubishi' OR
	make = 'nissan'	OR
	make = 'subaru';
	
Update cars
SET automaker_country = 'Germany'
Where 
	make = 'audi' OR
	make = 'bmw'  OR
	make = 'mercedes-benz'	OR 
	make = 'porsche'	OR
	make = 'volkswagen' OR
	make =  'volvo';

Update cars
SET automaker_country = 'USA'
Where 
	make = 'chevrolet' OR
	make = 'dodge'     OR
	make = 'mercury'  OR 
	make = 'plymouth';  

Update cars
SET automaker_country = 'Italy'
Where make = 'alfa Romeo';
	
Update cars
SET automaker_country = 'France'
Where make = 'peugot';
	
Update cars
SET automaker_country = 'Sweden'
Where make = 'saab';


Update cars
SET automaker_country = 'British'
Where make = 'jaguar';


Update cars
SET automaker_country = 'Italian'
Where make = 'alfa-romero';


Select *
From cars
Where automaker_country is NULL