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

