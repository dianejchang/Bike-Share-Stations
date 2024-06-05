-- Create a query that shows the date and temperature range with a range of 5 or more
SELECT date, (maxtemperaturef - mintemperaturef) AS Range
FROM weather
WHERE (maxtemperaturef - mintemperaturef) >= 5
;


-- Find the top ten hottest start station locations using the weather and trips tables to reference zip and zip_code
SELECT start_station, maxtemperaturef
FROM trips
JOIN weather
ON trips.zip_code = weather.zip
ORDER BY maxtemperaturef DESC
LIMIT 10
;


-- Creating a result set that groups the start stations by the number of trips and filtering results to show num of trips greater than 10k
SELECT start_station, COUNT (start_station) AS no_of_trips
FROM trips
GROUP BY start_station
HAVING COUNT (start_station) > 10000
ORDER BY no_of_trips DESC
;


--  Showing first 20 records of the status table
SELECT *
FROM status
LIMIT 20
;


-- Looking at only October weather values
SELECT *
FROM weather
WHERE date LIKE '%-10-%'
;


-- Showing the first and last weather record
	(SELECT *
	FROM weather
	LIMIT 1)
UNION
	(SELECT *
	FROM weather
	ORDER BY date DESC
	LIMIT 1)
;


-- Showing station names with 17 or more bikes available
SELECT stations.name, status.bikes_available
FROM stations
JOIN status
ON stations.station_id = status.station_id
WHERE bikes_available >= 17
;


-- Showing station names that have 15 to 7 bikes available
SELECT DISTINCT stations.name, status.bikes_available
FROM stations
	JOIN status
	ON stations.station_id = status.station_id
	WHERE bikes_available BETWEEN 15 AND 17
--
SELECT DISTINCT stations.name, status.bikes_available
FROM stations
	JOIN status
	ON stations.station_id = status.station_id
	WHERE bikes_available >=15 AND bikes_available <=17
--
SELECT DISTINCT stations.name
FROM stations
	JOIN status
	ON stations.station_id = status.station_id
WHERE stations.station_id IN
	(SELECT station_id
	FROM status
	WHERE bikes_available BETWEEN 15 and 17)
ORDER BY stations.name DESC
--
SELECT stations.name
FROM stations
WHERE station_id IN 
	(SELECT station_id
	FROM status
	WHERE bikes_available BETWEEN 15 and 17)
ORDER BY stations.name DESC
;


-- Finding stations that start with the letter C
SELECT name
FROM stations
WHERE name LIKE 'C%'
;


-- Creating a new table that copies the stations table but has a new id called new_station_id that mulitplies the old stations by 10
-- In a case where a new system requires the old system's station ids to be multiplied by 10
SELECT (station_id*10) AS station_id2, stations.*
FROM stations
;


-- Counting how many unique start stations each zip code has
SELECT COUNT (DISTINCT start_station) AS unique_count, zip_code
FROM trips
GROUP BY zip_code 
HAVING COUNT (DISTINCT start_station) >=50
;