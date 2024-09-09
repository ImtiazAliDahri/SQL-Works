

-- Introduction

/*
This project is a sample work using a small dataset to demonstrate the basics of data analysis using SQL queries.
The dataset contains weather data for various cities in Pakistan, including temperature, precipitation, wind speed, humidity, atmospheric pressure, cloud cover, 
sunshine hours, and UV index.
The project aims to understand the basics of data analysis by performing various queries on this sample data.
The skills learned from this project will be applied to larger datasets in the future.
*/


CREATE DATABASE WeatherDataBase1;
USE WeatherDataBase1;

CREATE TABLE Cities1 (
  CityID INT AUTO_INCREMENT PRIMARY KEY,
  CityName VARCHAR(100) NOT NULL,
  Country VARCHAR(100)
);

CREATE TABLE WeatherData2 (
  WeatherID INT AUTO_INCREMENT PRIMARY KEY,
  CityID INT,
  Date DATE,
  Temperature DECIMAL(5, 2),  -- in Celsius
  Precipitation DECIMAL(5, 2),  -- in mm
  WindSpeed DECIMAL(5, 2),  -- in km/h
  Humidity INT,  -- percentage
  AtmosphericPressure DECIMAL(7, 2),  -- in hPa
  CloudCover INT,  -- percentage
  SunshineHours INT,  -- in hours
  UVIndex INT,  -- UV index
  FOREIGN KEY (CityID) REFERENCES Cities1(CityID)
);


INSERT INTO Cities1 (CityName, Country) VALUES
('Islamabad', 'Pakistan'),
('Karachi', 'Pakistan'),
('Lahore', 'Pakistan'),
('Peshawar', 'Pakistan'),
('Quetta', 'Pakistan'),
('Faisalabad', 'Pakistan'),
('Multan', 'Pakistan'),
('Hyderabad', 'Pakistan'),
('Rawalpindi', 'Pakistan'),
('Nawab Shah', 'Pakistan');

INSERT INTO WeatherData2 (CityID, Date, Temperature, Precipitation, WindSpeed, Humidity, AtmosphericPressure, CloudCover, SunshineHours, UVIndex) VALUES
(1, '2024-05-01', 25.0, 0.0, 10.0, 50, 1013.25, 20, 8, 6),
(2, '2024-05-01', 28.0, 0.0, 15.0, 60, 1012.50, 15, 9, 7),
(3, '2024-05-01', 20.0, 5.0, 12.0, 70, 1011.75, 30, 6, 5),
(4, '2024-05-01', 22.0, 2.0, 18.0, 65, 1010.00, 25, 7, 6),
(5, '2024-05-01', 30.0, 0.0, 20.0, 55, 1009.25, 10, 10, 8),
(6, '2024-05-01', 18.0, 8.0, 25.0, 75, 1008.50, 35, 5, 4),
(7, '2024-05-01', 21.0, 0.0, 22.0, 62, 1007.75, 20, 8, 6),
(8, '2024-05-01', 19.0, 4.0, 14.0, 80, 1007.00, 30, 6, 5),
(9, '2024-05-01', 24.0, 1.0, 16.0, 58, 1006.25, 15, 9, 7),
(10, '2024-05-01', 26.0, 3.0, 11.0, 68, 1005.50, 25, 7, 6);



select * from citties;
select * from WeatherData2;



-- Queries for Analysis




-- 1. Join Cities and WeatherData
SELECT
c.CityName,
c.Country,
w.Date,
w.Temperature,
w.Precipitation,
w.WindSpeed,
w.Humidity,
w.AtmosphericPressure,
w.CloudCover,
w.SunshineHours,
w.UVIndex
FROM Cities1 c
JOIN WeatherData2 w ON c.CityID = w.CityID
ORDER BY c.CityName, w.Date;


 
-- 2. Get Weather Data for a Specific City (e.g., Islamabad)
SELECT wd.* 
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
WHERE c.CityName = 'Islamabad';



-- 3. Find Cities with Temperature Above a Certain Value (e.g., 25°C)
SELECT c.CityName, wd.Temperature 
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
WHERE wd.Temperature > 25;



-- 4. Find the City with the Highest Temperature
SELECT c.CityName, MAX(wd.Temperature) AS MaxTemperature 
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
GROUP BY c.CityName
ORDER BY MaxTemperature DESC
LIMIT 1;



 -- 5. Find Average Temperature for Each City
SELECT c.CityName, 
AVG(wd.Temperature) AS AvgTemperature 
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
GROUP BY c.CityName;



-- 6. Get Cities with Cloud Cover Greater Than 20%
SELECT c.CityName, wd.CloudCover 
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
WHERE wd.CloudCover > 20;



-- 7. Find Total Precipitation for Each City 
SELECT c.CityName, SUM(wd.Precipitation) AS TotalPrecipitation 
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
GROUP BY c.CityName;



-- 8.  Delete a City and Its Weather Data (e.g., Quetta)
DELETE wd, c
FROM WeatherData2 wd
JOIN Cities1 c ON wd.CityID = c.CityID
WHERE c.CityName = 'Quetta';





-- 10. Find the City with the Maximum and Minimum Temperature on a Specific Date
SELECT c.CityName, wd.Temperature 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.Date = '2024-05-01' 
ORDER BY wd.Temperature DESC 
LIMIT 1;

SELECT c.CityName, wd.Temperature 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.Date = '2024-05-01' 
ORDER BY wd.Temperature ASC 
LIMIT 1;

-- 11. Find the City with the Highest Wind Speed and Low Precipitation
SELECT c.CityName, wd.WindSpeed, wd.Precipitation 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.Precipitation < 1.0 
ORDER BY wd.WindSpeed DESC 
LIMIT 1;

-- 12. Calculate the Average Temperature, Wind Speed, and Humidity for Cities in Pakistan
SELECT c.Country, AVG(wd.Temperature) AS AvgTemp, 
       AVG(wd.WindSpeed) AS AvgWindSpeed, 
       AVG(wd.Humidity) AS AvgHumidity 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE c.Country = 'Pakistan' 
GROUP BY c.Country;

-- 13. Find Cities Where UV Index is Greater Than 6 and Sunshine Hours are Greater Than 8
SELECT c.CityName, wd.UVIndex, wd.SunshineHours 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.UVIndex > 6 AND wd.SunshineHours > 8;

-- 14. Get the Number of Days Each City Has a Temperature Above 30°C
SELECT c.CityName, COUNT(*) AS HotDays 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.Temperature > 30 
GROUP BY c.CityName;

-- 15. Find the City with the Most Variability in Temperature (Highest Standard Deviation)
SELECT c.CityName, STDDEV(wd.Temperature) AS TempVariability 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
GROUP BY c.CityName 
ORDER BY TempVariability DESC 
LIMIT 1;

-- 16. Calculate the Correlation Between Wind Speed and Temperature Across All Cities
SELECT CORR(wd.WindSpeed, wd.Temperature) AS WindTempCorrelation 
FROM WeatherData2 wd;

-- 17. Get the Hottest and Coldest Cities Over Time (Using Rank and Window Function)
SELECT c.CityName, wd.Date, wd.Temperature, 
       RANK() OVER (PARTITION BY wd.Date ORDER BY wd.Temperature DESC) AS HotCityRank, 
       RANK() OVER (PARTITION BY wd.Date ORDER BY wd.Temperature ASC) AS ColdCityRank 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID;

-- 18. Find the Total Sunshine Hours Per City and the Average UV Index for Cities with Less Than 1000 Total Sunshine Hours
SELECT c.CityName, SUM(wd.SunshineHours) AS TotalSunshine, 
       AVG(wd.UVIndex) AS AvgUVIndex 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
GROUP BY c.CityName 
HAVING TotalSunshine < 1000;

-- 19. Calculate the 3-Day Moving Average of Temperature for Each City
SELECT c.CityName, wd.Date, 
       AVG(wd.Temperature) OVER (PARTITION BY wd.CityID ORDER BY wd.Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvgTemp 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID;

-- 20. Get Cities with Weather Anomalies: Extreme Weather (Low Pressure & High Wind Speed)
SELECT c.CityName, wd.Date, wd.Temperature, wd.WindSpeed, wd.AtmosphericPressure 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.AtmosphericPressure < 1000 AND wd.WindSpeed > 20 
ORDER BY wd.WindSpeed DESC;

-- 22. Find Cities Where the Humidity is Over 70% but Cloud Cover is Less Than 30%
SELECT c.CityName, wd.Humidity, wd.CloudCover 
FROM WeatherData2 wd 
JOIN Cities1 c ON wd.CityID = c.CityID 
WHERE wd.Humidity > 70 AND wd.CloudCover < 30;




-- Conclusion

/*
This project demonstrates the power of SQL queries in extracting insights from weather data.
By performing various queries, we were able to identify trends, patterns, and anomalies in the data.
The skills learned from this project can be applied to larger datasets, enabling us to make informed decisions and predictions.
The project highlights the importance of data analysis in understanding complex phenomena like weather patterns.
By analyzing weather data, we can better prepare for extreme weather events, optimize resource allocation, and improve overall decision-making.
This project serves as a foundation for future data analysis projects, where we will work with larger datasets and more complex queries to extract valuable insights.
*/
