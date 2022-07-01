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

call man_utd();