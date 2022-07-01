#q1

#to check total no. of players
select  count(player_ID) AS Total_Players from player;

#---------------------------------------------------

#q2

#creating view of max salary of every team
create view max_salary as 
select team_ID, salary, concat(F_name,' ', L_name) as full_name  from player where (team_ID,salary) in (select team_ID,max(salary) from player group by team_ID);

drop view max_salary;
#3

#using inner join to display the above view with the name of the team
SELECT max_salary.*, team.name
FROM max_salary
INNER JOIN team ON max_salary.team_ID=team.team_ID;

#-----------------------------------------------------

#q4

#creating view of avg salary of every team
create view avg_salary as 
select team_ID ,round((avg(salary)),2)from player group by team_ID ;

SELECT * from avg_salary;

#using inner join to display the above view with the name of the team
SELECT avg_salary.*, team.name
FROM avg_salary
INNER JOIN team ON avg_salary.team_ID=team.team_ID;

#------------------------------------------------------

#q5

#creating view for home team fixtures
create view ht_fixtures as
select fixtures.*, team.name
from fixtures
inner join team on fixtures.HomeID = team.temp_ID;

select * from ht_fixtures;

#creating view for Away team fixtures
create view at_fixtures as
select fixtures.*, team.name
from fixtures
inner join team on fixtures.AgainstID = team.temp_ID;

select * from at_fixtures;

#creating view for team fixtures
create view team_fixtures as
select ht_fixtures.Match_No, ht_fixtures.name as home_team,at_fixtures.name as away_team,ht_fixtures.HT_Goals,ht_fixtures.AT_Goals from ht_fixtures inner join at_fixtures on  ht_fixtures.Match_No = at_fixtures.Match_No order by ht_fixtures.Match_No asc;

select * from team_fixtures;

#-------------------------------------------------

#q6  select player whose names start with either P or M using like operator

select * from player where F_name like 'P%'or F_name like'M%';

#------------------------------------------------

#q7 check which manager manages which team
create view manager_and_team as
select concat(manager.F_name,' ', manager.L_name) as Manager_Name , team.name as Team_Name from manager inner join team on  manager.team_ID = team.team_ID;

select* from team_fixtusres;
#------------------------------------------------

create view player_and_team as
select team.name as Team_name ,player.*
from player
inner join team on player.team_ID = team.team_ID;


select * from player_and_team;

create view stadium_and_team as
select team.name as Team_name ,stadium.name as Stadium_Name, stadium.stadium_ID, stadium.location,stadium.capacity
from stadium
inner join team on stadium.team_ID = team.team_ID;

select * from stadium_and_team;
drop view stadium_and_team;