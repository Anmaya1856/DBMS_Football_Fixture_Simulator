call drop_all_tables();
call create_all_tables();
CALL InsertFixtures((select max(team_ID) from team));
CALL InsertRand((select max(Match_No) from fixtures), -1, 5);
call create_all_tables();
call drop_all_tables();

CALL InsertFixtures();
CALL InsertRand();


select * from fixtures;
select * from team;
desc team;

select * from player;
delete from team where team_ID = '6';

Drop procedure InsertRand;
Drop procedure InsertFixtures;
Drop Table fixtures;
Drop table team;

#Query to insert new match
INSERT INTO fixtures(Match_No,HomeID,AgainstID) VALUES ('21','1', '2');
Delete from fixtures where Match_No = '21';

#query to sort the points table according to points and tiebreaker according to goal difference
select * from team order by points desc, goals_difference desc, goals_scored desc, goals_conceded asc;