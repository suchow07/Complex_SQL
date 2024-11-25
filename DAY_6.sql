-- ===============================================================================================
-- DAY 6: PROSQL45 CHALLENGE (21 NOVEMBER, 2024)

-- PROBLEM 11: 


-- Challenge Inspiration: https://leetcode.ca/all/1159.html
-- Video Solution: https://www.youtube.com/watch?v=4MLVfsQEGl0&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=11

-- ====================================================================================================
create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100), (4,'2019-07-01','desktop',150),
(4,'2019-07-02','mobile',100);
insert into spending values (4,'2019-07-01','mobile',100);

select * from spending;

 -- =============================================
 -- SOLUTION
 -- =============================================
 WITH cte AS (
  SELECT
    user_id,
    spend_date,
    SUM(amount) AS total_amount,
    MAX(platform) as platform
FROM Spending
GROUP BY user_id, spend_date
having count(distinct platform) = 1
UNION ALL
  SELECT
    user_id,
    spend_date,
    SUM(amount) AS total_amount,
    'both' as platform
FROM Spending
GROUP BY user_id, spend_date
having count(distinct platform) > 1

)
  SELECT spend_date, platform, sum(total_amount) as total_sales
  , count( Distinct user_id) as total_users FROM cte
  group by spend_date, platform
  order by spend_date;



  -- Method 2:
  WITH cte AS (
  SELECT
    user_id,
    spend_date,
    SUM(amount) AS total_amount,
    CASE 
        WHEN COUNT(DISTINCT platform) = 1 THEN MAX(platform)
        ELSE 'both'
    END AS platform
FROM Spending
GROUP BY user_id, spend_date
)
  SELECT spend_date, platform, sum(total_amount) as total_sales
  , count( Distinct user_id) as total_users FROM cte
  group by spend_date, platform
  order by spend_date;

  -- drop table spending
-- ===============================================================================================

-- PROBLEM 12: 
-- Question:https://leetcode.ca/all/1384.html
-- Write an SQL query to calculate the total sales amount for each product in each year (2018, 2019, 2020),
-- including the product_id, product_name, report_year, and total_amount. 

-- Video Solution: https://www.youtube.com/watch?v=ewmEHQSQYRM&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=12

-- ====================================================================================================

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);

INSERT INTO Product (product_id, product_name)
VALUES
    (1, 'LC Phone'),
    (2, 'LC T-Shirt'),
    (3, 'LC Keychain');

CREATE TABLE Sales (
    product_id INT,
    period_start VARCHAR(10),
    period_end DATE,
    average_daily_sales INT,
    PRIMARY KEY (product_id, period_start)
);

INSERT INTO Sales (product_id, period_start, period_end, average_daily_sales)
VALUES
    (1, '2019-01-25', '2019-02-28', 100),
    (2, '2018-12-01', '2020-01-01', 10),
    (3, '2019-12-01', '2020-01-31', 1);

select * from Product;
SELECT * FROM Sales;


 -- =============================================
 -- SOLUTION
 -- =============================================

WITH cte AS(
SELECT product_id
       , CAST(period_start AS DATE) AS period_start
	   , period_end, average_daily_sales 
FROM Sales
UNION ALL
SELECT product_id, DATEADD(DAY, 1, period_start)
        , period_end, average_daily_sales
FROM cte
WHERE period_start < period_end
)
SELECT p.product_id, p.product_name, 
       YEAR(cte.period_start) AS report_year
	   , SUM(cte.average_daily_sales) AS total_sales
FROM cte
INNER JOIN Product p
ON P.product_id = cte.product_id
GROUP BY p.product_id, p.product_name, YEAR(cte.period_start)
ORDER BY p.product_id, report_year
OPTION (MAXRECURSION 1000);



