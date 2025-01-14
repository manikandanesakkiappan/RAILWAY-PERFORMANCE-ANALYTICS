           --  ***PERFORMANCE FOR RAILWAY DATA ANALYTICS PROJECT***  --- 

create database Railway_Performance_Analysis;
use Railway_Performance_Analysis;

--  Check Railway data no of  Columns Check --- 
select * from railway_analysis limit 5 ;

-- Overall 18 columns are There railway_analysis sheet.

--  Check Railway data number of  Rows  --- 
select count(*) from railway_analysis;

-- Here Over all 31648 Records are there

-- I observed Transaction ID,Date of Purchase,Time of Purchase,Date of Journey,Departure Time,Arrival Time,Actual Arrival Time data type is there for Text, we need to change data type -- 
-- Column Name also Rename  because of column name between i obsorved some space ,so i chage the column name also.alter

-- Rename the column name

ALTER TABLE railway_analysis RENAME COLUMN `Transaction ID` TO `Transaction_ID`;
ALTER TABLE railway_analysis RENAME COLUMN `Date of Purchase` TO `Date_of_Purchase`;
ALTER TABLE railway_analysis RENAME COLUMN `Time of Purchase` TO `Time_of_Purchase`;
ALTER TABLE railway_analysis RENAME COLUMN `Purchase Type` TO `Purchase_Type`;
ALTER TABLE railway_analysis RENAME COLUMN `Payment Method` TO `Payment_Method`;
ALTER TABLE railway_analysis RENAME COLUMN `Ticket Class` TO `Ticket_Class`;
ALTER TABLE railway_analysis RENAME COLUMN `Ticket Type` TO `Ticket_Type`;
ALTER TABLE railway_analysis RENAME COLUMN `Departure Station` TO `Departure_Station`;
ALTER TABLE railway_analysis RENAME COLUMN `Arrival Destination` TO `Arrival_Destination`;
ALTER TABLE railway_analysis RENAME COLUMN `Date of Journey` TO `Date_of_Journey`;
ALTER TABLE railway_analysis RENAME COLUMN `Departure Time` TO `Departure_Time`;
ALTER TABLE railway_analysis RENAME COLUMN `Arrival Time` TO `Arrival_Time`;
ALTER TABLE railway_analysis RENAME COLUMN `Actual Arrival Time` TO `Actual_Arrival_Time`;
ALTER TABLE railway_analysis RENAME COLUMN `Journey Status` TO `Journey_Status`;
ALTER TABLE railway_analysis RENAME COLUMN `Reason for Delay` TO `Reason_for_Delay`;
ALTER TABLE railway_analysis RENAME COLUMN `Refund Request` TO `Refund_Request`;


-- Check the Duplicate value 

SELECT Transaction_ID, COUNT(*)
FROM railway_analysis
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

ALTER TABLE railway_analysis
ADD PRIMARY KEY (Transaction_ID(50));

-- There is no Duplicate Value,So I will consider this is Primary Key


SELECT Date_of_Purchase, Time_of_Purchase,Purchase_Type,Payment_Method,Payment_Method,Railcard,Ticket_Class,Ticket_Class,Ticket_Type,Price,
Departure_Station,Arrival_Destination,Arrival_Destination,Date_of_Journey,Departure_Time,Arrival_Time,COUNT(*)
FROM railway_analysis
WHERE Departure_Time IS NULL AND Time_of_Purchase IS NULL AND Purchase_Type IS NULL AND Payment_Method IS NULL AND Payment_Method IS NULL AND Railcard IS NULL AND Ticket_Class IS NULL 
AND Ticket_Class IS NULL AND Ticket_Type IS NULL AND Price IS NULL AND Departure_Station IS NULL AND Arrival_Destination IS NULL
AND Arrival_Destination IS NULL AND Date_of_Journey IS NULL AND Departure_Time IS NULL AND Arrival_Time IS NULL  
GROUP BY Date_of_Purchase, Time_of_Purchase,Purchase_Type,Payment_Method,Payment_Method,Railcard,Ticket_Class,Ticket_Class,Ticket_Type,Price,
Departure_Station,Arrival_Destination,Arrival_Destination,Date_of_Journey,Departure_Time,Arrival_Time;


-- CHANGE THE DATA TYPE TIME_OF_PURCHESE

Select str_to_date(Time_of_Purchase, '%H:%i:s'), Time_of_Purchase from railway_analysis;

update railway_analysis set Time_of_Purchase =str_to_date(Time_of_Purchase, '%H:%i:%s');

alter table railway_analysis modify column `Time_of_Purchase` time;

-- CHANGE THE DATA TYPE  DATE_OF_PURCHESE

Select str_to_date(Date_of_Purchase, '%d-%m-%Y'), Date_of_Purchase from railway_analysis;

update railway_analysis set Date_of_Purchase =str_to_date(Date_of_Purchase, '%d-%m-%Y');

-- I FOUND INCORRECT DATETIME.
-- DATA CLEANING REQUIRED

SELECT Transaction_ID,Date_of_Purchase FROM railway_analysis
WHERE Date_of_Purchase = '31-12%2023';
UPDATE railway_analysis SET Date_of_Purchase= 31-12-2023 WHERE Transaction_ID='a478f358-044d-4000-b70e' ;

SELECT Transaction_ID, Date_of_Purchase FROM railway_analysis
WHERE Date_of_Purchase = '2023-12-31' ;
UPDATE railway_analysis SET Date_of_Purchase= 31-12-2023 WHERE Transaction_ID='a478f358-044d-4000-b70e';

SELECT Transaction_ID, Date_of_Purchase,Date_of_Journey FROM railway_analysis
WHERE Date_of_Purchase = '-2024';
UPDATE railway_analysis SET Date_of_Purchase= '01-01-2024' WHERE Transaction_ID='a478f358-044d-4000-b70e';

alter table railway_analysis modify column `Date_of_Purchase` date;


Select str_to_date(Date_of_Journey, '%d-%m-%Y'), Date_of_Journey from  railway_analysis;
update railway_analysis set Date_of_Journey =str_to_date(Date_of_Journey, '%d-%m-%Y');
alter table  railway_analysis modify column `Date_of_Journey` date;



Select str_to_date(Departure_Time, '%H:%i:s'), Departure_Time from railway_analysis;
update railway_analysis set Departure_Time =str_to_date(Departure_Time, '%H:%i:%s');

SELECT Transaction_ID, Departure_Time FROM railway_analysis
WHERE Departure_Time = '18:45::00' ;

UPDATE railway_analysis
SET Departure_Time = '18:45:00' 
WHERE Transaction_ID = '567c596c-40c9-419c-9af0';

alter table railway_analysis modify column `Departure_Time` time;

Select str_to_date(Arrival_Time, '%H:%i:s'), Arrival_Time from railway_analysis;
update railway_analysis set Arrival_Time =str_to_date(Arrival_Time, '%H:%i:%s');
alter table railway_analysis modify column `Arrival_Time` time;

Select str_to_date(Actual_Arrival_Time, '%H:%i:s'), Actual_Arrival_Time from railway_analysis;
update railway_analysis set Actual_Arrival_Time =str_to_date(Actual_Arrival_Time, '%H:%i:%s');

SELECT Transaction_ID, Actual_Arrival_Time FROM railway_analysis
WHERE Actual_Arrival_Time = '21:15::00';
UPDATE railway_analysis
SET Actual_Arrival_Time = '21:15:00' 
WHERE Transaction_ID = '9eefc132-f6ad-4a93-b61d';


SELECT Transaction_ID, Actual_Arrival_Time FROM railway_analysis
WHERE Actual_Arrival_Time = '19:15::00';
UPDATE railway_analysis
SET Actual_Arrival_Time = '19:15:00'
WHERE Transaction_ID = '8a8a890e-576b-47bb-a6b5';

alter table railway_analysis modify column `Actual_Arrival_Time` time;

select * from railway_analysis LIMIT 50000 ;


-- 1.	Identify Peak Purchase Times and Their Impact on Delays 
-- This query determines the peak times for ticket purchases and analyzes if there is any correlation with journey delays.--

SELECT 
    Date_of_Purchase,
    Date_of_Journey,
    Journey_Status,
    Departure_Time,
    Time_of_Purchase,
    COUNT(*) AS Purchase_Count
FROM 
    railway_analysis
WHERE 
    Journey_Status = "Delayed" 
    AND Date_of_Purchase = Date_of_Journey
GROUP BY 
    Date_of_Purchase,
    Date_of_Journey,
    Journey_Status,
    Departure_Time,
    Time_of_Purchase
ORDER BY 
    Purchase_Count DESC limit 50000 ;


SELECT 
    Date_of_Purchase,
    Date_of_Journey,
    Journey_Status,
    Departure_Time,
    Time_of_Purchase,
    COUNT(*) AS Purchase_Count
FROM 
    railway_analysis
WHERE 
    Journey_Status = "On Time" 
    AND Date_of_Purchase = Date_of_Journey
GROUP BY 
    Date_of_Purchase,
    Date_of_Journey,
    Journey_Status,
    Departure_Time,
    Time_of_Purchase
ORDER BY 
    Purchase_Count DESC limit 20000;
    
-- I did analysis of core relation between Time_of_Purchase and Journey_Status ,i obsorbed there is no core relation between both of them.
-- because of here same date booking also happen 12150  but there no time delay 
-- The  same date booking also happen 1080 passenger but there is time delay.
-- Finally obsorbed there is no core relation both of them
     

-- 2.Analyze Journey Patterns of Frequent Travelers: 
-- This query identifies frequent travelers (those who made more than three purchases) and analyzes their most common journey patterns. 

Select distinct Departure_Station from railway_analysis;
Select distinct Arrival_Destination from railway_analysis;
Select distinct Transaction_ID from railway_analysis limit 50000;

    
SELECT Departure_Station, Arrival_Destination,COUNT(*) AS Journey_Count FROM railway_analysis
GROUP BY Departure_Station, Arrival_Destination
HAVING Journey_Count > 3
ORDER BY Journey_Count DESC;

-- Passenger data not available,so i analyze passenger Departure_Station and Arrival_Destination. 


-- 3.	Revenue Loss Due to Delays with Refund Requests: 
 -- This query calculates the total revenue loss due to delayed journeys for which a refund request was made.
 
 SELECT SUM(Price) AS Total_Revenue_Loss
FROM railway_analysis
WHERE Journey_Status = 'Delayed' AND Refund_Request = "Yes";

-- I found total Revenue_Loss 26165.


-- 4.	Impact of Railcards on Ticket Prices and Journey Delays: 
-- This query analyzes the average ticket price and delay rate for journeys purchased with and without railcards.

SELECT Railcard,AVG(Price) AS Average_Ticket_Price,
AVG(CASE WHEN Journey_Status = 'Delayed' THEN 1 ELSE 0 END) AS Delay_Rate
FROM railway_analysis
GROUP BY Railcard;


-- 5.Journey Performance by Departure and Arrival Stations: 
-- This query evaluates the performance of journeys by calculating the average delay time for each pair of departure and arrival stations.


SELECT 
    Departure_Station,
    Arrival_Destination,
    AVG(TIMESTAMPDIFF(minute, Departure_Time, Arrival_Time)) AS Average_Delay_Minutes
FROM 
   railway_analysis
    where Journey_Status = "Delayed"
GROUP BY 
    Departure_Station, 
    Arrival_Destination
ORDER BY Average_Delay_Minutes desc;


-- Revenue and Delay Analysis by Railcard and Station
-- This query combines revenue analysis with delay statistics, providing insights into journeys' performance and revenue impact involving different railcards and stations.

SELECT
    Departure_Station,
    Arrival_Destination,
	Railcard,
    COUNT(Journey_Status) AS Total_Journeys,
    SUM(Price) AS Total_Revenue,
    AVG(TIMESTAMPDIFF(MINUTE,Departure_Time,Arrival_Time)) AS Average_Delay,
    SUM(CASE WHEN Journey_Status = 'Delayed' THEN 1 ELSE 0 END) AS Delayed_Journeys,
    SUM(CASE WHEN Journey_Status = 'Delayed' AND Refund_Request = TRUE THEN Price ELSE 0 END) AS Revenue_Loss_Due_To_Delays
FROM
    railway_analysis 
GROUP BY
    Departure_Station,
    Arrival_Destination,
    Railcard
ORDER BY
    Departure_Station,
    Arrival_Destination,
    Railcard;

-- Journey Delay Impact Analysis by Hour of Day
-- This query analyzes how delays vary across different hours of the day, calculating the average delay in minutes for each hour and identifying the peak hours for delays.

SELECT
    HOUR(Departure_Time) AS Departure_Hour,
    COUNT(Journey_Status) AS Total_Journeys,
    AVG(TIMESTAMPDIFF(MINUTE, Departure_Time, Arrival_Time)) AS Average_Delay_Minutes,
    SUM(CASE WHEN Journey_Status = 'Delayed' THEN 1 ELSE 0 END) AS Delayed_Journeys,
    AVG(CASE WHEN Journey_Status = 'Delayed' THEN TIMESTAMPDIFF(MINUTE, Departure_Time, Arrival_Time) ELSE NULL END) AS Average_Delay_Minutes_When_Delayed
FROM
    railway_analysis 
GROUP BY
    HOUR(Departure_Time)
ORDER BY
    Average_Delay_Minutes DESC;




