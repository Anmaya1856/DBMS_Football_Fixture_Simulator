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

call man_city();