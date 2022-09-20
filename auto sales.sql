

-- Automobile sales data cleaning project 

-- Note: Codes were written in Microsoft SQL Server Managemement Studio. The active database was 
-- GoogleAnalytics, hence referencing the database each time was ommited in the codes below


-- Step 1: Inspecting the data type for all columns 
SP_HELP Cars;


-- Step 2: Inspecting fuel types to ensure there is no invalid/erroneous type of fuel included
SELECT 
	DISTINCT fuel_type
FROM cars;


-- Step 3: Inspecting the range of values for the "length" to ensure it is between 141.1 and 208.1 
SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM cars;


-- Step 4: Checking if the number of doors column contains any missing values 
SELECT *
FROM cars 
WHERE num_of_doors IS NULL;


-- Two missing values were found for Dodge and Mazda cars
-- Step 5: Updating the table so that all Dodge gas sedans have four doors 
UPDATE cars
SET num_of_doors = 'four'
WHERE make = 'dodge'
  AND fuel_type = 'gas'
  AND body_style = 'sedan';


-- Step 6: Updating the table so that all Mazda diesel sedans have four doors 
UPDATE cars
SET num_of_doors = 'four'
WHERE make = 'Mazda'
  AND fuel_type = 'diesel'
  AND body_style = 'sedan';


-- Step 7: Identifying potential errors in the number of cylinders recorded in the table
SELECT 
  DISTINCT num_of_cylinders
FROM cars;


-- Step 8: Correcting mispelled number of cylinders from "tow" to "two" 
UPDATE cars
SET num_of_cylinders = 'two'
WHERE num_of_cylinders = 'tow';


-- Step 9: Checking if the range for compression ratio is outside the expected values of 7 and 23  
SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM cars;
  

-- Step 10: Checking how many records have compression ratio more than 23 before they are deleted 
-- This prevents deleting significant data points that can impact the final analysis 
SELECT
   COUNT(*) AS num_of_rows_to_delete
FROM cars
WHERE compression_ratio > 23;


-- Step 11: Deleting records with compression ratio > 23. In real life, this may be updated instead of deleting 
DELETE cars
WHERE compression_ratio > 23;


-- Step 12: Finding missing or invalid data (0 or less) for price column
SELECT *
FROM cars
WHERE price IS NULL
	OR price <= 0;


-- Step 13: Total number of missing or invalid prices before they are deleted 
SELECT 
	COUNT(*) AS rows_to_delete
FROM cars
WHERE price IS NULL
	OR price <= 0;


-- Step 14: Other erroneous or inconsistent prices
SELECT 
	DISTINCT price
FROM cars
ORDER BY price;


-- Step 15: Deleting missing or invalid prices 
DELETE cars
Where price IS NULL
	OR price <= 0;


-- Step 16: Checking for invalid fuel systems
SELECT 
	DISTINCT fuel_system
FROM cars;


-- Step 17: Total number of invalid engine types before they are deleted
SELECT 
	COUNT(*)
FROM cars
WHERE engine_type ='l';


-- Step 18: Deleting invalid engine types 
DELETE cars 
WHERE engine_type ='l';


-- Step 19: Checking the drive_wheels column for inconsistencies
SELECT
  DISTINCT drive_wheels
FROM cars;


-- Step 20: Determining the length of the drive_wheels variable
SELECT
  DISTINCT drive_wheels,
  LEN(drive_wheels) AS drive_wheels_length
FROM cars;


-- "4wd" appears twice in the results, suggesting extra spaces in the strings  
-- Step 21: Using TRIM function to remove all extra spaces in the drive_wheels column
UPDATE cars
SET drive_wheels 
	= TRIM(drive_wheels)
WHERE LEN(drive_wheels) = 4;


-- Step 22: Deleting incomplete or meaningless column
ALTER TABLE cars
DROP COLUMN Spr_latitudes;


-- Step 23: Adding auto manufacturers' country of origin
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