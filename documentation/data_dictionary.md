# Data Dictionary - Pizza Sales Dataset

This document provides a comprehensive description of the data fields in the pizza sales dataset used for analysis.

## Table: pizza_sales

| Column Name       | Data Type    | Description                                           | Example                   |
|-------------------|--------------|-------------------------------------------------------|---------------------------|
| pizza_id          | INT          | Unique identifier for each pizza record               | 1                         |
| order_id          | INT          | Unique identifier for each order                      | 1                         |
| pizza_name_id     | VARCHAR      | Unique identifier/code for the pizza type             | hawaiian_m                |
| quantity          | INT          | Number of pizzas ordered                              | 1                         |
| order_date        | DATE         | Date when the order was placed                        | 01-01-2015                |
| order_time        | TIME         | Time when the order was placed                        | 11:38:36                  |
| unit_price        | DECIMAL(5,2) | Price per pizza                                       | 13.25                     |
| total_price       | DECIMAL(5,2) | Total price for this pizza line item                  | 13.25                     |
| pizza_size        | VARCHAR      | Size of the pizza (S, M, L, XL, XXL)                 | M                         |
| pizza_category    | VARCHAR      | Category of the pizza                                 | Classic                   |
| pizza_ingredients | VARCHAR      | List of ingredients used in the pizza                 | Sliced Ham, Pineapple, Mozzarella Cheese |
| pizza_name        | VARCHAR      | Full name of the pizza                                | The Hawaiian Pizza        |

## Pizza Categories

The dataset includes the following pizza categories:

1. **Classic** - Traditional pizza offerings
2. **Supreme** - Premium pizza options with multiple toppings
3. **Chicken** - Pizzas with chicken as the primary topping
4. **Veggie** - Vegetarian pizza options without meat

## Pizza Sizes

The dataset includes the following pizza sizes:

1. **S** - Small
2. **M** - Medium
3. **L** - Large
4. **XL** - Extra Large (if present in the data)
5. **XXL** - Extra Extra Large (if present in the data)

## Pizza Name ID Format

The pizza_name_id field appears to follow the format: `[pizza_type]_[size]`, where:
- `[pizza_type]` is a shortened version of the pizza name (e.g., "hawaiian" for "The Hawaiian Pizza")
- `[size]` is the pizza size code (s, m, l, etc.)

## Key Metrics Derived from the Data

1. **Total Revenue** - Calculated as the sum of total_price for all orders
2. **Average Order Value** - Total revenue divided by the number of unique orders
3. **Total Pizzas Sold** - Sum of quantity for all orders
4. **Total Orders** - Count of unique order_id values
5. **Average Pizzas Per Order** - Total pizzas sold divided by the total number of orders

## Sample Data

| pizza_id | order_id | pizza_name_id  | quantity | order_date  | order_time | unit_price | total_price | pizza_size | pizza_category | pizza_ingredients                                                | pizza_name             |
|----------|----------|----------------|----------|-------------|------------|------------|-------------|------------|----------------|----------------------------------------------------------------|------------------------|
| 1        | 1        | hawaiian_m     | 1        | 01-01-2015  | 11:38:36   | 13.25      | 13.25       | M          | Classic        | Sliced Ham, Pineapple, Mozzarella Cheese                        | The Hawaiian Pizza     |
| 2        | 2        | classic_dlx_m  | 1        | 01-01-2015  | 11:57:40   | 16.00      | 16.00       | M          | Classic        | Pepperoni, Mushrooms, Red Onions, Red Peppers, Bacon            | The Classic Deluxe Pizza |
| 3        | 2        | five_cheese_l  | 1        | 01-01-2015  | 11:57:40   | 18.50      | 18.50       | L          | Veggie         | Mozzarella Cheese, Provolone Cheese, Smoked Gouda Cheese, Romano Cheese, Blue Cheese, Garlic | The Five Cheese Pizza  |

## Notes

- A single order (identified by order_id) may contain multiple pizza items.
- The total_price represents the price for the specific pizza and quantity in that line item.
- The dataset includes detailed pizza ingredient information allowing for potential ingredient-level analysis.
- The pizza_name_id field provides a unique code for each pizza type and size combination.
- The order_date and order_time fields are stored separately, allowing for detailed time-series analysis.
