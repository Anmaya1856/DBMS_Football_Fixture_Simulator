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

call tottenham();