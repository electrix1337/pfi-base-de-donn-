/*1. Cr�er les bases de donn�es des deux d�partements, Qgs et Exp*/
create database WBdbges;
create database WBdbexp;

/*use*/
use WBdbges;
use WBdbexp;

drop table Explorations;
drop table �quipages;
drop table Classes;
drop table Missions;

/*2. Cr�er les tables pour le d�partement QGS, puis ins�rer les donn�es.*/
create table Classes (
classeno int,
nomClasse varchar(30),
constraint PK_classeno primary key(classeno),
);

create table �quipages(
equipano int identity(1, 1),
nom varchar(30),
prenom varchar(30),
race varchar(30),
classeno int,
constraint FK_classeno foreign key(classeno) references Classes(classeno),
constraint PK_equipano primary key(equipano),
constraint CK_race check(race='humain' or race='vulcain' or race='borg' or race='elf' or race='dragonborn' or race='genasis' or race='demon' or race='dwarf' or
	race='tiefling' or race='fairy' or race='goblin')
);

create table Missions(
idMission int identity(1, 1),
nomMission varchar(30),
niveauRisque varchar(30),
constraint PK_idMission primary key(idMission),
constraint CK_niveauRisque check(niveauRisque='�lev�' or niveauRisque='moyen' or niveauRisque='faible')
);

create table Explorations(
equipano int,
idMission int,
nbPoints int,
dateExploration date,
constraint FK_equipano foreign key(equipano) references �quipages(equipano),
constraint FK_idMission foreign key(idMission) references Missions(idMission),
);

insert Classes(nomClasse) values ('Commandant'),('Ing�nieurs'),('Officiers tactiques'),('Enseigne'),('M�decin'),('Cuisinier');

/*3. �crire la proc�dure stock�e : insererExploration qui permet de faire une insertion dans la
table Explorations;*/
go;
create procedure insererExploration (@equipano int, @idMission int, @dateExploration date) as 
begin
	declare @nbPoints int;
	select @nbPoints = case niveauRisque
			when 'faible' then 1000
			when 'moyen' then 1500
			when '�lev�' then 5000
		end from Missions where idMission = @idMission;
	if (select Count(equipano) from �quipages where equipano = @equipano) > 0 and 
		(select Count(idMission) from Missions where idMission = @idMission) > 0
	begin
		if (select Count(idMission) from Missions where idMission = @idMission) > 0 
			insert Explorations(equipano, idMission, nbPoints, dateExploration) values (@equipano, @idMission, @nbPoints, @dateExploration);
		else
			print('La mission n''existe pas!');
	end;
	else
		print('Le membre de l''�quipage n''existe pas!');
end;

execute insererExploration
	@equipano = 0,
	@idMission = 0,
	@dateExploration = '3000-01-01';

/*4. �crire le trigger qui garantit : lors des insertions dans la table Explorations si le nombre de
points ne correspond pas � la difficult� de la mission alors l�op�ration est annul�e.*/
go;
create trigger CheckPointsInsert on Explorations after insert as 
begin
	declare @nbPoints int,
		@niveauRisque varchar(30);
	select @nbPoints = nbpoints from inserted;
	select @niveauRisque = niveauRisque from inserted 
		inner join missions on missions.idmission = inserted.idmission;

	/*anulle si dif�rent*/
	if (@niveauRisque = 'faible') 
		if (@nbpoints not 1000)
			rollback;
	if (@niveauRisque = 'moyen') 
		if (@nbpoints not 1500)
			rollback;
	if (@niveauRisque = '�lev�') 
		if (@nbpoints not 5000)
			rollback;
end;


/*5. �crire le trigger qui garantit les points 6 et 7 du carr� vert plus haut. (classe VS la mission)*/
create trigger MissionRefuser on explorations after insert, update
begin
	declare @classe varchar(30);
	select @classe = nomClasse from inserted
		inner join �quipages on �quipages.equipano = inserted.equipano
		inner join classes on classes.classeno = �quipages.classeno;
	if @classe = 'Cuisinier'
		rollback;
	else if @classe = 'M�decin'
		if (select niveauRisque from explorations) = '�lev�'
			rollback;
end;


/*6. �crire la fonction table totalPoints qui retourne pour chaque membre de l��quipage la
somme des points acquis pour les explorations.*/
go;
create function totalPoints() returns table as
	return (select �quipages.nom, count(explorations.nbPoints) as points from explorations
		inner join �quipages on �quipages.equipano = explorations.equipano
		group by nom);
select * from dbo.totalPoints();

/*7. Ex�cuter le script TrouverRelique.sql pour cr�er les tables du d�partement Exp (dbExp) et y
ins�rer les donn�es*/

/*fait*/

/*8. Cr�er les logins avec les utilisateurs mapp�s sur les logins dans la base de donn�es
correspondante. Les logins et les user seront sous ce format : Premi�re lettre du pr�nom
suivit du nom (sans espaces, sans accent. Exemple : syacoub). Vous devez respecter la
strat�gie des mots de passe.*/

/*commandants*/
CREATE LOGIN KJaneway WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user KJaneway for login KJaneway;

CREATE LOGIN CPierre WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user CPierre for login CPierre;

/*ing�nieurs*/
CREATE LOGIN TParis WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user TParis for login TParis;

CREATE LOGIN TTrip WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user TTrip for login TTrip;

CREATE LOGIN MTores WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user MTores for login MTores;

/*officiers tactiques*/
CREATE LOGIN TTuvok WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user TTuvok for login TTuvok;

CREATE LOGIN SofNine WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user SofNine for login SofNine;

/*enseignes*/
CREATE LOGIN RTilly WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user RTilly for login RTilly;

CREATE LOGIN SWiky WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user SWiky for login SWiky;

CREATE LOGIN LSarru WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user LSarru for login LSarru;

/*m�decins*/
CREATE LOGIN LHugh WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user LHugh for login LHugh;

/*cuisiniers*/
CREATE LOGIN LNellis WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbges, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user LNellis for login LNellis;

/*Relic*/
CREATE LOGIN relic WITH PASSWORD=N'1234',
DEFAULT_DATABASE=WBdbexp, CHECK_EXPIRATION=OFF,
CHECK_POLICY=on;
create user relic for login relic;


/*9. Attribuer les r�les serveur et bases de donn�es s�il y a lieu*/

/*RespQgs*/
create role RespQgs;
grant insert, update, select on WBdbges to RespQgs;
grant execute to RespQgs;

/*RoleEnseigne*/
create role RoleEnseigne;
grant select on WBdbges to RoleEnseigne;
grant update on WBdbges.�quipages to RoleEnseigne;
grant update on WBdbges.missions(niveauRisque) to RoleEnseigne;
grant insert, update on WBdbges.explorations to RoleEnseigne;

/*RoleCuisinier*/
create role RoleCuisinier;
grant select on WBdbges to RoleCuisinier


/*RoleRelic*/
create role RoleRelic;
grant select, update, insert on WBdbExp to RoleRelic

/*10. Cr�er les R�LES non pr�d�finis du tableau 1*/
create role RoleExecutionTechnique;
grant execute on WBdbExp to RoleExecutionTechnique;

/*11. Ajouter les membres aux r�les en tenant compte des autorisations.*/

/*cuisinier*/
alter role RoleCuisinier add member LNellis;

/*relic*/
alter role RoleRelic add member relic;

/*role enseignes*/
alter role RoleEnseigne add member RTilly;
alter role RoleEnseigne add member SWiky;
alter role RoleEnseigne add member LSarru;
alter role RoleEnseigne add member LHugh;/*m�decin*/

/*responsable du Exp*/
alter role RespQgs add member CPierre;

/*responsable du Qgs*/
use WBdbges;
alter role db_owner add member KJaneway;

/*db_datawriter*/
use WBdbexp;
alter role db_datawriter add member TParis;
alter role db_datawriter add member TTrip;
alter role db_datawriter add member MTores;
alter role db_datawriter add member TTuvok;
alter role db_datawriter add member SofNine;

/*db_datareader*/
use WBdbexp;
alter role db_datareader add member TParis;
alter role db_datareader add member TTrip;
alter role db_datareader add member MTores;
alter role db_datareader add member TTuvok;
alter role db_datareader add member SofNine;

/*db_ddladmin*/
use WBdbexp;
alter role db_ddladmin add member TParis;
alter role db_ddladmin add member TTrip;
alter role db_ddladmin add member MTores;
alter role db_ddladmin add member TTuvok;
alter role db_ddladmin add member SofNine;

/*12. Faire en sorte que les ing�nieurs et les officiers tactiques puissent ex�cuter les proc�dures
stock�es*/

alter role RoleExecutionTechnique add member TParis;
alter role RoleExecutionTechnique add member TTrip;
alter role RoleExecutionTechnique add member MTores;
alter role RoleExecutionTechnique add member TTuvok;
alter role RoleExecutionTechnique add member SofNine;