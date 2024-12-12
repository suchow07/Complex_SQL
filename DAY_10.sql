-- ===============================================================================================
-- DAY 10: PROSQL45 CHALLENGE (29 NOVEMBER, 2024)

-- PROBLEM 19: 


-- Problem Statement: spotify Case Study 
-- Video Solution: https://www.youtube.com/watch?v=-YdAIMjHZrM&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=20
-- ====================================================================================================
CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

SELECT * FROM activity;

 -- =============================================
 -- SOLUTION
 -- =============================================
 -- Question 1: Write a query to find active users each day.
 SELECT event_date, COUNT(DISTINCT user_id) AS total_active_users
 FROM activity
 GROUP BY event_date

  -- Question 2: Write a query to find active users each week.
 SELECT DATENAME(week, event_date) AS week, COUNT(DISTINCT user_id) AS total_active_users
 FROM activity
 GROUP BY DATENAME(week, event_date);

  -- Question 3: Write a query to find active users each day who purchased the same day they installed the app.
WITH cte AS
(SELECT user_id, event_date
        , CASE WHEN COUNT(DISTINCT event_name) = 2 THEN user_id ELSE NULL END AS new_users
FROM activity
GROUP BY user_id, event_date)
SELECT event_date, COUNT(new_users) AS no_counts
FROM cte
GROUP BY event_date;

-- Question 4: Write a query to find the percentage of paid users in India, USA, and any other country should be tagges as Others
WITH users_by_country AS(
SELECT 
	  CASE WHEN country IN ('India', 'USA') THEN country ELSE 'Others' END AS country,
	  COUNT(user_id) AS paid_users
FROM activity
WHERE event_name = 'app-purchase'
GROUP BY CASE WHEN country IN ('India', 'USA') THEN country ELSE 'Others' END)
, total AS (
SELECT SUM(paid_users) AS total_users 
FROM users_by_country)
SELECT country, paid_users * 100/ total_users AS no_users
FROM users_by_country, total;


-- Question 5: Among all the ussers who installed the app on a given day,
-- how many did in app purchase on the next very day.
WITH prev_data AS (
SELECT a1.user_id, a1.event_date,
a2.user_id AS id
FROM activity a1
LEFT JOIN activity a2
ON a1.user_id = a2.user_id
AND DATEDIFF(DAY, a2.event_date, a1.event_date) = 1)
SELECT event_date, COUNT(id) AS user_count
FROM prev_data
GROUP BY event_date


  -- drop table 
-- ===============================================================================================

-- PROBLEM 20: 
-- Question:
-- Given a table 'bms' with columns seat_no and is_empty, write a query to find the number of
-- instances where 3 or more consecutive seats are empty.
--  

-- Video Solution: https://www.youtube.com/watch?v=F9Otofceer0&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=20
-- ====================================================================================================
create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');

SELECT * FROM bms;


 -- =============================================
 -- SOLUTION
 -- =============================================



-- drop table 



