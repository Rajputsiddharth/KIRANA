
-- OLAP 1
-- This query will give us the total quantity of products sold in each category for each month in each year, along with the subtotals for each month, year, and category.
SELECT YEAR(order_date) AS year,
       MONTH(order_date) AS month,
       category.name AS category_name,
       SUM(purchased.quantity) AS quantity
FROM Orders
JOIN Purchased ON Orders.order_id = Purchased.order_id
JOIN Product ON Purchased.product_id = Product.product_id
JOIN category ON Product.category_id = category.category_id
GROUP BY year, month, category_name WITH ROLLUP;

-- OLAP 2
-- Drill down query to find revenue by seller and category, will give the output of each seller and each category he/she is selling
SELECT Seller.name, Category.name, SUM(Product.price * Purchased.quantity) as revenue
FROM Seller
INNER JOIN Product ON Seller.seller_id = Product.seller_id
INNER JOIN Category ON Product.category_id = Category.category_id
INNER JOIN Purchased ON Product.product_id = Purchased.product_id
GROUP BY Seller.name, Category.name;

-- OLAP 3
-- this olap query slices the data by age range using a CASE statement to group customers into different age brackets, and dices it by city
Use kirana;
SELECT 
    CASE 
        WHEN YEAR(date_of_birth) >= 2003 THEN 'Under 18'
        WHEN YEAR(date_of_birth) BETWEEN 1994 AND 2002 THEN '18-27'
        WHEN YEAR(date_of_birth) BETWEEN 1984 AND 1993 THEN '28-37'
        WHEN YEAR(date_of_birth) BETWEEN 1974 AND 1983 THEN '38-47'
        ELSE 'Over 47'
    END AS age_range, city, COUNT(*) AS num_customers
FROM Customer
GROUP BY age_range, city
ORDER BY age_range ASC, num_customers DESC;

-- OLAP 4
-- this olap query uses the pivot function to display the number of products sold by each seller, categorized by their rating from 1 to 5 stars
SELECT s.name AS 'Seller', 
       COUNT(CASE WHEN p.rating = 1 THEN 1 END) AS '1 Star', 
       COUNT(CASE WHEN p.rating = 2 THEN 1 END) AS '2 Stars', 
       COUNT(CASE WHEN p.rating = 3 THEN 1 END) AS '3 Stars', 
       COUNT(CASE WHEN p.rating = 4 THEN 1 END) AS '4 Stars', 
       COUNT(CASE WHEN p.rating = 5 THEN 1 END) AS '5 Stars'
FROM Seller s
JOIN Product p ON s.seller_id = p.seller_id
JOIN Purchased pu ON p.product_id = pu.product_id
GROUP BY s.seller_id;


-- OLAP 5
-- Top 10 customers who have made most number of oders
SELECT Customer.first_name, COUNT(Orders.order_id) AS Total_Orders
FROM Customer
INNER JOIN Orders ON Customer.customer_id = Orders.customer_id
GROUP BY Customer.customer_id
ORDER BY Total_Orders DESC
LIMIT 10;

-- OLAP 6
-- Current Cutomer demographics, customer belonging to different age groups
SELECT COUNT(*) AS num_customers, YEAR(date_of_birth) AS birth_year, MONTH(date_of_birth) AS birth_month
FROM Customer
GROUP BY birth_year, birth_month;






