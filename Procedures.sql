#procedure to create fixture list
DELIMITER $$
CREATE PROCEDURE InsertFixtures()
    BEGIN
        DECLARE i INT;
        Declare j int; 
        Declare x int; 
        Declare y int; 
        Declare temp int; 
        declare no_of_teams int;
        declare match_no int;
        set match_no = 1;
        SET i = 1;
        set no_of_teams = (select count(team_ID) from team);
        START TRANSACTION;
        
        WHILE i <= no_of_teams DO
			
			set j = 1;
            while j <= no_of_teams DO
				if(i != j) then
                begin		
                    INSERT INTO fixtures(Match_No,HomeID,AgainstID) VALUES (match_no,i, j);
                    set match_no = match_no + 1;
				end;
                end if;
                set j = j +1;
			end while;
			set i = i +1;
        end while;
        COMMIT;
    END$$
DELIMITER ;


#procedure to insert random scores of fixtures
DELIMITER $$
CREATE PROCEDURE InsertRand()
    BEGIN
        DECLARE i INT;
        Declare t1c int;
        Declare t1w int;
        Declare t1s int;
        Declare t1diff int;
		Declare t1l int; 
		Declare t1d int; 
        Declare t1p int; 
        Declare j int; 
        Declare MinVal int; 
        Declare MaxVal int; 
        Declare NumRows int; 
        SET i = 1;
        SET MinVal = -1;
        SET MaxVal = 5;
        START TRANSACTION;
        set NumRows = (select max(Match_No) from fixtures);
        WHILE i <= NumRows DO
			
            #Query to set random scores of each match
            Update fixtures set HT_Goals = MinVal + CEIL(RAND() * (MaxVal - MinVal)) , AT_Goals = MinVal + CEIL(RAND() * (MaxVal - MinVal)) where HT_Goals is null;
            
            #loop to assign and calcuate all the different values in a points table
            set j = 1;
            WHILE j <= NumRows DO
				
				#--------------------------------------------------------------------------------------------------
				#Queries to calculate and assign goals conceded of each team
				set t1c = (select sum(AT_Goals) from fixtures where HomeID=j group by HomeID) ; #goals conceded by t1 when its playing at home
				set t1c = t1c + (select sum(HT_Goals) from fixtures where AgainstID=j group by AgainstID); #goals conceded by t1 when its playing at away
				Update team set goals_conceded = t1c where temp_ID = j;
				
				#--------------------------------------------------------------------------------------------------
				#Queries to calculate and assign goals scored of each team
				set t1s = (select sum(HT_Goals) from fixtures where HomeID=j group by HomeID) ; #goals scored by t1 when its playing at home
				set t1s = t1s + (select sum(AT_Goals) from fixtures where AgainstID=j group by AgainstID); #goals scored by t1 when its playing at away
				Update team set goals_scored = t1s where temp_ID = j;
				
				#--------------------------------------------------------------------------------------------------
				#Queries to calculate goal difference of each team
				set t1diff = t1s - t1c;
				Update team set goals_difference = t1diff where temp_ID = j;
				
				#--------------------------------------------------------------------------------------------------
				#Queries to calculate and assign wins of each team
				set t1w = (select count(case when HT_Goals>AT_Goals then 1 else null end)from fixtures where HomeID=j group by HomeID) ; #team wins by t1 when its playing at home
				set t1w = t1w + (select count(case when AT_Goals>HT_Goals then 1 else null end)from fixtures where AgainstID=j group by AgainstID) ; #team wins by t1 when its playing at away
				Update team set wins = t1w where temp_ID = j;
				
				#--------------------------------------------------------------------------------------------------
				#Queries to calculate and assign losses of each team
				set t1l = (select count(case when HT_Goals<AT_Goals then 1 else null end) from fixtures where HomeID=j group by HomeID); #team losses by t1 when its playing at home
				set t1l = t1l + (select count(case when AT_Goals<HT_Goals then 1 else null end) from fixtures where AgainstID=j group by AgainstID); #team losses by t1 when its playing at away
				Update team set losses = t1l where temp_ID = j;
				
				#--------------------------------------------------------------------------------------------------
				#Queries to calculate and assign draws of each team
				set t1d = (select count(case when HT_Goals=AT_Goals then 1 else null end)  from fixtures where HomeID=j group by HomeID); #team draws by t1 when its playing at home
				set t1d = t1d + (select count(case when AT_Goals=HT_Goals then 1 else null end)  from fixtures where AgainstID=j group by AgainstID); #team draws by t1 when its playing at away
				Update team set draws = t1d where temp_ID = j;
				
				#--------------------------------------------------------------------------------------------------
				#Queries to points of each team
				set t1p = (3 * t1w) + (1 * t1d);
				Update team set points = t1p where temp_ID = j;
				
				set j = j + 1;
                
            END WHILE;
            
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE drop_all_tables()
    BEGIN
		START TRANSACTION;
		drop table playsat;
        drop table manages;
        drop table Manager;
        drop table Stadium;
        drop table Player;
        drop table fixtures;
        drop table Team;
        COMMIT;
    END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE create_all_tables()
    BEGIN
		START TRANSACTION;
		Create Table Team 
			(team_ID numeric(20) primary key,
			name varchar(30) not null,
			goals_conceded numeric(20) DEFAULT 0,
			goals_scored numeric(20) DEFAULT 0,
			goals_difference numeric(20) DEFAULT 0,
			wins numeric(20) DEFAULT 0,
			losses numeric(20) DEFAULT 0,
			draws numeric(20) DEFAULT 0,
			points numeric(20) DEFAULT 0,
            temp_ID int not null auto_increment,
            Unique key (temp_ID)
			);


		CREATE TABLE fixtures (
			Match_No numeric(10) primary key,
			HomeID INT,
			AgainstID INT,
			HT_Goals numeric(20),
			AT_Goals numeric(20),
			foreign key(HomeID) references Team(temp_ID),
			 foreign key(AgainstID) references Team(temp_ID)
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


		Create Table playsat
			(stadium_ID varchar(15),
			team_ID numeric (20),
			foreign key (team_ID) references team(team_ID) on delete set null,
			foreign key (stadium_ID) references stadium(stadium_ID));


        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE chelsea()
    BEGIN
		START TRANSACTION;
		insert into team(team_ID,name, temp_ID) values ('3', 'Chelsea F.C.', '3');

		#players
		insert into player values ('P301', 'Edouard', 'Mendy', '29', 'GK', '3', '200000' )

		,('P302', 'Kurt', 'Zouma', '26', 'DF', '3', '80000' )
		,('P303', 'Thiago', 'Silva', '36', 'DF', '3', '1050000' )
		,('P304', 'Reece', 'James', '21', 'DF', '3', '110000' )
		,('P305', 'Ben', 'Chilwell', '24', 'DF', '3', '150000' )

		,('P306', 'Kai', 'Havertz', '21', 'MF', '3', '200000' )
		,('P307', 'N Golo', 'Kanté', '30', 'MF',  '3', '300000' )
		,('P308', 'Mateo', 'Kovacic', '26', 'MF',  '3', '1800000' )

		,('P309', 'Olivie', 'Giroud', '34', 'ST',  '3', '160000' )
		,('P310', 'Timo', 'Werner', '25', 'ST',  '3', '2200000' )
		,('P311', 'Tammy', 'Abraham', '23', 'ST',  '3', '250000' );

		#stadium
		insert into stadium values( 'S3', 'Stamford Bridge', 'London', '41837','3');

		#manager
		insert into manager values('M3', 'Thomas', 'Tuchel', '47', '400000',  '3');


		insert into manages values('M3', '3');



		insert into playsat values('S3', '3');
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE liverpool()
    BEGIN
		START TRANSACTION;
		insert into team(team_ID,name) values ('4', 'Liverpool FC');

		#players
		insert into player values ('P401', 'Allison', 'Becker', '28', 'GK',  '4', '225000' )

		,('P402', 'Virjil','Van Djik', '29', 'DF',  '4', '334000' )
		,('P403', 'Trent', 'Alexander Arnold', '22', 'DF',  '4', '210000' )
		,('P404', 'Andrew', 'Robertson', '27', 'DF',  '4', '124000' )
		,('P405', 'Joe', 'Gomez', '23', 'DF',  '4', '90000' )

		,('P406', 'Thiago', 'Alacantra', '29', 'MF',  '4', '420000' )
		,('P407', 'Jordan', 'Henderson', '30', 'MF',  '4', '256000' )

		,('P408', 'Diego','Jota', '24', 'ST',  '4', '160000' )
		,('P409', 'Mohamed', 'Salah', '28', 'ST',  '4', '450000' )
		,('P410', 'Sadio', 'Mane', '28', 'ST',  '4', '324000' )
		,('P411', 'Roberto', 'Firmino', '29', 'ST',  '4', '290000' );

		#team
		insert into stadium values( 'S4', 'Anfield Stadium', 'Liverpool', '53394','4');

		#manager
		insert into manager values('M4', 'Jurgen','Klopp', '41', '472000',  '4');

		insert into manages values('M4', '4');

		

		insert into playsat values('S4', '4');
		COMMIT;
    END$$
DELIMITER ;

#Man City
DELIMITER $$
CREATE PROCEDURE man_city()
    BEGIN
		START TRANSACTION;
		insert into team(team_ID,name) values ('2', 'Manchester City FC')  ;

		#players
		insert into player values ('P201', 'Ederson', 'Moraes', '27', 'GK', '2', '390000' )
		,('P202', 'Ruben', 'Dias', '23', 'DF', '2', '380000' )
		,('P203', 'John', 'Stones', '26', 'DF', '2', '320000' )
		,('P204', 'Kyle', 'Walker', '30', 'DF', '2', '350000')
		,('P205', 'Joan', 'Cancelo', '26', 'DF', '2', '330000')
		,('P206', 'Rodrigo', 'Hernandez', '24', 'MF', '2', '400000')
		,('P207', 'Kevin', 'De Bruyne', '29', 'MF', '2', '480000')
		,('P208', 'Phil', 'Foden', '20', 'MF', '2', '500000')
		,('P209', 'Riyad', 'Mahrez', '30', 'MF', '2', '450000')
		,('P210', 'Ilkay', 'Gundogan', '30', 'MF', '2', '420000')
		,('P211', 'Gabriel', 'Jesus', '23', 'ST', '2', '460000')  ;

		#team
		insert into stadium values('S2', 'Etihad Stadium', 'Manchester', '55097','2')  ;

		#manager
		insert into manager values('M2', 'Alex', 'Hunter', '16', '500000', ' 2') ;

		insert into manages values('M2', '2');

		 
		  
		  insert into playsat values('S2', '2');
          COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE man_utd()
    BEGIN
		START TRANSACTION;
		insert into team(team_ID,name) values ('1', 'Manchester United FC');

		#players
		insert into player values ('P101', 'David ', 'de Gea', '30', 'GK', '1', '350000' )

		,('P102', 'Phil', 'Jones', '29', 'DF', '1', '90000' )
		,('P103', 'Aaron', 'Wan-Bissaka', '23', 'DF', '1', '160000' )
		,('P104', 'Harry', 'Maguire', '28', 'DF', '1', '250000' )
		,('P105', 'Alex', 'Telles', '28', 'DF', '1', '150000' )

		,('P106', 'Paul', 'Pogba', '28', 'MF', '1', '300000' )
		,('P107', 'Bruno', 'Fernandes', '26', 'MF', '1', '400000' )
		,('P108', 'Donny', 'van de Beek', '23', 'MF', '1', '120000' )

		,('P109', 'Anthony', 'Martial', '25', 'ST', '1', '200000' )
		,('P110', 'Mason', 'Greenwood', '19', 'ST', '1', '180000' )
		,('P111', 'Marcus', 'Rashford', '23', 'ST', '1', '290000' );

		#stadium
		insert into stadium values('S1', 'Old Trafford', 'Manchester', '76000', '1');

		#manager
		insert into manager values('M1', 'Ole', 'Gunnar Solskjær', '48', '400000', '1');


		insert into manages values('M1', '1');



		insert into playsat values('S1', '1');

		
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE tottenham()
    BEGIN
		START TRANSACTION;
		insert into team(team_ID,name) values ('5', 'Tottenham Hotspur FC');

		#players
		insert into player values ('P501', 'Hugo', 'Lloris', '34', 'GK', '5', '216000' )

		, ('P502', 'Toby', 'Alderweireld', '32', 'DF', '5', '234000' )
		, ('P503', 'Matt', 'Doherty', '29', 'DF', '5', '110000' )
		, ('P504', 'Ben', 'Davies', '27', 'DF', '5', '124000' )
		, ('P505', 'Sergio', 'Reguilon', '24', 'DF', '5', '150000' )

		, ('P506', 'Dele', 'Alli', '24', 'MF', '5', '220000' )
		, ('P507', 'Giovani', 'Lo Celso', '24', 'MF', '5', '116000' )

		, ('P508', 'Son', 'Heung-Min', '28', 'ST', '5', '310000' )
		, ('P509', 'Harry', 'Kane', '27', 'ST', '5', '350000' )
		, ('P510', 'Steven', 'Bergwijn', '23', 'ST', '5', '100000' )
		, ('P511', 'Gareth', 'Bale', '31', 'ST', '5', '250000' );

		#team
		insert into stadium values('S5', 'White hart Lane', 'London', '62303', '5');

		#manager
		insert into manager values('M5', 'Anmaya', 'Agarwal', '21', '312000', '5');

		insert into manages values('M5', '5');


		insert into playsat values('S5', '5');
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE psg()
    BEGIN
		START TRANSACTION;
		insert into team(team_ID,name) values ('6', 'PSG F.C.');
		#players
		insert into player values ('P601', 'Keylor', 'Navas', '29', 'GK', '6', '200000' )

		,('P602', 'Alessandro', 'Florenzi', '26', 'DF', '6', '80000' )
		,('P603', 'Marquinios', 'Correa', '26', 'DF', '6', '1050000' )
		,('P604', 'Laywin', 'Kurzawa', '21', 'DF', '6', '110000' )
		,('P605', 'Presnel', 'Kimpembe', '24', 'DF', '6', '120000' )

		,('P606', 'Julian', 'Draxler', '21', 'MF', '6', '200000' )
		,('P607', 'Marco', 'Verrati', '30', 'MF', '6', '300000' )
		,('P608', 'Angel', 'De Maria', '26', 'MF', '6', '1800000' )

		,('P609', 'Kylian', 'Mbappe', '21', 'ST', '6', '160000' )
		,('P610', 'Neymar', 'Jr.', '25', 'ST', '6', '520000' )
		,('P611', 'Mauro', 'Icardi', '23', 'ST', '6', '350000' );

		#stadium
		insert into stadium values( 'S6', 'Le Parc des Princes', 'Paris', '41837','6');

		#manager
		insert into manager values('M6', 'Mauricio', 'Pochettino', '49', '400000', '6');


		insert into manages values('M6', '6');

		

		insert into playsat values('S6', '6');
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE real_madrid()
    BEGIN
		START TRANSACTION;
		#Real Madrid
		insert into team(team_ID,name) values ('7', 'Real Madrid');

		#players
		insert into player values ('P701', 'Thibaut', 'Courtouis', '28', 'GK', '7', '225000' )

		,('P702', 'Dani', 'Carvajal', '29', 'DF', '7', '334000' )
		,('P703', 'Raphael', 'Varane', '27', 'DF', '7', '210000' )
		,('P704', 'Sergio', 'Ramos', '35', 'DF', '7', '124000' )
		,('P705',  'Marcelo', 'Vieira','32', 'DF', '7', '90000' )

		,('P706', 'Carlos ' ,'Casemiro', '29', 'MF', '7', '420000' )
		,('P707', 'Luka', 'Modric', '35', 'MF',  '7', '256000' )
		,('P708', 'Toni', 'Kroos', '31', 'MF',  '7', '160000' )

		,('P709', 'Eden','Hazard', '30', 'ST',  '7', '450000' )
		,('P710', 'Vinicious', 'Jr', '20', 'ST',  '7', '100000' )
		,('P711', 'Karim', 'Benzema', '33', 'ST',  '7', '290000' );

		#stadium
		insert into stadium values( 'S7', 'Santiago Bernabeu', 'Madrid', '81044','7');

		#manager
		insert into manager values('M7', 'Zinedine', 'Zidane', '48', '472000',  '7');


		insert into manages values('M7', '7');

		

		insert into playsat values('S7', '7');
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE barcelona()
    BEGIN
		START TRANSACTION;
		#Barcelona

		insert into team(team_ID,name) values ('8', 'FC Barcelona');

		#players
		insert into player values ('P801', 'Marc Andre', 'Ter stegen', '28', 'GK', '8', '275000' )

		,('P802', 'Clement', 'Lenglet', '25', 'DF', '8', '374000' )
		,('P803', 'Jordi', 'Alba', '32', 'DF', '8', '310000' )
		,('P804', 'Sergino', 'Dest', '20', 'DF', '8', '84000' )
		,('P805',  'Gerard', 'Pique','34', 'DF', '8', '210000' )

		,('P806', 'Sergio', 'Busquets', '29', 'MF', '8', '420000' )
		,('P807', 'Frankie', 'De jong', '23', 'MF',  '8', '256000' )
		,('P808', 'Phillipe', 'Coutinho', '28', 'MF',  '8', '160000' )

		,('P809', 'Lionel','Messi', '33', 'ST',  '8', '450000' )
		,('P810', 'Ansu', 'Fati', '18', 'ST',  '8', '100000' )
		,('P811', 'Antoine', 'Griezmann', '30', 'ST',  '8', '290000' );

		#stadium
		insert into stadium values( 'S8', 'Nou Camp', 'Barcelona', '99354','8');

		#manager
		insert into manager values('M8', 'Ronald', 'Koeman', '58', '472000',  '8');


		insert into manages values('M8', '8');

		

		insert into playsat values('S8', '8');
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE juventus()
    BEGIN
		START TRANSACTION;
		#Juventus

		insert into team(team_ID,name) values ('9', 'Juventus FC');

		#players
		insert into player values ('P901', 'Gianluigi', 'Buffon', '43', 'GK', '9', '275000' )

		,('P902', 'Gianlucca', 'Frabotta', '21', 'DF', '9', '374000' )
		,('P903', 'Giorgio', 'Cheillini', '36', 'DF', '9', '310000' )
		,('P904', 'Merih', 'Demiral', '23', 'DF', '9', '84000' )
		,('P905',  'Matthjis', 'De Ligt', '21', 'DF', '9', '210000' )

		,('P906', 'Juan', 'Cuadrado', '32', 'MF', '9', '120000' )
		,('P907', 'Arthur', 'Melo', '24', 'MF',  '9', '96000' )
		,('P908', 'Weston', 'Mckinnie', '22', 'MF',  '9', '160000' )

		,('P909', 'Cristiano','Ronaldo', '36', 'ST',  '9', '4050000' )
		,('P910', 'Alvaro', 'Morata', '28', 'ST',  '9', '15000' )
		,('P911', 'Paulo', 'Dybala', '27', 'ST',  '9', '390000' );

		#stadium
		insert into stadium values( 'S9', 'Allianz Stadium', 'Turin', '41507','9');

		#manager
		insert into manager values('M9', 'Andrea', 'Pirlo', '41', '282000',  '9');


		insert into manages values('M9', '9');

	
		insert into playsat values('S9', '9');
        COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE bayern()
    BEGIN
		START TRANSACTION;
		#Bayern

		insert into team(team_ID,name) values ('10', 'FC Bayern Munich');

		#players
		insert into player values ('P1001', 'Manuel', 'Neuer', '35', 'GK', '10', '275000' )

		,('P1002', 'Benjamin', 'Pavard', '25', 'DF', '10', '74000' )
		,('P1003', 'Jerome', 'Boateng', '32', 'DF', '10', '210000' )
		,('P1004', 'Alphonso', 'Davies', '20', 'DF', '10', '84000' )
		,('P1005',  'David', 'Alaba', '28', 'DF', '10', '210000' )

		,('P1006', 'Leroy', 'Sane', '25', 'MF', '10', '320000' )
		,('P1007', 'Joshua', 'Kimmich', '26', 'MF',  '10', '99000' )
		,('P1008', 'Kingsley', 'coman', '24', 'MF',  '10', '10000' )

		,('P1009', 'Robert','Lewandowski', '32', 'ST',  '10', '4050000' )
		,('P1010', 'Thomas', 'Muller', '31', 'ST',  '10', '25000' )
		,('P1011', 'Serge', 'Gnabry', '25', 'ST',  '10', '390000' );

		#stadium
		insert into stadium values( 'S10', 'Allianz Stadium', 'Munich', '75024','10');

		#manager
		insert into manager values('M10', 'Hans', 'Dieter-Flick', '56', '382000',  '10');


		insert into manages values('M10', '10');


		insert into playsat values('S10', '10');
        COMMIT;
    END$$
DELIMITER ;

call create_all_tables();