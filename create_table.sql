SHOW VARIABLES LIKE "local_infile";
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE "secure_file_priv";
SET SQL_SAFE_UPDATES = 0;
SHOW VARIABLES LIKE "SQL_SAFE_UPDATES";

CREATE TABLE all_data(
	ride_id TEXT,
    rideable_type TEXT,
    started_at DATETIME,
    ended_at DATETIME,
    `date` DATE,
    `month` TEXT,
    weekday TEXT,
	started_at_conv DATETIME,
    ended_at_conv DATETIME,
    trip_length FLOAT,
    start_station_name TEXT,
    start_station_id TEXT,
    end_station_name TEXT,
    end_station_id TEXT,
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual TEXT
);

LOAD DATA LOCAL INFILE "C:\\Users\\Zach\\Desktop\\Google Certificate\\Course 8\\Case 1\\cleaned_merged_data.csv"
INTO TABLE all_data
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

UPDATE all_data
SET member_casual = SUBSTRING(member_casual, 2, LENGTH(member_casual))
WHERE LEFT(member_casual, 1) = '"';

UPDATE all_data
SET member_casual = TRIM(TRAILING '\r' FROM member_casual);

UPDATE all_data
SET member_casual = TRIM(TRAILING '"' FROM member_casual);
#WHERE RIGHT(member_casual, 1) = '"';

ALTER TABLE all_data
DROP COLUMN started_at;

ALTER TABLE all_data
DROP COLUMN ended_at;

SELECT *
FROM all_data;






