-- ===============================================================================================
-- DAY 8: PROSQL45 CHALLENGE (2 DECEMBER, 2024)

-- PROBLEM 15: Customer Retention Analysis


-- Problem Statement:
-- Calculate the customer retention rate for each month by determining how many unique customers who made a purchase
-- in the previous month also made a purchase in the current month.
-- Video Solution: https://www.youtube.com/watch?v=6hfsRqmyvog&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=15
-- ====================================================================================================
create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
delete from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;
SELECT * FROM transactions;
SELECT * FROM transactions;
 -- =============================================
 -- SOLUTION
 -- =============================================

 SELECT MONTH(this_month.order_date) AS month,
		COUNT( DISTINCT last_month.cust_id ) AS retention
 FROM transactions this_month
 LEFT JOIN transactions last_month
 ON this_month.cust_id = last_month.cust_id AND 
    DATEDIFF(MONTH, last_month.order_date, this_month.order_date) = 1
GROUP BY MONTH(this_month.order_date)


  -- drop table 
-- ===============================================================================================

-- PROBLEM 16: 
-- Question: Customer Churn Analysis
-- Problem Statement
--  Identify the number of unique customers who made a purchase in the previous month but did not make 
-- a purchase in the current month, indicating customer churn for each month.

-- Video Solution: https://www.youtube.com/watch?v=hGflhxWWxTI&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=16
-- ====================================================================================================



 -- =============================================
 -- SOLUTION
 -- =============================================

 SELECT MONTH(last_month.order_date) AS month,
        COUNT( DISTINCT last_month.cust_id ) AS churn
 FROM transactions last_month
 LEFT JOIN transactions this_month
 ON this_month.cust_id = last_month.cust_id AND 
    DATEDIFF(MONTH, last_month.order_date, this_month.order_date) = 1
 WHERE this_month.cust_id IS NULL
 GROUP BY MONTH(last_month.order_date)

-- drop table transactions



