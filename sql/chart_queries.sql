/*
Pizza Sales Analysis - Chart Queries
-----------------------------------
This file contains SQL queries to generate data for various charts and visualizations
for pizza sales data analysis.
*/

-- 1. Daily Trend for Total Orders
-- Shows the total number of orders by day of the week
SELECT 
    DATENAME(DW, order_date) AS order_day, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
    pizza_sales
GROUP BY 
    DATENAME(DW, order_date);

-- 2. Monthly Trend for Total Orders
-- Shows the total number of orders by month, ordered by volume
SELECT 
    DATENAME(MM, order_date) AS Month_Name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
    pizza_sales
GROUP BY 
    DATENAME(MM, order_date)
ORDER BY 
    Total_Orders DESC;

-- 3. Percentage of Sales by Pizza Category
-- Shows the contribution of each pizza category to overall sales
SELECT 
    pizza_category, 
    SUM(total_price) AS Total_Sales, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM 
    pizza_sales
GROUP BY 
    pizza_category;

-- For a specific month (e.g., January)
SELECT 
    pizza_category, 
    SUM(total_price) AS Total_Sales, 
    SUM(total_price) * 100 / (
        SELECT SUM(total_price) 
        FROM pizza_sales 
        WHERE MONTH(order_date) = 1
    ) AS PCT
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_category;

-- 4. Percentage of Sales by Pizza Size
-- Shows the contribution of each pizza size to overall sales
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) 
    AS DECIMAL(10,2)) AS PCT
FROM 
    pizza_sales
GROUP BY 
    pizza_size
ORDER BY 
    PCT DESC;

-- For a specific quarter (e.g., Q1)
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        SUM(total_price) * 100 / (
            SELECT SUM(total_price) 
            FROM pizza_sales 
            WHERE DATEPART(quarter, order_date) = 1
        ) 
    AS DECIMAL(10,2)) AS PCT
FROM 
    pizza_sales
WHERE 
    DATEPART(quarter, order_date) = 1
GROUP BY 
    pizza_size
ORDER BY 
    PCT DESC;

-- 5. Total Pizzas Sold by Pizza Category
-- Shows the total quantity of pizzas sold for each category
SELECT 
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold 
FROM 
    pizza_sales
GROUP BY 
    pizza_category
ORDER BY 
    Total_Quantity_Sold DESC;

-- For a specific month (e.g., February)
SELECT 
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold 
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 2
GROUP BY 
    pizza_category
ORDER BY 
    Total_Quantity_Sold DESC;

-- 6. Top 5 Best Sellers by Revenue
SELECT TOP 5 
    pizza_name, 
    SUM(total_price) AS Revenue 
FROM 
    pizza_sales
GROUP BY 
    pizza_name 
ORDER BY 
    Revenue DESC;

-- 6b. Top 5 Best Sellers by Total Quantity
SELECT TOP 5 
    pizza_name, 
    SUM(quantity) AS Total_Quantity 
FROM 
    pizza_sales
GROUP BY 
    pizza_name 
ORDER BY 
    Total_Quantity DESC;

-- 6c. Top 5 Best Sellers by Total Orders
SELECT TOP 5 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders 
FROM 
    pizza_sales
GROUP BY 
    pizza_name 
ORDER BY 
    Total_Orders DESC;

-- 7. Bottom 5 Best Sellers by Revenue
SELECT TOP 5 
    pizza_name, 
    SUM(total_price) AS Revenue 
FROM 
    pizza_sales
GROUP BY 
    pizza_name 
ORDER BY 
    Revenue ASC;

-- 7b. Bottom 5 Best Sellers by Total Quantity
SELECT TOP 5 
    pizza_name, 
    SUM(quantity) AS Total_Quantity 
FROM 
    pizza_sales
GROUP BY 
    pizza_name 
ORDER BY 
    Total_Quantity ASC;

-- 7c. Bottom 5 Best Sellers by Total Orders
SELECT TOP 5 
    pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders 
FROM 
    pizza_sales
GROUP BY 
    pizza_name 
ORDER BY 
    Total_Orders ASC;
