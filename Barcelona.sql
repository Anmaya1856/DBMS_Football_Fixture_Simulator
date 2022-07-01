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

call barcelona();