-- ===============================================================================================
-- DAY 5: PROSQL45 CHALLENGE (20 NOVEMBER, 2024)

-- PROBLEM 9: 
-- Problem: Calculate Daily Cancellation Rate for Unbanned Users

-- The cancellation rate is defined as the ratio of canceled trips (either by the client or driver) 
-- to the total number of trips, rounded to two decimal places.

-- Challenge Inspiration: https://leetcode.ca/all/1159.html
-- Video Solution: https://www.youtube.com/watch?v=1ias-sP_XAY&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=9

-- ====================================================================================================


create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);



 -- =============================================
 -- SOLUTION
 -- =============================================
 SELECT * FROM users;
 SELECT * FROM items;
 SELECT * FROM orders;




WITH ranked_orders
     AS (SELECT o.seller_id,
                o.order_date,
                i.item_brand,
                Row_number()
                  OVER (
                    partition BY o.seller_id
                    ORDER BY o.order_date) AS rn
         FROM   orders o
                LEFT JOIN items i
                       ON o.item_id = i.item_id)
SELECT u.user_id           AS seller_id,
       COALESCE(CASE WHEN u.favorite_brand = ro.item_brand 
	           THEN 'Yes' ELSE 'No' END, 'No') 
	          AS '2nd_item_fav_brand'
FROM   users u
       LEFT JOIN ranked_orders ro
              ON u.user_id = ro.seller_id
WHERE  ro.rn = 2
        OR ro.rn IS NULL 


-- ===============================================================================================

-- PROBLEM 10: 
-- Question:
-- Given the tasks table with columns date_value and state, write an SQL query to find the start date, end date,
-- and state for each state group, where the start date is the first occurrence and the end date is the last
-- occurrence of each state.

-- Video Solution: https://www.youtube.com/watch?v=WrToXXN7Jb4&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=10

-- ====================================================================================================

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')

select * from tasks;
 -- =============================================
 -- SOLUTION
 -- =============================================

With cte AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY state ORDER BY date_value) AS rn,
DATEADD(DAY, -1 * ROW_NUMBER() OVER(PARTITION BY state ORDER BY date_value), date_value) AS group_date
FROM tasks
ORDER BY date_value)
SELECT MIN(date_value) AS start_date, MAX(date_value) AS end_date, state
FROM cte
GROUP BY state, group_date
ORDER BY start_date





















