-- ===============================================================================================
-- DAY 11: PROSQL45 CHALLENGE (30 NOVEMBER, 2024)

-- PROBLEM 21: 
-- Problem Statemnt:
-- Given that each store is closed during one quarter of the year,
-- write a query to identify the missing quarter for each store.

-- Challenge Inspiration: 
-- Video Solution: https://www.youtube.com/watch?v=cGP5Tm2gVdQ&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=21
-- ====================================================================================================
CREATE TABLE stores (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO stores (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

SELECT * FROM stores;

 -- =============================================
 -- SOLUTION
 -- =============================================
 -- Method 1 : Aggregation
 SELECT store, 'Q' + CAST(10 - SUM(CAST(RIGHT(Quarter, 1) AS INT)) AS CHAR(2)) AS Quarter
FROM Stores
GROUP BY store;

-- Method 2: Using Recursive CTE
WITH  cte AS (
SELECT DISTINCT store, 1 AS q_no FROM stores
UNION ALL
SELECT store, q_no + 1 AS q_no
FROM cte
WHERE q_no <4
), q AS(
SELECT  store, 'Q' + CAST(q_no AS char(1)) AS q_no FROM cte)
SELECT q.* FROM q
 Left Join stores s
 on s.store = q.store
  and s.Quarter = q.q_no
 WHERE s.Quarter IS NULL
 ORDER BY q.store;
 
 -- Method 3: Using Cross Join
 WITH cte as ( 
 SELECT DISTINCT s1.store, s2.Quarter FROM 
 stores s1, stores s2)
 SELECT cte.* FROM cte 
 Left Join stores s
 on s.store = cte.store
 and s.quarter = cte.Quarter
 WHERE s.Quarter IS NULL





  -- drop table 
-- ===============================================================================================

-- PROBLEM 22: 
-- Question:
-- Given an exams table with columns for student_id, subject, and marks, write a query to find the
-- student_id of students who appear in both Physics and Chemistry and have obtained equal marks in both subjects.
--  

-- Video Solution: https://www.youtube.com/watch?v=aHShJ0hQtFc&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=22
-- ====================================================================================================

create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',80),(5,'Biology',80)
,(6,'Chemistry',85),(6,'Physics',85)
;

SELECT * FROM exams;

 -- =============================================
 -- SOLUTION
 -- =============================================
 
SELECT student_id
FROM exams
WHERE subject IN ('Chemistry', 'Physics')
GROUP BY student_id
HAVING COUNT(DISTINCT subject) = 2
AND MAX(marks) = MIN(marks);


-- drop table exams



