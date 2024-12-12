-- ===============================================================================================
-- DAY 12: PROSQL45 CHALLENGE (1 DECEMBER, 2024)

-- PROBLEM 23: 
-- Write a SQL query to identify cities where the number of COVID-19 cases is increasing daily.


-- Video Solution: https://www.youtube.com/watch?v=7okRHS6WL0c&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=23
-- ====================================================================================================
create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);


SELECT * FROM covid;
 -- =============================================
 -- SOLUTION
 -- =============================================
 WITH cte AS (
 SELECT *,
 RANK() OVER(PARTITION BY city ORDER BY days ASC) -
 RANK() OVER(PARTITION BY city ORDER BY cases ASC) AS diff
 FROM covid)
 SELECT city 
 FROM cte
 GROUP BY city
 HAVING COUNT(DISTINCT diff) = 1 AND MIN(diff) = 0;
  -- drop table 
-- ===============================================================================================

-- PROBLEM 24: 
-- Question:
-- Write a query to find companies that have at least two users who speak both English and German
--  

-- Video Solution: https://www.youtube.com/watch?v=35gjU7pChQk&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=24
-- ====================================================================================================
create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

SELECT * FROM company_users;


 -- =============================================
 -- SOLUTION
 -- =============================================
 WITH cte AS (
 SELECT company_id, user_id
 FROM company_users
 WHERE language IN ('English', 'German')
 GROUP BY company_id, user_id
 HAVING  COUNT(language) = 2)
 SELECT company_id
 FROM cte
 GROUP BY company_id
 HAVING COUNT(user_id) >= 2;

-- drop table 



