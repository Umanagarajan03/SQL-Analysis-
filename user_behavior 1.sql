--1. General Overview
--What is the total number of users in the dataset
SELECT COUNT(*) AS Total_Users FROM user_behavior_dataset;

--What are the unique device models used by users
SELECT DISTINCT Device_Model FROM user_behavior_dataset;

--What is the distribution of users across different operating systems
SELECT Operating_System, COUNT(*) AS User_Count 
FROM user_behavior_dataset 
GROUP BY Operating_System;

--2. User Behavior Analysis
--What is the average app usage time per user.
SELECT AVG(App_Usage_Time) AS Average_App_Usage_Time FROM user_behavior_dataset;

--What is the correlation between screen on time and app usage time.
SELECT 
    AVG(App_Usage_Time) AS Average_App_Usage_Time,
    AVG(Screen_On_Time) AS Average_Screen_On_Time 
FROM user_behavior_dataset;

--How does battery drain vary with the number of apps installed
SELECT TOP 10
    Number_of_Apps_Installed, 
    AVG(Battery_Drain) AS Average_Battery_Drain 
FROM user_behavior_dataset 
GROUP BY Number_of_Apps_Installed 
ORDER BY Number_of_Apps_Installed;

--3. Demographic Analysis
--What is the average age of users in different user behavior classes.
SELECT 
    User_Behavior_Class, 
    AVG(Age) AS Average_Age 
FROM user_behavior_dataset 
GROUP BY User_Behavior_Class;

--How does the gender distribution look across different user behavior classes.
SELECT 
    Gender, 
    User_Behavior_Class, 
    COUNT(*) AS User_Count 
FROM user_behavior_dataset 
GROUP BY Gender, User_Behavior_Class;

--4. Performance Metrics
--Which user behavior class has the highest average app usage time.
SELECT 
    User_Behavior_Class, 
    AVG(App_Usage_Time) AS Average_App_Usage_Time 
FROM user_behavior_dataset 
GROUP BY User_Behavior_Class 
ORDER BY Average_App_Usage_Time DESC ;

--What is the average data usage per user by gender.
SELECT 
    Gender, 
    AVG(Data_Usage) AS Average_Data_Usage 
FROM user_behavior_dataset 
GROUP BY Gender;

--5. Comparative Analysis
--How does average battery drain compare between different operating systems.
SELECT 
    Operating_System, 
    AVG(Battery_Drain) AS Average_Battery_Drain 
FROM user_behavior_dataset 
GROUP BY Operating_System;

--What is the maximum app usage time recorded, and which user does it belong to.
SELECT TOP 20 User_ID, App_Usage_Time 
FROM user_behavior_dataset 
ORDER BY App_Usage_Time DESC ;

--6. Insights into App Usage
--Which device model has the most apps installed on average.
SELECT 
    Device_Model, 
    AVG(Number_of_Apps_Installed) AS Average_Apps_Installed 
FROM user_behavior_dataset 
GROUP BY Device_Model 
ORDER BY Average_Apps_Installed DESC ;

--What percentage of users fall into each user behavior class.
SELECT 
    User_Behavior_Class, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM user_behavior_dataset) AS Percentage 
FROM user_behavior_dataset 
GROUP BY User_Behavior_Class;

--7. Data Quality Analysis
--Are there any users with missing or zero app usage time.
SELECT * 
FROM user_behavior_dataset 
WHERE App_Usage_Time IS NULL OR App_Usage_Time = 99;


--8. Advanced Analytics
--What is the trend of app usage time among different age groups.
SELECT 
    CASE 
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age >= 45 THEN '45 and above'
    END AS Age_Group,
    AVG(App_Usage_Time) AS Average_App_Usage_Time 
FROM user_behavior_dataset 
GROUP BY 
    CASE 
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age >= 45 THEN '45 and above'
    END;
