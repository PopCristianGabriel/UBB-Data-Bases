CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO




create table GenericRobot(
Id int,
CONSTRAINT PK_ID PRIMARY KEY(Id)
)

create table GenericTournament(
TournamentId int,
CONSTRAINT PK_TN PRIMARY KEY(TournamentId),
RobotId INT references GenericRobot(Id)
)

create table RobotParts(
upperBody int,
lowerBody int,
CONSTRAINT PK_PARTS PRIMARY KEY (upperBody, lowerBody)
)


go

Create or alter View View_1 As
Select *
from RobotParts

go

Create or alter view View_2 As
Select *
from GenericRobot
full JOIN GenericTournament on GenericRobot.Id = GenericTournament.RobotId
go

Create or alter View View_3 as
Select RobotId
from GenericRobot
full JOIN GenericTournament on GenericRobot.Id = GenericTournament.RobotId
group by RobotId
go

select * from View_1

Select * from View_2

Select * from View_3

Select * from Tests









DELETE FROM Tables;

INSERT INTO Tables
VALUES ('GenericRobot'), ('GenericTournament'), ('RobotParts');

Select * from Tables



-- Views (Name)
DELETE FROM Views;

INSERT INTO Views
VALUES ('View_1'), ('View_2'), ('View_3');



-- Tests (Name)
DELETE FROM Tests;

INSERT INTO Tests
VALUES ('insertGenericRobot'), ('deleteGenericRobot'), ('insertGenericTournament'), ('deleteGenericTournament'), ('insertRobotParts'), ('deleteRobotParts'), ('evaluateViews');


--last check
SELECT * FROM Tables;
SELECT * FROM Views;
SELECT * FROM Tests;


-- TestTables (TestID, TableID, NoOfRows, Position) 
DELETE FROM TestTables;


INSERT INTO TestTables
VALUES (1, 1, 1000, 1),
	   (3, 2, 1000, 2),
	   (5, 3, 1000, 3);


SELECT * FROM TestTables;



-- TestViews (TestID, ViewID) 
DELETE FROM TestViews;

INSERT INTO TestViews
VALUES (7, 1),
	   (7, 2),
	   (7, 3);

SELECT * FROM TestViews;




--generic robot

GO
CREATE OR ALTER PROC insertGenericRobot
AS 
	DECLARE @currentRow INT = 1
	DECLARE @noOfRows INT
	SELECT @noOfRows = NoOfRows FROM TestTables WHERE TestId = 1
	WHILE @currentRow <= @noOfRows 
	BEGIN 
		INSERT INTO GenericRobot VALUES (@currentRow * 2)
		SET @currentRow = @currentRow + 1 
	END 

GO 
CREATE OR ALTER PROC deleteGenericRobot
AS 
	DELETE FROM GenericRobot WHERE Id > 2;

GO 

--generic tournament

CREATE OR ALTER PROC insertGenericTournament
AS 
	DECLARE @currentRow INT = 1
	DECLARE @noOfRows INT
	SELECT @noOfRows = NoOfRows FROM TestTables WHERE TestId = 3
	WHILE @currentRow <= @noOfRows 
	BEGIN 
		INSERT INTO GenericTournament VALUES (@currentRow, 2)
		SET @currentRow = @currentRow + 1 
	END 


GO 
CREATE OR ALTER PROC deleteGenericTournament 
AS 
	DELETE FROM GenericTournament;

GO



--robot parts
CREATE OR ALTER PROC insertRobotParts
AS 
	DECLARE @currentRow INT = 1
	DECLARE @noOfRows INT
	SELECT @noOfRows = NoOfRows FROM TestTables WHERE TestId = 5
	WHILE @currentRow <= @noOfRows 
	BEGIN 
		INSERT INTO RobotParts VALUES (@currentRow, @currentRow)
		SET @currentRow = @currentRow + 1 
	END 

go
CREATE OR ALTER PROC deleteRobotParts
AS 
	DELETE FROM RobotParts;
GO


-- executeTestRunTables
GO
CREATE OR ALTER PROC executeTestRunTables
AS 
	DECLARE @begin1 DATETIME;
	DECLARE @end1 DATETIME;
	DECLARE @begin2 DATETIME;
	DECLARE @end2 DATETIME;
	DECLARE @begin3 DATETIME;
	DECLARE @end3 DATETIME;
	DECLARE @begin4 DATETIME;
	DECLARE @end4 DATETIME;
	DECLARE @begin5 DATETIME;
	DECLARE @end5 DATETIME;
	DECLARE @begin6 DATETIME;
	DECLARE @end6 DATETIME;

	SET @begin1 = GETDATE();
	PRINT('inserting data into GenericRobot')
	EXEC insertGenericRobot;
	SET @end1 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_insert_GenericRobot', @begin1, @end1);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 1, @begin1, @end1);

	SET @begin2 = GETDATE();
	PRINT('deleting data from GenericRobot')
	EXEC deleteGenericRobot;
	SET @end2 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_delete_GenericRobot', @begin2, @end2);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 1, @begin2, @end2);

	SET @begin3 = GETDATE();
	PRINT('inserting data into GenericTournament')
	EXEC insertGenericTournament;
	SET @end3 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_insert_GenericTournament', @begin3, @end3);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 2, @begin3, @end3);

	SET @begin4 = GETDATE();
	PRINT('deleting data from GenericTournament')
	EXEC deleteGenericTournament;
	SET @end4 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_delete_GenericTournament', @begin4 , @end4);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 2, @begin4 , @end4);

	SET @begin5  = GETDATE();
	PRINT('inserting data into RobotParts')
	EXEC insertRobotParts;
	SET @end5 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_insert_RobotParts', @begin5, @end5);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 3, @begin5, @end5);

	SET @begin6 = GETDATE();
	PRINT('deleting data from RobotParts')
	EXEC deleteRobotParts;
	SET @end6 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_delete_RobotParts', @begin6, @end6);
	INSERT INTO TestRunTables VALUES (@@IDENTITY, 3, @begin6, @end6);
go



CREATE OR ALTER PROC executeTestRunViews
AS 
	DECLARE @start1 DATETIME;
	DECLARE @end1 DATETIME;
	DECLARE @start2 DATETIME;
	DECLARE @end2 DATETIME;
	DECLARE @start3 DATETIME;
	DECLARE @end3 DATETIME;
	
	SET @start1 = GETDATE();
	PRINT ('executing SELECT * FROM RobotParts..')
	EXEC ('SELECT * FROM View_1');
	SET @end1 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_View_1', @start1, @end1)
    INSERT INTO TestRunViews VALUES (@@IDENTITY, 1, @start1, @end1);

	SET @start2 = GETDATE();
	PRINT ('executing SELECT * FROM GenericRobot..')
	EXEC ('SELECT * FROM View_2');
	SET @end2 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_View_2', @start2, @end2)
    INSERT INTO TestRunViews VALUES (@@IDENTITY, 2, @start2, @end2);

	SET @start3 = GETDATE();
	PRINT ('executing SELECT * FROM GenericRobot..')
	EXEC ('SELECT * FROM View_3');
	SET @end3 = GETDATE();
	INSERT INTO TestRuns VALUES ('test_View_3', @start3, @end3)
    INSERT INTO TestRunViews VALUES (@@IDENTITY, 3, @start3, @end3);
GO


EXEC executeTestRunTables
EXEC executeTestRunViews;

SELECT * FROM TestRuns;
SELECT * FROM TestRunTables;
SELECT * FROM TestRunViews;


--DELETE FROM GenericRobot;
--DELETE FROM GenericTournament;
--DELETE FROM RobotParts;

--DELETE FROM TestRunViews;
--DELETE FROM TestRunTables;
--DELETE FROM TestRuns;