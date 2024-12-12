-- ===============================================================================================
-- DAY 13: PROSQL45 CHALLENGE (1 DECEMBER, 2024)

-- PROBLEM 25:Meesho HackerRank SQL Interview Question  
-- Problem Statement:
-- Write a query to find how many products  along with the list of products can a customer can buy with their mentioned budgets.
-- In case of clash choose the less costly products.


-- Video Solution: https://www.youtube.com/watch?v=B09xhslOvxw&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=25
-- ====================================================================================================
create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

SELECT * FROM products;
SELECT * FROM customer_budget;
 -- =============================================
 -- SOLUTION
 -- =============================================
 WITH running_sum AS (
 SELECT *,
 SUM(cost) over(ORDER BY cost) as running_total
 FROM products)
 SELECT customer_id, MIN(budget) AS budget, 
 COUNT(product_id) AS no_of_products,
 STRING_AGG(product_id, ', ') AS list_of_products
 FROM customer_budget cb
 INNER JOIN running_sum rs
 ON rs.running_total < cb.budget
 GROUP BY customer_id
 ORDER BY customer_id
 
 
  ;
  -- drop table 
-- ===============================================================================================

-- PROBLEM 26: Amazon Interview Question
-- Probelm Statement: Horizontal Sorting in SQL 
-- Write a query to find the total number of messages exchanged between each person each day
--  

-- Video Solution: https://www.youtube.com/watch?v=FZm7NgybHWA&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=26
-- ====================================================================================================
CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);
SELECT * FROM subscriber;


 -- =============================================
 -- SOLUTION
 -- =============================================
WITH cte AS(
SELECT  CASE WHEN sender < receiver THEN sender ELSE receiver END AS person1
	  , CASE WHEN sender > receiver THEN sender ELSE receiver END AS person2
	  , sms_no
FROM subscriber)
SELECT person1, person2, SUM(sms_no) AS total_msgs
FROM cte
GROUP BY person1, person2;

-- drop table 



