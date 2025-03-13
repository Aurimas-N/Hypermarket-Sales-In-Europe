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

--CLEANING:
-- 

