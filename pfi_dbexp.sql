use WBdbexp;

/*1. Écrire la procédure stockée ajouterRelique qui permet d’ajouter une relique dans la
base de données*/
go;
create procedure ajouterRelique (@importance int, @nom varchar(60), @typeR char(1)) as 
begin
	if @importance >= 1 and @importance <= 3
		insert into reliques (importance, nom, typeR) values (@importance, @nom, @typeR);
	else
		print ('l''importance de la relique n''existe pas!');
end;

execute ajouterRelique
	@importance = 1,
	@nom = 'Saint-Jambon',
	@typeR = 's';

/*2. Écrire une procédure objetTrouve(@alias varchar(10), @idRelique int) qui permet de
trouver une relique. Cette procédure permet de faire les opérations décrites dans
l’encadré vert de la page 5. De plus cette procédure doit vérifier que l’alias existe, et que
la relique n’est pas encore trouvée. *//*
go;
create procedure objetTrouve(@alias varchar(10), @idRelique int) as 
begin
	/*select*/
end;*/

/*3. Programmer une procédure stockée classementJoueurs affiche le classement des
joueurs. On affiche l’alias, et le nombre de pièces associées à leurs trouvailles. Les
joueurs ayant le nombre total de pièces d’Or en premiers, puis, Argent, enfin Bronze*/
go;
create procedure classementJoueurs as
begin
	select alias, nbOr, nbArgent, nbBronze from joueurs inner join gainsRelique on gainsRelique.idJoueur = joueurs.idjoueur
		order by nbOr, nbArgent, nbBronze;
end;

/*4. Écrire une procédure updateRelique qui met le flag estTrouve à 0 lorsque toutes les
reliques sont trouvées.*/
go;
create procedure updateRelique (@idRelique int) as 
begin
	update reliques set EstTrouve = 1 where idRelique = @idRelique;
	if (select count(idRelique) from reliques) = (select count(idRelique) from reliques where EstTrouve = 1)
		update reliques set EstTrouve = 0;
end;

execute updateRelique
	@idrelique = 101;

/*5. L’information de la table gainsRelique est confidentielle Il est donc important qu’un
usager de la base de données du département Exp ait accès uniquement aux données
qui le concernent. Ici on suppose qu’un joueur correspond à un usager. Vous devez
mettre en place un mécanisme qui garantira:

a. Qu’un joueur puisse consulter ses gains et uniquement les siens*/
go;
create procedure RegarderGainsRelique as
begin
	declare @loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;

	select joueurs.idJoueur, nbOr, nbArgent, nbBronze from gainsRelique
		inner join joueurs on joueurs.idjoueur = gainsRelique.idJoueur
		where alias = @loginName;
end;

create role joueurs;
grant execute RegarderGainsRelique to joueurs;

/*creer le user simba*/
CREATE LOGIN Simba WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbexp, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;


create user Simba for login Simba;
alter role joueurs add member Simba;


/*creer le joueur Kiwi*/
CREATE LOGIN Kiwi WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbexp, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;

create user Kiwi for login Kiwi;
alter role joueurs add member Kiwi;


/*b. Qu’un joueur puisse mettre à jour (INSERT et UPDATE) ses gains et uniquement
les siens.*/
go;
create procedure InsertGainsRelique(@nbOr int, @nbArgent int, @nbBronze int) as 
begin
	declare @idJoueur int,
		@loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;
	select @idJoueur = idJoueur from joueurs where alias = @loginName;
	if (select count(idJoueur) from joueurs where alias = @loginName) >= 1
	begin
		select @idJoueur = idJoueur from joueurs where alias = @loginName;
		insert into gainsRelique(nbOr, nbArgent, nbBronze, idJoueur) values (@nbOr, @nbArgent, @nbBronze, @idJoueur);
	end
	else
		print('la connection du joueur n''est pas valide!');
end;

go;
create procedure UpdateGainsRelique(@nbOr int, @nbArgent int, @nbBronze int) as 
begin
	declare @idJoueur int,
		@loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;

	if (select count(idJoueur) from joueurs where alias = @loginName) >= 1
	begin
		select @idJoueur = idJoueur from joueurs where alias = @loginName;
		update gainsRelique set nbOr = @nbOr where idJoueur = @idJoueur;
		update gainsRelique set nbArgent = @nbArgent where idJoueur = @idJoueur;
		update gainsRelique set nbBronze = @nbBronze where idJoueur = @idJoueur;
	end
	else 
		print('la connection du joueur n''est pas valide!');
end;

execute InsertGainsRelique
	@nbOr = 1,
	@nbArgent = 2,
	@nbBronze = 3;

execute UpdateGainsRelique
	@nbOr = 1,
	@nbArgent = 2,
	@nbBronze = 3;

/*1. Programmez la procédure AjouterJoueur qui ajoute un joueur à la table joueurs avec
toutes ses informations, incluant son mot de passe*/
alter table joueurs add MDP varbinary(256);
alter table joueurs add credit varbinary(256);
go;
create procedure AjouterJoueur(@alias varchar(10), @nom varchar(30), @prenom varchar(30), @MDP varchar(30)) as 
begin
	if (select count(alias) from joueurs where alias = @alias) < 1
	begin
		insert into joueurs(nom, prenom, alias, MDP) values (@nom, @prenom, @alias, HASHBYTES('SHA2_512', @MDP));
	end
	else
		print('Cet alias eset déjà pris!');
end;

execute AjouterJoueur
	@alias = 'bob',
	@nom = 'boby',
	@prenom = 'bobo',
	@MDP = '1234';

/*2. Programmez la procédure ModifierMotPasse qui permet à un joueur de modifier son
mot de passe. L’ancien mot de passe doit être fourni pour valider son identité.*/
go;
create procedure ModifierMotPasse(@ancientMDP varchar(30), @nouveauMDP varchar(30)) as 
begin
	declare @loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;
	if ((select count(idJoueur) from joueurs where alias = @loginName) >= 1)
	begin
		if (select MDP from joueurs where alias = @loginName) = HASHBYTES('SHA2_512', @ancientMDP)
			update joueurs set MDP = HASHBYTES('SHA2_512', @nouveauMDP);
		else 
			print ('votre ancient mot de passe n''est pas valide');
	end
	else
		print('la connection du joueur n''est pas valide!');
end;

execute ModifierMotPasse
	@ancientMDP = '1234',
	@nouveauMDP = '12345';

/*3. Programmez la fonction scalaire ValiderIdentité pour valider l’identité d’un
joueur basé sur son mot de passe. La fonction retourne 0 (succès) ou 1 (échec).*/
go;
create function ValiderIdentité(@mdp varchar(30)) returns int as 
begin
	declare @loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;
	if ((select count(idJoueur) from joueurs where alias = @loginName) >= 1)
	begin
		if (select mdp from joueurs where alias = @loginName) = HASHBYTES('SHA2_512', @mdp)
			return 0;
		else
			return 1;
	end
	return 1;
end;

select dbo.ValiderIdentité('1234');

/*4. Programmez la procédure AjouterInfoCrédit qui permet d’ajouter un numéro de carte
de crédit à un joueur donné. Le mot de passe du joueur doit être fourni.*/
go;
create procedure AjouterInfoCrédit(@credit varchar(16), @codeCredit varchar(30)) as
begin
	declare @loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;
	if ((select count(idJoueur) from joueurs where alias = @loginName) >= 1)
	begin
		update joueurs set credit = ENCRYPTBYPASSPHRASE(@codeCredit, @credit);
	end
	else
		print('la connection du joueur n''est pas valide!');
end;

execute AjouterInfoCrédit
	@credit = '329183747836972',
	@codeCredit = '12345';

/*5. Programmez la fonction table ObtenirInfoCrédit qui retourne toute l’information d’un
joueur, incluant son numéro de carte de crédit, mais pas son mot de passe.*/
go;
create function ObtenirInfoCrédit(@codeCredit varchar(30)) returns varchar(16) as
begin
	declare @loginName nchar(10);
	/*code pris sur: https://stackoverflow.com/questions/1248423/how-do-i-see-active-sql-server-connections*/
	select @loginName = loginame FROM sys.sysprocesses
		WHERE dbid > 0
		GROUP BY dbid, loginame;
	if ((select count(idJoueur) from joueurs where alias = @loginName) >= 1)
	begin
		return (select convert(varchar, DECRYPTBYPASSPHRASE(@codeCredit,credit,0)) as credit from joueurs where alias = @loginName);
	end
	return '';
end;

select dbo.ObtenirInfoCrédit('12345');




select * from gainsRelique;
select * from reliques;
select * from joueurs;