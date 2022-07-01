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

call psg();