-- DAY 2: PROSQL45 CHALLENGE (17 NOVEMBER, 2024)

-- PROBLEM 3: 

-- Challenge Inspiration:
-- https://www.youtube.com/watch?v=P6kNMyqKD0A&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=3

-- Scenario based question. 

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');


SELECT * FROM entries;


WITH total_visited AS (
    SELECT name, COUNT(1) AS total_visited
    FROM entries
    GROUP BY name
),
most_visited AS (
    SELECT name,
           floor,
           COUNT(1) AS floor_visits,
           RANK() OVER (PARTITION BY name ORDER BY COUNT(1) DESC) AS rn
    FROM entries
    GROUP BY name, floor
),
resources AS (
    SELECT DISTINCT name, resources
    FROM entries
),
used_resources AS (
    SELECT name, STRING_AGG(resources, ', ') AS resources
    FROM resources
    GROUP BY name
)
SELECT mv.name,
       tv.total_visited,
       mv.floor AS most_visited_floor,
       ur.resources AS resources
FROM total_visited tv
INNER JOIN most_visited mv ON tv.name = mv.name
INNER JOIN used_resources ur ON tv.name = ur.name
WHERE mv.rn = 1;


-- ==================================================================================================

-- PROBLEM 4: 

-- Challenge Inspiration:
-- https://www.youtube.com/watch?v=6XQAokp4UCs&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=4

-- SQL Question Asked in a FAANG Interview
-- Write a query to provide date for the nth occurace of Sunday in future from the given date.

-- ======================================================================================================


DECLARE @input_date DATE
DECLARE @N INT
SET @N = 2
SET @input_date = '2024-11-15'
SELECT DATEADD(DAY, 1 + 7*@N - DATEPART(WEEKDAY,  @input_date), @input_date) AS nth_sunday;