#creating view of max salary of every team
create view max_salary as 
select team_ID, salary, concat(F_name,' ', L_name) as full_name  from player where (team_ID,salary) in (select team_ID,max(salary) from player group by team_ID);


#creating view of avg salary of every team
create view avg_salary as 
select team_ID ,round((avg(salary)),2)from player group by team_ID ;


#creating view for home team fixtures
create view ht_fixtures as
select fixtures.*, team.name
from fixtures
inner join team on fixtures.HomeID = team.temp_ID;


#creating view for Away team fixtures
create view at_fixtures as
select fixtures.*, team.name
from fixtures
inner join team on fixtures.AgainstID = team.temp_ID;


#creating view for team fixtures
create view team_fixtures as
select ht_fixtures.Match_No, ht_fixtures.name as home_team,at_fixtures.name as away_team,ht_fixtures.HT_Goals,ht_fixtures.AT_Goals from ht_fixtures inner join at_fixtures on  ht_fixtures.Match_No = at_fixtures.Match_No order by ht_fixtures.Match_No asc;


#q7 check which manager manages which team
create view manager_and_team as
select concat(manager.F_name,' ', manager.L_name) as Manager_Name , team.name as Team_Name from manager inner join team on  manager.team_ID = team.team_ID;


create view player_and_team as
select team.name as Team_name ,player.*
from player
inner join team on player.team_ID = team.team_ID;


create view stadium_and_team as
select team.name as Team_name ,stadium.name as Stadium_Name, stadium.stadium_ID, stadium.location,stadium.capacity
from stadium
inner join team on stadium.team_ID = team.team_ID;
