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

call bayern();