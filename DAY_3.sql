-- ===============================================================================================
-- DAY 3: PROSQL45 CHALLENGE (18 NOVEMBER, 2024)

-- PROBLEM 5: 
-- PARETO PRINCIPLE 

-- Challenge Inspiration:
-- https://www.youtube.com/watch?v=oGgE180oaTs&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=6

-- ====================================================================================================

SELECT Top 8 Order_ID, Product_ID, Sales FROM orders;

WITH product_sales AS (
    SELECT product_id, SUM(sales) AS Product_sales
    FROM orders
    GROUP BY product_id
),
running_total AS (
    SELECT *,
           SUM(Product_sales) OVER(ORDER BY Product_sales DESC) AS running_total,
           SUM(Product_sales) OVER() AS total_sales,  
           COUNT(1) OVER() AS total_products            
    FROM product_sales
)
SELECT COUNT(*) * 1.0 / MIN(total_products) * 100 AS percentage_of_products
FROM running_total
WHERE running_total <= 0.8 * total_sales;





-- ===============================================================================================

-- PROBLEM 6: 
-- Write a query to find PersonID, name, number of friends, sum of marks of person 
-- who have friends with total score greater than 100.

-- Challenge Inspiration:
-- https://www.youtube.com/watch?v=SfzbR69LquU&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=6

-- ====================================================================================================


-- persons table
CREATE TABLE persons (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Score INT
);

INSERT INTO persons (PersonID, Name, Email, Score) VALUES
(1, 'Alice', 'alice2018@hotmail.com', 88),
(2, 'Bob', 'bob2018@hotmail.com', 11),
(3, 'Davis', 'davis2018@hotmail.com', 27),
(4, 'Tara', 'tara2018@hotmail.com', 45),
(5, 'John', 'john2018@hotmail.com', 63);

-- Create the friends table
CREATE TABLE friends (
    PersonID INT,
    FriendID INT,
    PRIMARY KEY (PersonID, FriendID)
);


INSERT INTO friends (PersonID, FriendID) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 2),
(4, 3),
(4, 5);


SELECT * FROM persons;
SELECT * FROM friends;



WITH cte AS (
SELECT f.PersonID
    ,COUNT(f.FriendID) AS no_of_friends
     , SUM(p.Score) AS total_marks
FROM friendS F
INNER JOIN persons p
ON f.FriendID = p.PersonID
GROUP BY f.PersonID
HAVING SUM(p.Score) >= 100)
SELECT p.PersonID
	   , p.Name
	   , cte.no_of_friends
	   ,cte.total_marks
FROM cte
INNER JOIN persons p
ON p.PersonID = cte.PersonID;