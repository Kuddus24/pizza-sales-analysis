/*
Pizza Sales Analysis - KPI Queries
---------------------------------
This file contains SQL queries to calculate key performance indicators (KPIs)
for pizza sales data analysis.
*/

-- 1. Total Revenue
-- The sum of the total price of all pizza orders
SELECT 
    SUM(total_price) AS Total_Revenue 
FROM 
    pizza_sales;

-- 2. Average Order Value
-- The average amount spent per order
SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value 
FROM 
    pizza_sales;

-- 3. Total Pizzas Sold
-- The sum of quantities of all pizzas sold
SELECT 
    SUM(quantity) AS Total_Pizzas_Sold 
FROM 
    pizza_sales;

-- 4. Total Orders
-- The total number of orders placed
SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders 
FROM 
    pizza_sales;

-- 5. Average Pizzas Per Order
-- The average number of pizzas sold per order
SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) / 
        CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
    AS DECIMAL(10,2)) AS Average_Pizzas_Per_Order 
FROM 
    pizza_sales;
