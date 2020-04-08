CREATE DATABASE labb1


CREATE TABLE RobotRank(
RankId INT PRIMARY KEY,
RankName VARCHAR(20)  
)

/*1:N*/
CREATE TABLE FightingRobot(
Id INT PRIMARY KEY,
RobotName VARCHAR(20),
RobotWeight INT,
RankId INT REFERENCES RobotRank(RankId),
)
/*1:N*/
CREATE TABLE SmartRobot(
Id INT PRIMARY KEY,
RobotName VARCHAR(20),
Iq INT,
RankId INT REFERENCES RobotRank(RankId)
)

CREATE TABLE FlyingRobot(
Id INT PRIMARY KEY,
RobotName VARCHAR(20),
Speed INT
)

CREATE TABLE UnderWaterRobot(
Id INT PRIMARY KEY,
RobotName VARCHAR(20),
TimeUnderWater INT
)



CREATE TABLE MazeSolvingTournament(
TournamentId INT PRIMARY KEY,
RobotID INT,
Id INT REFERENCES SmartRobot(Id)
)	

CREATE TABLE PARTICIPATES(
RobotId INT REFERENCES FlyingRobot(Id),
TournamentId INT references MazeSolvingTournament(TournamentId)
)

CREATE TABLE SumoTournament(
TournamentId INT PRIMARY KEY,
RobotID INT,
Id INT REFERENCES FightingRobot(Id)
)

CREATE TABLE FightingTournament(
TournamentId INT PRIMARY KEY,
RobotID INT,
Id INT REFERENCES FightingRobot(Id)
)

CREATE TABLE FlyingTounament(
TournamentId INT PRIMARY KEY,
RobotID INT,
Id INT REFERENCES FlyingRobot(Id)
)

CREATE TABLE SCORE(
RobotScore INT PRIMARY KEY,
RobotId INT
)

Create table ParticipatesBigTournament(
tournamentID INT references SumoTournament(TournamentId),
IdSumo INT REFERENCES FightingRobot(Id),
IdSmart INT REFERENCES SmartRobot(Id)
)






