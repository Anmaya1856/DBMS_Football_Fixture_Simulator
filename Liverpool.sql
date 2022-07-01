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

call liverpool();