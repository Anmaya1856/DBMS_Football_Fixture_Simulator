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

call real_madrid();