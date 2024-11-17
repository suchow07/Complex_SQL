-- DAY 1: PROSQL45 CHALLENGE (16 NOVEMBER, 2024)

-- ==========================================================================================================
-- PROBLEM 1

-- Challenge Inspiration:
-- https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=1

-- Write a query to derive points table for a typical tournament

-- ==========================================================================================================


use sharonya;
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

-- Derive a point table

WITH cte
     AS (SELECT team_1 AS Team_name,
                CASE WHEN team_1 = winner THEN 1 ELSE 0 END    AS Wins
         FROM   icc_world_cup
         UNION ALL
         SELECT team_2,
                CASE WHEN team_2 = winner THEN 1 ELSE 0 END
         FROM   icc_world_cup)
SELECT Team_name,
       Count(1)             AS Matches,
       Sum(wins)            AS Wins,
       Count(1) - Sum(wins) AS Loses
FROM   cte
GROUP  BY Team_name
ORDER  BY wins DESC; 


-- ======================================================================================================

-- PROBLEM 2

-- Challenge Inspiration:
-- https://www.youtube.com/watch?v=MpAMjtvarrc&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2

-- Write a query to find  finding new and repeat customers using SQL

-- ==========================================================================================================

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

-- select * from customer_orders;


WITH cte
     AS (SELECT customer_id
                , MIN(order_date)    AS first_order_date
         FROM   customer_orders
         GROUP  BY customer_id)
SELECT co.order_date,
       SUM(CASE
             WHEN co.order_date = cte.first_order_date THEN 1
             ELSE 0
           END) AS new_customer_count,
       SUM(CASE
             WHEN co.order_date != cte.first_order_date THEN 1
             ELSE 0
           END) AS repeat_customer_count
FROM   customer_orders co
       JOIN cte
         ON co.customer_id = cte.customer_id
GROUP  BY co.order_date
ORDER  BY co.order_date; 

