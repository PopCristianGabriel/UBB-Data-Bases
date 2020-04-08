

--RobotRank
INSERT INTO RobotRank (RankId, RankName )
VALUES (1, 'dawd');

INSERT INTO RobotRank (RankId, RankName )
VALUES (2, 'The second best');

INSERT INTO RobotRank (RankId, RankName )
VALUES (3, 'The third best');

INSERT INTO RobotRank (RankId, RankName )
VALUES (1, 'Meh');


Update RobotRank
SET RankName ='The best'
where RankName = 2


--RobotRank


--FightingRobot
Insert Into FightingRobot(Id,RobotName,RobotWeight,RankId)
Values(1,'Macelaru',23,2);

Insert Into FightingRobot(Id,RobotName,RobotWeight,RankId)
Values(2,'Luptatoru',11,2);

Insert Into FightingRobot(Id,RobotName,RobotWeight,RankId)
Values(3,'Bunu',10,1);

Insert Into FightingRobot(Id,RobotName,RobotWeight,RankId)
Values(4,'Andre',30,5);

Update FightingRobot
Set RankId = 3
Where RobotWeight > 20
--FightingRobot


--SmartRobot
Insert into SmartRobot(Id,RobotName,Iq,RankId)
Values(1,'Creieru',300,1)

Insert into SmartRobot(Id,RobotName,Iq,RankId)
Values(2,'Smarty',250,2)

Insert into SmartRobot(Id,RobotName,Iq,RankId)
Values(3,'Mihaela',100,2)

Insert into SmartRobot(Id,RobotName,Iq,RankId)
Values(4,'Marcel',400,3)

Insert into SmartRobot(Id,RobotName,Iq,RankId)
Values(4,'Creieru',300,1)

Update SmartRobot
Set Iq = Iq - 10
where Iq > 260

Delete from SmartRobot
where Iq < 230


--SmartRobot


--FlyingRobot
Insert Into FlyingRobot(Id,RobotName,Speed)
Values(1,'Alex',20)

Insert Into FlyingRobot(Id,RobotName,Speed)
Values(2,'Mihai',20)

Insert Into FlyingRobot(Id,RobotName,Speed)
Values(3,'Darius',40)

Insert Into FlyingRobot(Id,RobotName,Speed)
Values(4,'Mihnea',35)

Insert Into FlyingRobot(Id,RobotName,Speed)
Values(1,'Alex',11)

Update FlyingRobot
Set RobotName = RobotName + 'Speedy'
where speed > 30

Delete from FlyingRobot
where speed < 10

--FlyingRobot



-- underWaterRobot
Insert Into UnderWaterRobot(Id,RobotName,TimeUnderWater)
Values(1,'Alex',20)

Insert Into UnderWaterRobot(Id,RobotName,TimeUnderWater)
Values(2,'Mihai',20)

Insert Into UnderWaterRobot(Id,RobotName,TimeUnderWater)
Values(3,'Darius',40)

Insert Into UnderWaterRobot(Id,RobotName,TimeUnderWater)
Values(4,'Mihnea',35)

Insert Into UnderWaterRobot(Id,RobotName,TimeUnderWater)
Values(1,'Alex',11)

--underWaterRobot



--MazeSolving tournament
Insert into MazeSolvingTournament(TournamentId,RobotID)
Values(1,1)
Insert into MazeSolvingTournament(TournamentId,RobotID)
Values(2,2)
Insert into MazeSolvingTournament(TournamentId,RobotID)
Values(4,4)

select * from MazeSolvingTournament

--- participates
Insert into Participates(RobotID,TournamentID)
Values(1,1)
Insert into Participates(RobotID,TournamentID)
Values(1,2)
Insert into Participates(RobotID,TournamentID)
Values(1,1)
Insert into Participates(RobotID,TournamentID)
Values(2,1)
Insert into Participates(RobotID,TournamentID)
Values(1,4)


--Sumo Tournament
Insert into SumoTournament(TournamentId,RobotId)
Values(1,1)

Insert into SumoTournament(TournamentId,RobotId)
Values(2,2)

Insert into SumoTournament(TournamentId,RobotId)
Values(3,1)




--Sumo Tournament




--- participates






--MazeSolving tournament



---BigTournament



Insert into ParticipatesBigTournament(tournamentId,IdSmart,IdSumo)
Values(1,1,1)
Insert into ParticipatesBigTournament(TournamentId,IdSmart,IdSumo)
Values(1,2,1)
Insert into ParticipatesBigTournament(TournamentId,IdSmart,IdSumo)
Values(2,2,2)
Insert into ParticipatesBigTournament(TournamentId,IdSmart,IdSumo)
Values(3,2,3)



--double primary
insert into IncredibleRobot(RobotId, TotalPoints, RobotName, Incredibility,RankId)
Values(1,1,'Dawd',25.2,1)
insert into IncredibleRobot(RobotId, TotalPoints, RobotName, Incredibility,RankId)
Values(2,2,'Dawd2',103.74,2)
insert into IncredibleRobot(RobotId, TotalPoints, RobotName, Incredibility,RankId)
Values(3,3,'Dawd3',21.3,2)
insert into IncredibleRobot(RobotId, TotalPoints, RobotName, Incredibility,RankId)
Values(4,4,'Dawd4',1.1,1)


--score
insert into SCORE(RobotScore,RobotId)
values(1,120)
insert into SCORE(RobotScore,RobotId)
values(2,230)
insert into SCORE(RobotScore,RobotId)
values(3,250)
insert into SCORE(RobotScore,RobotId)
values(4,550)
insert into SCORE(RobotScore,RobotId)
values(5,330)
insert into SCORE(RobotScore,RobotId)
values(6,50)
insert into SCORE(RobotScore,RobotId)
values(7,100)








--Big Tournament

--a

select id from FlyingRobot
union all
select id from FightingRobot


select id, speed
from FlyingRobot
where id = 1 or speed > 20


--b
select *
from FightingRobot
where RankId > 2

intersect

select *
from FightingRobot
where RobotWeight < 30


select * 
from FightingRobot
where RankId in (1,2)

--c

select *
from SmartRobot
where RankId not in(2,3)



select *
from SmartRobot
where Iq > 100

except

select*
from SmartRobot
where Iq < 200


--d
Select *
from FlyingRobot
INNER JOIN MazeSolvingTournament ON FlyingRobot.Id = MazeSolvingTournament.RobotID 
Left Join FlyingTounament on FlyingTounament.RobotId = FlyingRobot.Id

Select *
from FlyingRobot
Right JOIN MazeSolvingTournament ON FlyingRobot.Id = MazeSolvingTournament.RobotID 
Full Join FlyingTounament on FlyingTounament.RobotId = FlyingRobot.Id

Select *
from FlyingRobot
Full JOIN MazeSolvingTournament ON FlyingRobot.Id = MazeSolvingTournament.RobotID 
Left Join FlyingTounament on FlyingTounament.RobotId = FlyingRobot.Id


Select *
from FlyingRobot
full JOIN PARTICIPATES on FlyingRobot.Id = PARTICIPATES.RobotId
full join MazeSolvingTournament on MazeSolvingTournament.RobotID = FlyingRobot.Id
full join SmartRobot on SmartRobot.Id = FlyingRobot.id
full join ParticipatesBigTournament on  ParticipatesBigTournament.IdSmart = SmartRobot.Id
full join SumoTournament on SumoTournament.RobotID = SmartRobot.Id 

Select *
from FlyingRobot
INNER JOIN MazeSolvingTournament ON FlyingRobot.Id = MazeSolvingTournament.RobotID


--e

select *
from SmartRobot
where Id in(select Id
			from MazeSolvingTournament
			where TournamentId > 0)



select *
from SmartRobot
where Id in(select Id
			from MazeSolvingTournament
			where TournamentId < 2)



--f
select*
from ParticipatesBigTournament
where EXISTS 
(select * from ParticipatesBigTournament where tournamentID < 2)


select*
from MazeSolvingTournament
where EXISTS 
(select * from MazeSolvingTournament where RobotID > 1)


--g

select *
from( select Id as i , Speed as s from FlyingRobot where Id > 2) as table2
where s > 15


select *
from (select RobotName as name, TimeUnderWater as T from UnderWaterRobot where Id < 3) as table2
where T > 10

--h
select Speed
from FlyingRobot
group by Speed


select count(RobotWeight)
from FightingRobot
group by RobotWeight
having RobotWeight > 10

select Min(RobotWeight)
from FightingRobot
group by RobotWeight
having RobotWeight > (select( AVG(RobotWeight) )
							from FightingRobot)   

select (Speed)
from FlyingRobot
group by Speed
having Speed > (Select Min(Speed)
					  from FlyingRobot)


--i

select S.Id
from SmartRobot as S
where S.Id = any (select RobotID from MazeSolvingTournament as MS where MS.RobotID =(MS.RobotId))

select S.Id
from SmartRobot as S
where S.Id = all (select RobotID from MazeSolvingTournament as MS where MS.RobotID =(MS.RobotId))

select S.Id
from SmartRobot as S
where S.Id = any (Select RobotId from MazeSolvingTournament where RobotId in (0,1,2,3))

select S.Id
from SmartRobot as S
where S.Id = any (Select RobotId from MazeSolvingTournament where RobotId not in (3))












