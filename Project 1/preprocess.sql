use project1;
-- ------------------------------------------------------------------------------------------------------------------------------
-- Data cleaning

-- 1. Missing values

-- a. Children
SELECT
    SUM(CASE WHEN children IS NULL THEN 1 ELSE 0 END) as null_children
FROM HotelBookings;

update HotelBookings
set children = 0
where children is null;

SELECT
    SUM(CASE WHEN children IS NULL THEN 1 ELSE 0 END) as null_children
FROM HotelBookings;

-- b. Company
SELECT
    SUM(CASE WHEN company IS NULL THEN 1 ELSE 0 END) as null_companies,
    count(*) as total_rows,
    100*SUM(CASE WHEN company IS NULL THEN 1 ELSE 0 END)/count(*) as percent_missing
FROM HotelBookings;
-- It has many missing values, 94%
ALTER TABLE HotelBookings
DROP COLUMN company;

-- c. Agent
-- Update the table, replacing missing values with the calculated average

SELECT ROUND(AVG(agent), 0) INTO @average
FROM hotelbookings;

UPDATE hotelbookings
SET agent = @average
WHERE agent IS NULL;


-- d. country
DELETE FROM hotelbookings 
WHERE country is null;

select * 
from hotelbookings;


-- 2. Changing columns
-- Add a new column for the full date in the format "YYYY-MM-DD"
ALTER TABLE hotelbookings
ADD COLUMN full_date DATE;

UPDATE hotelbookings
SET full_date = STR_TO_DATE(CONCAT(arrival_date_year, ' ', arrival_date_month, ' ', arrival_date_day_of_month), '%Y %M %e');

ALTER TABLE HotelBookings
DROP COLUMN arrival_date_year,
DROP COLUMN arrival_date_month,
DROP COLUMN arrival_date_day_of_month;

select * 
from hotelbookings;






