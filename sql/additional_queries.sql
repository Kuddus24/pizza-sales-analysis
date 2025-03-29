/*
Pizza Sales Analysis - Additional Queries
----------------------------------------
This file contains additional SQL queries for more in-depth analysis 
of the pizza sales data that go beyond basic KPIs and chart requirements.
*/

-- Hourly Trend Analysis
-- Identifies peak hours for pizza orders
SELECT 
    DATEPART(HOUR, order_date) AS Hour_Of_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
    pizza_sales
GROUP BY 
    DATEPART(HOUR, order_date)
ORDER BY 
    Hour_Of_Day;

-- Sales Analysis by Day of Week and Hour
-- Shows the busiest day and hour combinations
SELECT 
    DATENAME(DW, order_date) AS Day_Of_Week,
    DATEPART(HOUR, order_date) AS Hour_Of_Day,
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales
GROUP BY 
    DATENAME(DW, order_date),
    DATEPART(HOUR, order_date)
ORDER BY 
    Total_Orders DESC;

-- Pizza Combinations Analysis
-- Shows which pizzas are commonly ordered together
SELECT 
    a.pizza_name AS Pizza1,
    b.pizza_name AS Pizza2,
    COUNT(*) AS Combination_Count
FROM 
    pizza_sales a
JOIN 
    pizza_sales b ON a.order_id = b.order_id
WHERE 
    a.pizza_name < b.pizza_name
GROUP BY 
    a.pizza_name, 
    b.pizza_name
ORDER BY 
    Combination_Count DESC;

-- Seasonal Analysis
-- Analyzes sales patterns by quarter and month
SELECT 
    DATEPART(QUARTER, order_date) AS Quarter,
    DATENAME(MONTH, order_date) AS Month,
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(quantity) AS Total_Quantity,
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales
GROUP BY 
    DATEPART(QUARTER, order_date),
    DATENAME(MONTH, order_date),
    MONTH(order_date)
ORDER BY 
    DATEPART(QUARTER, order_date),
    MONTH(order_date);

-- Average Price per Pizza Category and Size
-- Analyzes pricing structure across categories and sizes
SELECT 
    pizza_category,
    pizza_size,
    AVG(total_price/quantity) AS Average_Price_Per_Pizza,
    MIN(total_price/quantity) AS Min_Price,
    MAX(total_price/quantity) AS Max_Price
FROM 
    pizza_sales
GROUP BY 
    pizza_category,
    pizza_size
ORDER BY 
    pizza_category,
    pizza_size;

-- Order Size Analysis
-- Analyzes the distribution of order sizes by quantity of pizzas
SELECT 
    Quantity_Range,
    COUNT(*) AS Order_Count,
    SUM(Total_Amount) AS Total_Revenue
FROM (
    SELECT 
        order_id,
        CASE 
            WHEN SUM(quantity) = 1 THEN '1 Pizza'
            WHEN SUM(quantity) = 2 THEN '2 Pizzas'
            WHEN SUM(quantity) BETWEEN 3 AND 5 THEN '3-5 Pizzas'
            ELSE '6+ Pizzas'
        END AS Quantity_Range,
        SUM(total_price) AS Total_Amount
    FROM 
        pizza_sales
    GROUP BY 
        order_id
) AS OrderSizes
GROUP BY 
    Quantity_Range
ORDER BY 
    CASE Quantity_Range
        WHEN '1 Pizza' THEN 1
        WHEN '2 Pizzas' THEN 2
        WHEN '3-5 Pizzas' THEN 3
        ELSE 4
    END;

-- Revenue Contribution Analysis
-- Detailed breakdown of revenue contributions
SELECT 
    pizza_category,
    pizza_size,
    COUNT(DISTINCT order_id) AS Order_Count,
    SUM(quantity) AS Pizza_Count,
    SUM(total_price) AS Total_Revenue,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS Revenue_PCT
FROM 
    pizza_sales
GROUP BY 
    pizza_category,
    pizza_size
ORDER BY 
    pizza_category,
    Revenue_PCT DESC;

-- Running Total Analysis by Date
-- Shows cumulative sales over time
SELECT 
    CAST(order_date AS DATE) AS Order_Day,
    SUM(total_price) AS Daily_Revenue,
    SUM(SUM(total_price)) OVER (ORDER BY CAST(order_date AS DATE)) AS Running_Total
FROM 
    pizza_sales
GROUP BY 
    CAST(order_date AS DATE)
ORDER BY 
    Order_Day;

-- Customer Order Frequency Analysis
-- If there's a customer_id column (not mentioned in the provided schema)
-- This query would need modification if customer identification isn't available
-- Shows ordering patterns if tracking repeat customers
/*
SELECT 
    customer_id,
    COUNT(DISTINCT order_id) AS Order_Count,
    SUM(total_price) AS Total_Spent,
    MIN(order_date) AS First_Order_Date,
    MAX(order_date) AS Most_Recent_Order_Date,
    DATEDIFF(DAY, MIN(order_date), MAX(order_date)) AS Customer_Lifetime_Days,
    SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM 
    pizza_sales
GROUP BY 
    customer_id
ORDER BY 
    Order_Count DESC;
*/

-- Pizza Popularity By Time Period
-- Shows which pizzas are most popular at different times of day
SELECT 
    pizza_name,
    CASE 
        WHEN DATEPART(HOUR, order_date) BETWEEN 6 AND 11 THEN 'Morning (6AM-12PM)'
        WHEN DATEPART(HOUR, order_date) BETWEEN 12 AND 17 THEN 'Afternoon (12PM-6PM)'
        WHEN DATEPART(HOUR, order_date) BETWEEN 18 AND 21 THEN 'Evening (6PM-10PM)'
        ELSE 'Night (10PM-6AM)'
    END AS Time_Of_Day,
    COUNT(*) AS Order_Count,
    SUM(quantity) AS Pizza_Quantity,
    RANK() OVER(PARTITION BY 
        CASE 
            WHEN DATEPART(HOUR, order_date) BETWEEN 6 AND 11 THEN 'Morning (6AM-12PM)'
            WHEN DATEPART(HOUR, order_date) BETWEEN 12 AND 17 THEN 'Afternoon (12PM-6PM)'
            WHEN DATEPART(HOUR, order_date) BETWEEN 18 AND 21 THEN 'Evening (6PM-10PM)'
            ELSE 'Night (10PM-6AM)'
        END
        ORDER BY COUNT(*) DESC) AS Popularity_Rank
FROM 
    pizza_sales
GROUP BY 
    pizza_name,
    CASE 
        WHEN DATEPART(HOUR, order_date) BETWEEN 6 AND 11 THEN 'Morning (6AM-12PM)'
        WHEN DATEPART(HOUR, order_date) BETWEEN 12 AND 17 THEN 'Afternoon (12PM-6PM)'
        WHEN DATEPART(HOUR, order_date) BETWEEN 18 AND 21 THEN 'Evening (6PM-10PM)'
        ELSE 'Night (10PM-6AM)'
    END
HAVING 
    COUNT(*) > 10
ORDER BY 
    Time_Of_Day,
    Popularity_Rank;
