-- ===============================================================================================
-- DAY 3: PROSQL45 CHALLENGE (18 NOVEMBER, 2024)

-- PROBLEM 5: 
-- Problem: Calculate Daily Cancellation Rate for Unbanned Users

-- The cancellation rate is defined as the ratio of canceled trips (either by the client or driver) 
-- to the total number of trips, rounded to two decimal places.

-- Challenge Inspiration: https://leetcode.com/problems/trips-and-users/
-- Video Solution: https://www.youtube.com/watch?v=IQ4n4n-Y9z8&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=8

-- ====================================================================================================

Create table  Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));
Truncate table Trips;
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
Truncate table Users;
insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');



select * from Trips;
select * from Users;


SELECT request_at AS Day,
ROUND(SUM(CASE WHEN status <> 'completed' THEN 1 ELSE 0 END)* 1.0/ COUNT(*),2) AS 'Cancellation Rate'
FROM Trips t
INNER JOIN Users c
ON t.client_id = c.users_id
INNER JOIN Users d
ON t.driver_id = d.users_id
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
AND c.banned <> 'Yes' AND d.banned <> 'Yes'
GROUP BY request_at
ORDER BY request_at;




-- ===============================================================================================

-- PROBLEM 8: 
-- Problem: Find the Winner in Each Group

-- You are given two tables: Players and Matches. In each match, two players from the same group compete. 
-- The winner in each group is the player with the highest total score across all matches in that group. 
-- In case of a tie, the player with the lower player_id wins.
-- Write an SQL query to find the winner of each group.

-- Challenge Inspiration:https://leetcode.ca/all/1194.html
-- Video Solution: https://www.youtube.com/watch?v=SfzbR69LquU&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=6

-- ====================================================================================================

create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


select * from players;
select * from matches;

WITH scores AS (
SELECT first_player AS player_id
	   , first_score AS score
FROM matches
UNION ALL
SELECT second_player AS player_id
	   , second_score AS score
FROM matches), final_score AS (
SELECT s.player_id, p.group_id, SUM(score) AS total_score,
rank() over(partition by p.group_id order by SUM(score) desc,s.player_id) as rn
FROM scores s
INNER JOIN players p
ON p.player_id = s.player_id
GROUP BY s.player_id, p.group_id)
SELECT group_id , player_id as winner 
FROM final_score
where rn = 1;




