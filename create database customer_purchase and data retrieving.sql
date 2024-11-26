-- DDL/DML CHANGES
create database customer_purchase;

-- [Question 1A] use DDL commands to add a column to the customers table called street. add this column directly after the address column
ALTER TABLE customers 
ADD COLUMN street VARCHAR(255) AFTER address;
select * from customers;
-- [Question 1B] update this column by extracting the street name from address
-- (hint: MySQL also has mid/left/right functions the same as excel. You can first test these with SELECT before using UPDATE)
-- Test with SELECT first
SELECT address, LEFT(address, LOCATE(' ', address) - 1) AS street_name
FROM customers;
    set sql_safe_updates=0;
    UPDATE customers
SET street = LEFT(address, LOCATE(' ', address) - 1);
-- [Question 2A] Using DDL commands, add a column called stock_level to the items table.
ALTER TABLE items
ADD COLUMN stock_level VARCHAR(50);
select * from customers;
select * from items;
select * from orders;
-- [Question 2B] Use CASE to update the stock_level column in the following way:
-- low stock if the amount is below 20
-- moderate stock if the amount is between 20 and 50
-- high stock if the amount is over 50
-- null in all other cases
UPDATE items
SET stock_level = CASE 
    WHEN amount_in_stock < 20 THEN 'low stock'
    WHEN amount_in_stock  BETWEEN 20 AND 50 THEN 'moderate stock'
    WHEN amount_in_stock  > 50 THEN 'high stock'
    ELSE NULL
END;
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- QUERIES


-- [Question 1] In a SIMPLE SELECT query, make a column called price_label in which label each item's price as:
-- low price if its price is below 10
-- moderate price if its price is between 10 and 50
-- high price if its price is above 50
-- "unavailable" in all other cases

-- order this query by price in descending order
SELECT item_name, item_price,
    CASE 
        WHEN item_price < 10 THEN 'low price'
        WHEN item_price BETWEEN 10 AND 50 THEN 'moderate price'
        WHEN item_price > 50 THEN 'high price'
        ELSE 'unavailable'
    END AS price_label
FROM items
ORDER BY item_price DESC;
-- [Question 2]
-- USING A JOIN AND GROUPING, find out the total number of orders per street per city. Your results should show street, city and total_orders
-- results should be ordered by street in ascending order and cities in descending order
SELECT c.street, c.city, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.street, c.city
ORDER BY c.street ASC, c.city DESC;
-- [Question 3]
-- USING A JOIN, select the following:
-- customer_id, last name, address, phone number, order id, order date, item name, item type, and item price. 
SELECT c.customer_id, c.last_name, c.address, c.phone_number, 
       o.order_id, o.order_date, i.item_name, i.item_type, i.item_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN items i ON o.item_id = i.item_id;
-- [Question 4A]
-- USING A JOIN, select customer_ids, first names, last names and addresses of customers who have never placed an order.
-- Only these four columns should show in your results
SELECT c.customer_id, c.first_name, c.last_name, c.address
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
-- [Question 4B]
-- DO THE EXACT SAME AS ABOVE USING A MULTI-ROW SUBQUERY IN THE WHERE CLAUSE
-- select customer_ids, first_names, last_names and addresses of customers who have never placed an order.
-- Only these four columns should show in your results
SELECT c.customer_id, c.first_name, c.last_name, c.address
FROM customers c
WHERE c.customer_id NOT IN (SELECT customer_id FROM orders);
-- [Question 5A]
-- USING A CORRELATED SUBQUERY IN THE WHERE CLAUSE:
-- select item id, item name, item type and item price for all those items that have a price higher than the average price FOR THEIR ITEM TYPE (NOT average of the whole column)
-- order your result by item type;
SELECT item_id, item_name, item_type, item_price
FROM items i
WHERE item_price > (
    SELECT AVG(i2.item_price)
    FROM items i2
    WHERE i2.item_type = i.item_type
)
ORDER BY item_type;
-- [Question 5B]
-- DO THE EXACT SAME QUERY USING AVG WITH WINDOW FUNCTION AND A CTE:
-- select item id, item name, item type and item price for all those items that have a price higher than the average price FOR THEIR ITEM TYPE (NOT average of the whole column)
-- order your result by item type;

-- HINT: Inside your CTE, select all the columns being asked for and also make an avg column using partition that shows the avg per item type
-- Then use this column outside the CTE to filter records
WITH ItemAvg AS (
    SELECT item_id, item_name, item_type, item_price,
           AVG(item_price) OVER (PARTITION BY item_type) AS avg_price
    FROM items
)
SELECT item_id, item_name, item_type, item_price
FROM ItemAvg
WHERE item_price > avg_price
ORDER BY item_type;
-- [Question 6] 
-- USING A SUBQUERY IN THE WHERE CLAUSE, find out customer ids, order date and item id of their most recent order
-- order your result by customer_id
SELECT customer_id, order_date, item_id
FROM orders o
WHERE order_date = (
    SELECT MAX(order_date)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
)
ORDER BY customer_id;
-- [Question 7] 
-- USE A CTE AND RANK WINDOW FUCTION to find the third most expensive item/items in each category
-- your query should return item_id, item_name, item_type and item_price for all these items
WITH RankedItems AS (
    SELECT item_id, 
           item_name, 
           item_type, 
           item_price, 
           RANK() OVER (PARTITION BY item_type ORDER BY item_price DESC) AS rank_items
    FROM items
)
SELECT item_id, item_name, item_type, item_price
FROM RankedItems
WHERE rank_items = 3;
select * from customers;
select * from items;
select * from orders;
-- [Question 8A]
-- USE A JOIN to show customers who placed an order in their birth MONTH
-- Your results should show customer_id, concatenated full_name, phone_number, date_of_birth, item_id and order_date

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       c.phone_number, c.date_of_birth, o.item_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE MONTH(c.date_of_birth) = MONTH(o.order_date);

-- [Question 8B]
-- USE A MULTI ROW AND MULTI COLUMN SUBQUERY to show customers who placed an order on their birth DAY
-- Your results should show customer_id, concatenated full_name, phone_number, and date_of_birth
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
       c.phone_number, c.date_of_birth
FROM customers c
WHERE (c.customer_id, DAY(c.date_of_birth)) IN (
    SELECT o.customer_id, DAY(o.order_date)
    FROM orders o
);
