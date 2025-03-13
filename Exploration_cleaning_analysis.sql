-- EXPLORATION:

-- First of all checking data schema to identify if data types are correct - they are all correct.

-- Checking for missing values:
SELECT 
  COUNT(*) - COUNT(`Country`) AS missing_Country,
  COUNT(*) - COUNT(`Item Type`) AS missing_Item_Type,
  COUNT(*) - COUNT(`Sales Channel`) AS missing_Sales_Channel,
  COUNT(*) - COUNT(`Order ID`) AS missing_Order_ID,
  COUNT(*) - COUNT(`Order Date`) AS missing_Order_Date,
  COUNT(*) - COUNT(`Ship Date`) AS missing_Ship_Date,
  COUNT(*) - COUNT(`Units Sold`) AS missing_Units_Sold,
  COUNT(*) - COUNT(`Unit Price`) AS missing_Unit_Price,
  COUNT(*) - COUNT(`Unit Cost`) AS missing_Unit_Cost,
  COUNT(*) - COUNT(`Total Revenue`) AS missing_Total_Revenue,
  COUNT(*) - COUNT(`Total Cost`) AS missing_Total_Cost,
  COUNT(*) - COUNT(`Total Profit`) AS missing_Total_Profit
FROM `hypermarket-sales.sales_data.hypermarket_sales`;
-- As a result i found there is one missing value in Sales Channel column, it will be fixes in cleaning process.

-- Checking for dublicates in Order Id column because its our primary key:
SELECT Order_ID, COUNT(*) AS count
FROM `hypermarket-sales.sales_data.hypermarket_sales`
GROUP BY Order_ID
HAVING COUNT(*) > 1;
-- There is two dublicates of Order Id, it will be cleared during cleaning process.

-- Checking earliest and latest order and ship dates to ensure the date range makes sense.
SELECT 
  MIN(`Order Date`) AS earliest_order,
  MAX(`Order Date`) AS latest_order,
  MIN(`Ship Date`) AS earliest_ship,
  MAX(`Ship Date`) AS latest_ship
FROM `hypermarket-sales.sales_data.hypermarket_sales`;
-- there is no anomalies.

--Checking for incostistense values:
SELECT DISTINCT `Item Type`
FROM `hypermarket-sales.sales_data.hypermarket_sales`;

SELECT DISTINCT `Country`
FROM `hypermarket-sales.sales_data.hypermarket_sales`;

SELECT DISTINCT `Sales Channel`
FROM `hypermarket-sales.sales_data.hypermarket_sales`;
-- no incosistensies found.

-- CLEANING:

-- Checking the row where is missing value, to decide how to deal with it.
SELECT *
FROM `hypermarket-sales.sales_data.hypermarket_sales`
WHERE `Sales Channel` IS NULL;

-- I checked the primary key of the row and since i know what the value is missing in there i replace it with "Online"
UPDATE `hypermarket-sales.sales_data.hypermarket_sales`
SET `Sales Channel` = 'Online'
WHERE `Order ID` = 715309798 AND `Sales Channel` IS NULL;

-- Clearing dublicates by 'Order Id' column.

CREATE OR REPLACE TABLE `hypermarket-sales.sales_data.hypermarket_sales_cleaned` AS
WITH cte AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY `Order ID` ORDER BY `Order ID`) AS row_num
  FROM `hypermarket-sales.sales_data.hypermarket_sales`
)
SELECT `Country`, `Item Type`, `Sales Channel`, `Order Date`, `Order ID`, 
       `Ship Date`, `Units Sold`, `Unit Price`, `Unit Cost`, `Total Revenue`, 
       `Total Cost`, `Total Profit`
FROM cte
WHERE row_num = 1;
-- Finding dublicates by 'Order Id' and keeping only first found row where rest is deleted. Checked again for dublicates and there are 0.

-- Changing the headers and columns to lower case, except country name. Changing space between words with "_".
CREATE OR REPLACE TABLE `hypermarket-sales.sales_data.hypermarket_sales_cleaned_lowercase` AS
SELECT 
  `Country` AS country,
  LOWER(`Item Type`) AS item_type,
  LOWER(`Sales Channel`) AS sales_channel,
  `Order ID` AS order_id,
  `Order Date` AS order_date,
  `Ship Date` AS ship_date,
  `Units Sold` AS units_sold,
  `Unit Price` AS unit_price,
  `Unit Cost` AS unit_cost,
  `Total Revenue` AS total_revenue,
  `Total Cost` AS total_cost,
  `Total Profit` AS total_profit
FROM `hypermarket-sales.sales_data.hypermarket_sales_cleaned`;




