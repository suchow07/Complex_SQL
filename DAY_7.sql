-- ===============================================================================================
-- DAY 7: PROSQL45 CHALLENGE (1 December, 2024)

-- PROBLEM 13: 
-- Write an SQL query to identify the most frequently purchased product pairs from the 'orders' and 'products' tables.

-- Video Solution: https://www.youtube.com/watch?v=9Kh7EnZlhUg&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=13
-- ====================================================================================================
create table orders
(
order_id int,
customer_id int,
product_id int,
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

SELECT * FROM orders;
SELECT * FROM products;

 -- =============================================
 -- SOLUTION
 -- =============================================

 
  SELECT p1.name + ' ' + p2.name AS pair, COUNT(*) AS purchase_freq
  FROM orders o1
  INNER JOIN orders o2
  ON o1.order_id = o2.order_id
  AND  o1.product_id < o2.product_id
  INNER JOIN products p1 ON p1.id = o1.product_id
  INNER JOIN products p2 ON p2.id = o2.product_id
  GROUP BY p1.name, p2.name

   -- drop table orders, products
-- ===============================================================================================

-- PROBLEM 14: 
-- Question:
-- Given the following two tables, calculate the fraction of users who accessed Amazon Music and upgraded
-- to Prime membership within the first 30 days of signing up. The result should be rounded to two decimal places.
--  

-- Video Solution: https://www.youtube.com/watch?v=i_ljK9gmstY&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=14
-- ====================================================================================================
create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));


SELECT * FROM users;
SELECT * FROM events;



 -- =============================================
 -- SOLUTION
 -- =============================================

 SELECT
COUNT(DISTINCT u.user_id) AS total_users,
COUNT(DISTINCT CASE WHEN DATEDIFF(DAY, u.join_date, e.access_date) <= 30 THEN u.user_id END) as prime_members
, ROUND(COUNT(DISTINCT 
    CASE WHEN DATEDIFF(DAY, u.join_date, e.access_date) <= 30 	THEN u.user_id END)* 1.0/COUNT(DISTINCT u.user_id),2)  AS prime_member_percent
FROM users u
LEFT JOIN events e
ON u.user_id = e.user_id
and e.type = 'P'
WHERE u.user_id IN (
SELECT user_id from events
WHERE type= 'Music') 

-- drop table users, events



