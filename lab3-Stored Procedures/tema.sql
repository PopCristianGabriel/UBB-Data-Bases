-- a. modify the type of a column;

-- Version no. 1.

GO
CREATE OR ALTER PROCEDURE PROC1 AS
BEGIN 
	Alter Table FlyingRobot
	Alter Column RobotName varchar(200);
END;

go
--EXEC PROC1;

GO
CREATE OR ALTER PROCEDURE REVERT_PROC1 AS
BEGIN
	Alter Table FlyingRobot
	Alter Column RobotName varchar(20);
END;
go
EXEC REVERT_PROC1;

-- b. add / remove a column;

-- Version no. 2.

GO
CREATE OR ALTER PROCEDURE PROC2 AS
BEGIN 
	ALTER TABLE FlyingRobot
	ADD RobotVersion Int;
END;
go
--EXEC PROC2;

GO
CREATE OR ALTER PROCEDURE REVERT_PROC2 AS
BEGIN
	ALTER TABLE FlyingRobot
	DROP COLUMN RobotVersion;
END;
go
EXEC REVERT_PROC2;

-- c. add / remove a DEFAULT constraint;

-- Version no. 3.

GO
CREATE OR ALTER PROCEDURE PROC3 AS
BEGIN
	ALTER TABLE FlyingRobot
	ADD CONSTRAINT Speed
	DEFAULT 10 FOR Speed;
END;
go
----EXEC PROC3;

GO
CREATE OR ALTER PROCEDURE REVERT_PROC3 AS
BEGIN 
	ALTER TABLE FlyingRobot
	DROP CONSTRAINT Speed;
END;
go
EXEC REVERT_PROC3;

-- d. add / remove a primary key;

-- Version no. 4.

GO 
CREATE OR ALTER PROCEDURE REVERT_PROC4 AS
BEGIN 
	ALTER TABLE goodRobot
	DROP CONSTRAINT PK_Robot;
END;
go
EXEC REVERT_PROC4;

GO
CREATE OR ALTER PROCEDURE PROC4 AS
BEGIN 
	ALTER TABLE goodRobot
	ADD CONSTRAINT PK_Robot PRIMARY KEY (Id);
END;
go
EXEC PROC4;

-- e. add / remove a candidate key;

-- Version no. 5.

GO
CREATE OR ALTER PROCEDURE PROC5 AS 
BEGIN 
	Alter Table FightingRobot
	ADD CONSTRAINT UQ_RobotName UNIQUE (RobotName);
END;
go
EXEC PROC5;

GO
CREATE OR ALTER PROCEDURE REVERT_PROC5 AS
BEGIN 
	Alter Table FightingRobot
	DROP CONSTRAINT UQ_RobotName;
END;
go
EXEC REVERT_PROC5;

-- f. add / remove a foreign key;

-- Version no. 6.

GO
CREATE OR ALTER PROCEDURE PROC6 AS
BEGIN
	ALTER TABLE dbo.FightingTournament
	ADD CONSTRAINT FK_Id2
	FOREIGN KEY (RobotId) REFERENCES FightingRobot(Id)
END;
go
EXEC PROC6;

GO
CREATE OR ALTER PROCEDURE REVERT_PROC6 AS
BEGIN 
	ALTER TABLE dbo.FightingTournament
	DROP CONSTRAINT FK_Id2;
END;
go
EXEC REVERT_PROC6;

-- g. create / remove a table.

-- Version no. 7.

GO
CREATE OR ALTER PROCEDURE PROC7 AS
BEGIN
	PRINT 'im here'
	CREATE TABLE IncredibleRobot (
		RobotId int NOT NULL ,
		TotalPoints int NOT NULL,
		RobotName varchar(64) NOT NULL,
		Incredibility float,
		RankId INT REFERENCES RobotRank(RankId)
		CONSTRAINT PK_IncredibleRobot PRIMARY KEY NONCLUSTERED([RobotId],[TotalPoints])
	);
END;
go

--EXEC PROC7;

GO
CREATE OR ALTER PROCEDURE REVERT_PROC7 AS
BEGIN 
	
	DROP TABLE IF EXISTS IncredibleRobot;
END;
go
EXEC REVERT_PROC7;

-- Create DatabaseVersion table.

--CREATE TABLE DatabaseVersion (
--	CurrentVersion int
--);



--DROP TABLE DatabaseVersion
INSERT INTO DatabaseVersion VALUES (0);

-- Procedure for changing the version of the database.





GO
CREATE OR ALTER PROCEDURE CHANGE_DB_VERSION
	@version int AS
BEGIN
	DECLARE @currentVersion int
	DECLARE @procedureName nvarchar(32)

	
	SET @currentVersion = (
		SELECT DV.CurrentVersion
		FROM DatabaseVersion DV
	)

	IF @version >= 0 AND @version <= 7
	BEGIN
		IF @version > @currentVersion
		BEGIN
			WHILE @currentVersion < @version
			BEGIN
				SET @currentVersion = @currentVersion + 1
				SET @procedureName = 'PROC' + CAST(@currentVersion AS varchar(2))
				EXEC @procedureName
				UPDATE DatabaseVersion SET CurrentVersion = @version
			END
		END
		ELSE
		BEGIN
			WHILE @currentVersion > @version AND @currentVersion != 0
			BEGIN
				SET @procedureName = 'REVERT_PROC' + CAST(@currentVersion AS varchar(2))
				EXEC @procedureName
				SET @currentVersion = @currentVersion - 1
				UPDATE DatabaseVersion SET CurrentVersion = @version
				
			END
		END
		
		RETURN
	END	
	ELSE
	BEGIN
		PRINT 'Invalid version number (should be between 0 and 7).'
		RETURN
	END
END;

EXEC CHANGE_DB_VERSION 0;
EXEC REVERT_PROC7;
EXEC PROC7;
SELECT * FROM DatabaseVersion;
