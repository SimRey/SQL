use project1;

-- Exploratory Data Analysis
select *
from hotelbookings; 

-- 1. Get the name and email of the people with more than 5 previous cancelations

select
	name,
    email,
    previous_cancellations
from hotelbookings
where previous_cancellations > 5
order by previous_cancellations desc;


-- 2. Get the count of the different type of rooms with an adr higher than the average
select
	reserved_room_type,
	count(*) as total_count
from hotelbookings
where adr > (select avg(adr) from hotelbookings)
group by reserved_room_type
order by total_count desc;

-- 3. What are the top 3 most common area code in the phone numbers? (Area code is first 3 digits)
select 
	SUBSTRING_INDEX(phone_number, '-', 1) as prefix, 
	count(*) as count
from hotelbookings
group by prefix
order by 
	count desc
limit 3;

-- 4. How does the adr for Italy and Mexico sum throughout the time
select
	country,
    adr,
    full_date,
	sum(adr) over(partition by country order by country, full_date) as rolling_adr
from hotelbookings
where country in ("MEX", "ITA");


-- 5. Use a CTE to get information
with CTE_bookings as
(
select 
	name,
    email,
    avg(adr) over(partition by country) as avg_adr

from hotelbookings
where year(full_date) > 2015 and reserved_room_type = "A"
)

select
	name,
    avg_adr
from CTE_bookings;


	