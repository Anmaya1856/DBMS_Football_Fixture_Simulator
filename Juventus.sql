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

call juventus();