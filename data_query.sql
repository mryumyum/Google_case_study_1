# Max trip length
SELECT MAX(trip_length)
FROM all_data;

# Min trip length
SELECT MIN(trip_length)
FROM all_data;

# Member travel times
WITH travel_time AS (
	SELECT ride_id, started_at_conv, ended_at_conv, TIMEDIFF(ended_at_conv, started_at_conv) AS member_travel_time
	FROM bike_rides.all_data
	WHERE member_casual = 'member')
SELECT ride_id, started_at_conv, ended_at_conv, member_travel_time
FROM travel_time
WHERE member_travel_time > 0;

# Average member travel time
WITH travel_time AS (
	SELECT ride_id, started_at_conv, ended_at_conv, TIME_TO_SEC(TIMEDIFF(ended_at_conv, started_at_conv))/60 AS member_travel_time_min
	FROM bike_rides.all_data
	WHERE member_casual = 'member')
SELECT ROUND(AVG(member_travel_time_min), 2) as avg_member_travel_time_min
FROM travel_time
WHERE member_travel_time_min > 0;

# Casual travel times
WITH travel_time AS (
	SELECT ride_id, started_at_conv, ended_at_conv, TIMEDIFF(ended_at_conv, started_at_conv) AS member_travel_time
	FROM bike_rides.all_data
	WHERE member_casual = 'casual')
SELECT ride_id, started_at_conv, ended_at_conv, member_travel_time
FROM travel_time
WHERE member_travel_time > 0;

# Average Casual travel time
WITH travel_time AS (
	SELECT ride_id, started_at_conv, ended_at_conv, TIME_TO_SEC(TIMEDIFF(ended_at_conv, started_at_conv))/60 AS casual_travel_time_min
	FROM bike_rides.all_data
	WHERE member_casual = 'casual')
SELECT ROUND(AVG(casual_travel_time_min), 2) as avg_casual_travel_time_min
FROM travel_time
WHERE casual_travel_time_min > 0;

# Outliers
SELECT *
FROM bike_rides.all_data
WHERE trip_length > 1500
ORDER BY trip_length, `month`;

# What bike type do members like?
SELECT rideable_type, COUNT(*) as members_bike_choice
FROM bike_rides.all_data
WHERE member_casual = 'member'
GROUP BY rideable_type;

# What bike type do casuals like?
SELECT rideable_type, COUNT(*) as casual_bike_choice
FROM bike_rides.all_data
WHERE member_casual = 'casual'
GROUP BY rideable_type;

# Most popular weekday for members
SELECT weekday, COUNT(*) as member_weekdays
FROM bike_rides.all_data
WHERE member_casual = 'member'
GROUP BY weekday;

# Most popular weekday for casuals
SELECT weekday, COUNT(*) as casual_weekdays
FROM bike_rides.all_data
WHERE member_casual = 'casual'
GROUP BY weekday;

SELECT *
FROM bike_rides.all_data
LIMIT 1000;




