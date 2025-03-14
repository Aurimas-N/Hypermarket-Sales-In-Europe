# Hypermarket Sales In Europe Countries Project

# Introduction
This project analyzes dummy sales data from hypermarket across European countries. The data was cleaned and processed using SQL, then visualized through an interactive sales dashboard to uncover key insights.

# Tasks
* Explore, clean and analyse dataset in BigQuery SQL
* Create interactive dashboard in Tableau that shows:
  * KPI's
  * Sales and profit by country
  * Yearly, monthly sales and profit
  * Top selling products and profit they bring
  * Average processing time between order and shipment

# Dataset
* Data is in one `.xlxs` format file.
* Data is between 2010-2017 years.
* The dataset contains records: `Country`,	`Item Type`,	`Sales`, `Channel`,	`Order Date`,	`Order ID`,	`Ship Date`,	`Units Sold`,	`Unit Price`,	`Unit Cost`,	`Total Revenue`,	`Total Cost`,	`Total Profit`.
* Data is stored in **BigQuery**.
* [Uncleaned data in `.xlxs` format](sales_uncleaned.xlsx).

# Data Processing And Cleaning
* Data is uploaded to **BigQuery** for exploration, cleaning and analysis by using **SQL**.
* Data vizualisation was developed with **Tableau**.
* [Exploration, cleaning and Analyze process](Exploration_cleaning_analysis.sql) with **BigQuery SQL**.
* Column `processing_time` that shows difference in days between order and shipment is added.

# Share






