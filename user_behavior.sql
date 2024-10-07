use db;
--load dataset
CREATE TABLE user_behavior_dataset (
    User_ID INT PRIMARY KEY,
    Device_Model VARCHAR(100),
    Operating_System VARCHAR(50),
    App_Usage_Time INT,
    Screen_On_Time FLOAT,
    Battery_Drain INT,
    Number_of_Apps_Installed INT,
    Data_Usage FLOAT,
    Age INT,
    Gender VARCHAR(10),
    User_Behavior_Class VARCHAR(50)
);

BULK INSERT user_behavior_dataset
FROM 'C:\Users\HARI\Desktop\user_behavior_dataset.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Fields are separated by commas
    ROWTERMINATOR = '\n',   -- Rows are separated by newline
    FIRSTROW = 2            -- Skip the header row
);

--show this table and value only top 10
SELECT TOP 10 * 
FROM user_behavior_dataset;

--1.what is the total no of users in the datasets
select count(User_id) As Total_Users from user_behavior_dataset;

--2.which os has the highest average app usage time per day
SELECT TOP 5 Operating_System, AVG(App_Usage_Time) AS Avg_App_Usage_Time
FROM user_behavior_dataset
GROUP BY Operating_System
ORDER BY Avg_App_Usage_Time DESC;

--3.what ia the average battery drain for users aged 25 and above
SELECT AVG(Battery_Drain) AS Avg_Battery_Drain
FROM user_behavior_dataset
WHERE Age >= 25;

--4.How many users are using each device model.
SELECT Device_Model,count(User_ID) AS No_of_Users 
FROM user_behavior_dataset 
GROUP BY Device_Model
ORDER BY No_of_Users;

--5.what is the average data usage perday for male vs female users.
SELECT Gender, AVG(Data_Usage) AS Avg_Data_Usage
FROM user_behavior_dataset
GROUP BY Gender;

--6.List the top 5 users with the highest app usage time per day.
SELECT TOP 5 User_ID, App_Usage_Time
FROM user_behavior_dataset
ORDER BY App_Usage_Time DESC;

--7.What is the average number of apps installed by users in the '4' user behavior class.
SELECT AVG(Number_of_Apps_Installed) AS Avg_Apps_Installed
FROM user_behavior_dataset
WHERE User_Behavior_Class = '4';

--8.Find the most common age among users in the dataset.
SELECT TOP 7 Age, COUNT(User_ID) AS Num_Users
FROM user_behavior_dataset
GROUP BY Age
ORDER BY Num_Users DESC;

--9.What is the average screen-on time for users with a battery drain above 2000 mAh/day.
SELECT AVG(Screen_On_Time) AS Avg_Screen_On_Time
FROM user_behavior_dataset
WHERE Battery_Drain > 2000;

--10.How many users are aged between 18 and 30 years.
SELECT COUNT(User_ID) AS Num_Users
FROM user_behavior_dataset
WHERE Age BETWEEN 18 AND 30;

--11.Which user behavior class has the highest average app usage time.
SELECT User_Behavior_Class, AVG(App_Usage_Time) AS Avg_App_Usage_Time
FROM user_behavior_dataset
GROUP BY User_Behavior_Class
ORDER BY Avg_App_Usage_Time DESC;

--12.Find the total data usage for all users combined.
SELECT SUM(Data_Usage) AS Total_Data_Usage
FROM user_behavior_dataset;

--13.What is the average number of apps installed on devices using Android operating system
SELECT AVG(Number_of_Apps_Installed) AS Avg_Apps_Installed
FROM user_behavior_dataset
WHERE Operating_System = 'Android';

--14.List the top 3 age groups with the highest average battery drain.
SELECT CASE 
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        ELSE 'Above 40' 
    END AS Age_Group, 
    AVG(Battery_Drain) AS Avg_Battery_Drain
FROM user_behavior_dataset
GROUP BY CASE 
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        ELSE 'Above 40' 
    END
ORDER BY Avg_Battery_Drain DESC;

--15.What is the median screen-on time for all users.
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Screen_On_Time) OVER () AS Median_Screen_On_Time
FROM user_behavior_dataset;

--16.Which device model has the highest number of apps installed on average.
SELECT Device_Model, AVG(Number_of_Apps_Installed) AS Avg_Apps_Installed
FROM user_behavior_dataset
GROUP BY Device_Model
ORDER BY Avg_Apps_Installed DESC;

--17.Find the correlation between data usage and battery drain.
SELECT 
    SUM((Data_Usage - mean_data_usage) * (Battery_Drain - mean_battery_drain)) / 
    (SQRT(SUM(POWER(Data_Usage - mean_data_usage, 2)) * 
           SUM(POWER(Battery_Drain - mean_battery_drain, 2))) ) AS Correlation
FROM (
    SELECT 
        Data_Usage,
        Battery_Drain,
        (SELECT AVG(Data_Usage) FROM user_behavior_dataset) AS mean_data_usage,
        (SELECT AVG(Battery_Drain) FROM user_behavior_dataset) AS mean_battery_drain
    FROM user_behavior_dataset
) AS subquery;

--18.What is the total number of male users in the '3' user behavior class.
SELECT COUNT(User_ID) AS Num_Male_Users
FROM user_behavior_dataset
WHERE Gender = 'Male' AND User_Behavior_Class = '3';

--19.Find the user with the highest data usage.
SELECT TOP 10 User_ID, Data_Usage
FROM user_behavior_dataset
ORDER BY Data_Usage DESC;

--20.Which operating system has the lowest average screen-on time.
SELECT Operating_System, AVG(Screen_On_Time) AS Avg_Screen_On_Time
FROM user_behavior_dataset
GROUP BY Operating_System
ORDER BY Avg_Screen_On_Time ASC;














