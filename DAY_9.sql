-- ===============================================================================================
-- DAY 9: PROSQL45 CHALLENGE (4 December, 2024)

-- PROBLEM 17: 
-- Problem Statement:
-- Write an SQL query to return the second most recent activity for each user from the UserActivity table. 
-- If a user has only one activity, return that activity instead. Include username, activity, startDate, 
-- and endDate, ordered by the most recent activity.

-- Challenge Inspiration: https://leetcode.ca/all/1369.html
-- Video Solution: https://www.youtube.com/watch?v=RljzVfz8vjk&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=17
-- ====================================================================================================


create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18')
,('Bob','Travel','2020-02-19','2020-02-28')
,('Charlie','Dancing','2020-02-14','2020-02-19');


SELECT * FROM UserActivity;
 -- =============================================
 -- SOLUTION
 -- =============================================
 WITH cte AS (
    SELECT  *,
          COUNT(1) OVER(PARTITION BY username) AS total_activities,
          RANK() OVER(PARTITION BY username 
		          ORDER BY endDate DESC) AS rn FROM UserActivity)
SELECT username
	   , activity
	   , startDate
	   , endDate 
FROM cte
WHERE rn = 2  
     OR total_activities = 1;

  -- drop table UserActivity


-- ===============================================================================================

-- PROBLEM 18: 
-- Question:
-- Given the Billings and HoursWorked tables, write an SQL query to calculate the total charges for each
-- employee based on their hourly rates and the hours worked, considering the billing rate for each 
-- employee is valid between consecutive billing dates.
--  

-- Video Solution: https://www.youtube.com/watch?v=51ryMCf-fvU&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=18
-- ====================================================================================================
create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)

SELECT * FROM billings;
SELECT * FROM HoursWorked;
 -- =============================================
 -- SOLUTION
 -- =============================================
WITH cte AS (
  SELECT *,
  LEAD(DATEADD(DAY, -1,bill_date),1, '9999-12-31') 
    OVER(PARTITION BY emp_name ORDER BY bill_date) as last_date
FROM billings) 
SELECT h.emp_name
	   , SUM(cte.bill_rate * h.bill_hrs) AS totalcharges
FROM cte
INNER JOIN HoursWorked h
ON cte.emp_name = h.emp_name
   AND h.work_date BETWEEN  cte.bill_date AND cte.last_date
GROUP BY h.emp_name



-- drop table 



