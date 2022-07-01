Create Table Team 
	(team_ID numeric(20) primary key,
	name varchar(30) not null,
	goals_conceded numeric(20) DEFAULT 0,
	goals_scored numeric(20) DEFAULT 0,
	goals_difference numeric(20) DEFAULT 0,
	wins numeric(20) DEFAULT 0,
	losses numeric(20) DEFAULT 0,
	draws numeric(20) DEFAULT 0,
	points numeric(20) DEFAULT 0
	);


CREATE TABLE fixtures (
    Match_No numeric(10) primary key,
    HomeID numeric(20),
    AgainstID numeric(20),
    HT_Goals numeric(20),
    AT_Goals numeric(20),
    foreign key(HomeID) references Team(team_ID),
     foreign key(AgainstID) references Team(team_ID)
);


Create Table Player
	(player_ID varchar(20) primary key,
	F_name varchar(20),
	L_name varchar(20),
	Age numeric(2),
	position varchar(20),
	team_ID numeric(20),
	Salary NUMERIC(20),
	foreign key (team_id) references Team (team_ID) on delete set null);

Create Table Stadium
	(stadium_ID varchar(20) primary key,
	name varchar(20) ,
	location varchar(20),
	capacity numeric(10),
    team_ID numeric(20),
    foreign key (team_ID) references Team (team_ID) on delete set null
	);

Create Table Manager
	(manager_ID varchar(20) primary key,
	F_name varchar(20),
	L_name varchar(20),
	Age numeric(5),
	salary varchar(10),
	team_ID numeric(20),
	foreign key (team_ID) references Team(team_ID) on delete set null);

Create Table manages
	(manager_ID varchar(20),
	team_ID numeric(20),
	primary key (team_ID),
	foreign key (team_ID) references Team(team_ID),
	foreign key (manager_ID) references Manager(manager_ID));

Create Table playsfor
	(
	team_ID numeric (20),
	player_ID varchar(15),
	primary key (player_ID),
	foreign key (team_ID) references team(team_ID) on delete set null,
	foreign key (player_ID) references player(player_ID));

Create Table playsat
	(stadium_ID varchar(15),
    team_ID numeric (20),
	foreign key (team_ID) references team(team_ID) on delete set null,
	foreign key (stadium_ID) references stadium(stadium_ID));

drop table Team;
drop table fixtures;
drop table Player;
drop table Stadium;
drop table Manager;
drop table manages;
drop table playsfor;
drop table playsat;
