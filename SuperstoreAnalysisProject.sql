DROP DATABASE IF EXISTS Superstore_DB;
CREATE DATABASE Superstore_DB;
USE Superstore_DB;

CREATE TABLE Global_Superstore_src (
`Row ID` text,
`Order ID` text,
`Order Date` text,
`Ship Date` text,
`Ship Mode` text,
`Customer ID` text,
`Customer Name` text,
`Segment` text,
`City` text,
`State` text,
`Country` text,
`Postal Code` text,
`Market` text,
`Region` text,
`Product ID` text,
`Category` text,
`Sub-Category` text,
`Product Name` text,
`Sales` text,
`Quantity` text,	
`Discount` text,
`Profit` text,	
`Shipping Cost` text,
`Order Priority` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/evanadinolfe/Downloads/Global_Superstore2.csv'
INTO TABLE Global_Superstore_src
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM Global_Superstore_src;


UPDATE Global_Superstore_src
SET `Order Date` = DATE_FORMAT(
  CASE
    WHEN `Order Date` LIKE '____-__-__'
      THEN STR_TO_DATE(`Order Date`, '%Y-%m-%d')
    WHEN `Order Date` LIKE '__-__-____'
      THEN STR_TO_DATE(`Order Date`, '%d-%m-%Y')
    WHEN `Order Date` LIKE '%/%/%'
      THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    ELSE NULL
  END,
  '%Y-%m-%d'
);

UPDATE Global_Superstore_src
SET `Ship Date` = DATE_FORMAT(
  CASE
    WHEN `Ship Date` LIKE '____-__-__'
      THEN STR_TO_DATE(`Ship Date`, '%Y-%m-%d')
    WHEN `Ship Date` LIKE '__-__-____'
      THEN STR_TO_DATE(`Ship Date`, '%d-%m-%Y')
    WHEN `Ship Date` LIKE '%/%/%'
      THEN STR_TO_DATE(`Ship Date`, '%m/%d/%Y')
    ELSE NULL
  END,
  '%Y-%m-%d'
);

UPDATE Global_Superstore_src
SET `Postal Code` = NULL
WHERE `Postal Code` = '';

SELECT `Ship Date`
FROM Global_Superstore_src
WHERE `Ship Date` LIKE '10%';

SELECT MAX(length(`order id`))
FROM global_superstore_src;

SELECT MAX(length(`ship mode`))
FROM global_superstore_src;

SELECT MAX(length(`customer id`))
FROM global_superstore_src;

SELECT MAX(length(`segment`))
FROM global_superstore_src;

SELECT MAX(length(`market`))
FROM global_superstore_src;

SELECT MAX(length(`region`))
FROM global_superstore_src;

SELECT MAX(length(`category`))
FROM global_superstore_src;

SELECT MAX(length(`sub-category`))
FROM global_superstore_src;

SELECT MAX(length(`order priority`))
FROM global_superstore_src;

UPDATE global_superstore_src
SET `state` = REPLACE(`state`, ',,','a');

UPDATE global_superstore_src
SET `state` = REPLACE(`state`, ',','a');

UPDATE global_superstore_src
SET `state` = REPLACE(`state`, '¸','a');

UPDATE global_superstore_src
SET `state` = REPLACE(`state`, '·','a');

UPDATE global_superstore_src
SET `city` = REPLACE(`city`, ',,','a');

UPDATE global_superstore_src
SET `city` = REPLACE(`city`, ',','a');

UPDATE global_superstore_src
SET `city` = REPLACE(`city`, '¸','a');

UPDATE global_superstore_src
SET `city` = REPLACE(`city`, '·','a');

SELECT * FROM Global_Superstore_src;

SELECT `order id`, COUNT(`order date`) AS total
FROM global_superstore_src
GROUP BY `order id`
HAVING total > 1;

SELECT `customer id`, COUNT(`customer id`)
FROM global_superstore_src
GROUP BY `customer id`
HAVING COUNT(`customer id`) > 1;

CREATE TABLE Superstore (
Row_ID INT AUTO_INCREMENT PRIMARY KEY,
Order_ID VARCHAR(15),
Order_Date DATE,
Ship_Date DATE,
Ship_Mode VARCHAR(14),
Customer_ID VARCHAR(8) DEFAULT NULL,
Customer_Name VARCHAR(100),
Segment VARCHAR(11),
City VARCHAR(100),
State VARCHAR(100),
Country VARCHAR(100),
Postal_Code INT,
Market VARCHAR(6),
Region VARCHAR(14),
Product_ID VARCHAR(100),
Category VARCHAR(15),
SubCategory VARCHAR(11),
Product_Name VARCHAR(200),
Sales DECIMAL(25,6),
Quantity INT,
Discount DECIMAL(6,5),
Profit DECIMAL(20,6),
Shipping_Cost DECIMAL(12,4),
Order_Priority VARCHAR(9)
);

INSERT INTO Superstore (Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, City, 
State, Country, Postal_Code, Market, Region, Product_ID, Category, SubCategory, Product_Name, Sales, Quantity, Discount, Profit,
Shipping_Cost, Order_Priority)
SELECT DISTINCT
`Row ID`,
`Order ID`,
`Order Date`,
`Ship Date`,
`Ship Mode`,
`Customer ID`,
`Customer Name`,
`Segment`,
`City`,
`State`,
`Country`,
`Postal Code`,
`Market`,
`Region`,
`Product ID`,
`Category`,
`Sub-Category`,
`Product Name`,
`Sales`,
`Quantity`,	
`Discount`,
`Profit`,	
`Shipping Cost`,
`Order Priority`
FROM Global_Superstore_src;

SELECT * FROM Superstore;

UPDATE superstore
SET state = REPLACE(state, '„','a')
WHERE state LIKE '%„%';

UPDATE superstore
SET state = REPLACE(state, '‚','a')
WHERE state LIKE '%‚%';

UPDATE superstore
SET state = REPLACE(state, '¸','a')
WHERE state LIKE '%¸%';

UPDATE superstore
SET state = REPLACE(state, '·','a')
WHERE state LIKE '%·%';

UPDATE superstore
SET city = REPLACE(city, '„','a')
WHERE city LIKE '%„%';

UPDATE superstore
SET city = REPLACE(city, '‚','a')
WHERE city LIKE '%‚%';

UPDATE superstore
SET city = REPLACE(city, '¸','a')
WHERE city LIKE '%¸%';

UPDATE superstore
SET city = REPLACE(city, '·','a')
WHERE city LIKE '%·%';

UPDATE superstore
SET state = REPLACE(state, 'È','e')
WHERE state LIKE '%È%';

UPDATE superstore
SET city = REPLACE(city, 'È','e')
WHERE city LIKE '%È%';

UPDATE superstore
SET state = REPLACE(state, 'Û','u')
WHERE state LIKE '%Û%';

UPDATE superstore
SET city = REPLACE(city, 'Û','u')
WHERE city LIKE '%Û%';

UPDATE superstore
SET city = REPLACE(city, '''','');

UPDATE superstore
SET state = REPLACE(state, '''','');

UPDATE superstore
SET city = REPLACE(city, 'Ì','i');

UPDATE superstore
SET state = REPLACE(state, 'Ì','i');

UPDATE superstore
SET city = REPLACE(city, '˙','u');

UPDATE superstore
SET state = REPLACE(state, '˙','u');

UPDATE superstore
SET city = REPLACE(city, 'Á','a');

UPDATE superstore
SET state = REPLACE(state, 'Á','a');

ALTER TABLE Superstore
ADD OrderYear INT, ADD OrderMonth INT;

UPDATE Superstore
SET OrderYear = SUBSTRING(Order_Date, 1,4);

UPDATE Superstore
SET OrderMonth = SUBSTRING(Order_Date, 6,2);

UPDATE Superstore
SET Order_Priority = TRIM(Order_Priority);

#Customer that spent the most money
SELECT Customer_ID, Customer_Name, Segment, CONCAT('$', FORMAT(SUM(Sales),0)) AS Total_Spent
FROM Superstore
GROUP BY Customer_ID, Customer_Name, Segment
HAVING SUM(Sales) = (
SELECT MAX(Total_Spent)
FROM (
SELECT Customer_ID, Customer_Name, Segment, SUM(Sales) AS Total_Spent
FROM Superstore
GROUP BY Customer_ID, Customer_Name, Segment
) AS Max_Sales);

#Best selling product (number of sales) since 2011
SELECT Product_Name, Category, SubCategory, COUNT(Product_Name) AS Amount_Sold
FROM Superstore
WHERE Order_Date > '2011-01-01'
GROUP BY Product_Name, Category, SubCategory
HAVING COUNT(Product_Name) = (
SELECT MAX(Amount_Sold)
FROM (
SELECT Product_Name, Category, SubCategory, COUNT(Product_Name) AS Amount_Sold
FROM Superstore
WHERE Order_Date > '2011-01-01'
GROUP BY Product_Name, Category, SubCategory)
AS Max_Amount);

#Find the total profit generated by each segment in each year
SELECT Segment, OrderYear, CONCAT('$', FORMAT(SUM(Profit),2)) AS Total_Profit
FROM Superstore
GROUP BY Segment, OrderYear
ORDER BY OrderYear ASC;

#Percent of customers in each country
SELECT Country, CONCAT(FORMAT(COUNT(Customer_Name) / (SELECT COUNT(Customer_Name) FROM Superstore) * 100, 3), '%') AS Percent_of_Customers
FROM Superstore
GROUP BY Country
ORDER BY COUNT(Customer_Name) / (SELECT COUNT(Customer_Name) FROM Superstore) * 100 DESC;

#Percent of customers in each market
SELECT Market, CONCAT(FORMAT(COUNT(Customer_Name) / (SELECT COUNT(Customer_Name) FROM Superstore) * 100, 3), '%') AS Percent_of_Customers
FROM Superstore
GROUP BY Market
ORDER BY COUNT(Customer_Name) / (SELECT COUNT(Customer_Name) FROM Superstore) * 100 DESC;

#Percent of profit in each market
SELECT Market, CONCAT(FORMAT(SUM(Profit) / (SELECT SUM(Profit) FROM Superstore) * 100, 3), '%') AS Percent_of_Profit
FROM Superstore
GROUP BY Market
ORDER BY SUM(Profit) / (SELECT SUM(Profit) FROM Superstore) * 100 DESC;

#Profit increase percentage in each country from 2011 to 2014 (only include countries that produced at least $10,000 profit in 2011)
WITH ProfitPerYear AS (
  SELECT Country, OrderYear, SUM(Profit) AS Profit_per_Year
  FROM Superstore
  WHERE OrderYear IN ('2011', '2014')
  GROUP BY Country, OrderYear
  HAVING SUM(Profit) > '10,000'
),
ProfitTable AS (
  SELECT 
    Country,
    SUM(CASE WHEN OrderYear = '2011' THEN Profit_per_Year END) AS Profit_2011,
    SUM(CASE WHEN OrderYear = '2014' THEN Profit_per_Year END) AS Profit_2014
  FROM ProfitPerYear
  GROUP BY Country
)
SELECT 
  Country,
  CONCAT(FORMAT(((Profit_2014 - Profit_2011) / Profit_2011) * 100, 2), '%') AS Percent_Change
FROM ProfitTable
WHERE Profit_2011 IS NOT NULL AND Profit_2014 IS NOT NULL
GROUP BY Country
ORDER BY ((Profit_2014 - Profit_2011) / Profit_2011) DESC;

#Top 10 most profitable products of 2014
SELECT Product_Name, CONCAT('$', FORMAT(SUM(Profit),2)) AS Total_Profit
FROM Superstore
WHERE OrderYear = '2014'
GROUP BY Product_Name
ORDER BY SUM(Profit) DESC
LIMIT 10;

#Product sales by month
SELECT OrderMonth, CONCAT('$', FORMAT(SUM(Sales),0)) AS Sales_Total
FROM Superstore
GROUP BY OrderMonth
ORDER BY OrderMonth ASC;

#US cities producing the most sales
SELECT City, FORMAT(SUM(Sales),0) AS Total_Sales
FROM Superstore
WHERE Country = 'United States'
GROUP BY City
ORDER BY SUM(Sales) DESC;

#Products with highest profit margin
SELECT Product_Name, SubCategory, AVG(Profit / Sales) AS Profit_Margin
FROM Superstore
GROUP BY Product_Name, SubCategory
ORDER BY Profit_Margin DESC
LIMIT 20;

#SubCategories sorted by Profit Margin
SELECT SubCategory, FORMAT(AVG(Profit / Sales),4) AS Profit_Margin, ROUND(AVG(discount),2) AS Avg_Discount
FROM Superstore
GROUP BY SubCategory
ORDER BY Profit_Margin DESC
LIMIT 20;

#Customers with most money spent
SELECT Segment, Customer_ID, SUM(Sales) AS lifetime_sales
FROM Superstore
GROUP BY Segment, Customer_ID
ORDER BY lifetime_sales DESC;

#Average order value per market segment
SELECT Segment, CONCAT('$',ROUND(SUM(Sales) / COUNT(Order_ID),2)) AS Avg_Order_Value
FROM Superstore
GROUP BY Segment
ORDER BY Avg_Order_Value DESC;

#Correlation between average discount and profit margin for each market segment
SELECT Segment, ROUND(AVG(Profit / Sales),4) AS Profit_Margin, ROUND(AVG(Discount),4) AS Avg_Discount
FROM Superstore
GROUP BY Segment
ORDER BY Profit_Margin DESC;

#Percentage of on time shipments for different regional markets
SELECT Market, CONCAT(ROUND(SUM(CASE WHEN DATEDIFF(Ship_Date,Order_Date) <= 7 AND 
DATEDIFF(Ship_Date,Order_Date) >= 0 THEN 1 END)*100.0/COUNT(*),2),'%') AS percentage_ontime
FROM Superstore
GROUP BY Market
ORDER BY percentage_ontime DESC;

#Shipping delay over time
SELECT OrderYear, CONCAT(ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)),2), ' days') AS Shipping_Delay
FROM Superstore
GROUP BY OrderYear
ORDER BY OrderYear ASC;

#Correlation between long shipping delays and profit
SELECT Order_Priority, CONCAT('$', FORMAT(SUM(Profit),2)) AS Profit,
CONCAT(ROUND(SUM(CASE WHEN DATEDIFF(Ship_Date,Order_Date) >= 7 THEN 1 END)*100.0/COUNT(*),2),'%') AS LongDelay_Percentage
FROM Superstore
WHERE Profit > 5
GROUP BY Order_Priority;

#Percent of profit from each product category 
SELECT SubCategory, CONCAT('$', FORMAT(SUM(Profit), 2)) AS Total_Profit,
CONCAT(ROUND(SUM(Profit) / (SELECT SUM(Profit) FROM Superstore) * 100, 3), '%') AS Percent_of_Profit
FROM Superstore
GROUP BY SubCategory
ORDER BY SUM(Profit) DESC;


