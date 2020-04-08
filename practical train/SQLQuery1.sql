if object_id('RoutesStations','U') is not null
	drop table RoutesStations

if object_id('Stations','U') is not null
	drop table Stations

if object_id('Routes','U') is not null
	drop table Routes

if object_id('Trains','U') is not null
	drop table Trains

if object_id('TrainTypes','U') is not null
	drop table TrainTypes


create table TrainTypes(
	TTID tinyint PRIMARY KEY IDENTITY(1,1), --seed and increment
	Description Varchar(500)
	)

create table Trains(
	TID smallint primary key identity(1,1),
	TName varchar(100),
	TTID tinyint references TrainTypes(TTID)
	)

create table Routes(
	RID smallint primary key identity(1,1),
	RName varchar(100)	unique,
	TID smallint references Trains(TID)
	)

create table Stations(
	SID smallint PRIMARY KEY IDENTITY(1,1), --seed and increment
	SName Varchar(100) unique
	)

create table RoutesStations(
	RID smallint references Routes(RID),
	SID smallint references Stations(SID),
	Arrival Time,
	Departure Time,
	Primary key(RID,SID)

	)
	go



	create or alter proc uspStationOnRoute
	@RName varchar(100), @SName varchar(100), @Arrival Time, @Dep Time
	as
	declare @RID smallint = (select RID from Routes
							where RName = @RName)

	declare @SID smallint = (select SID from Stations
							where SName = @SName)

	if @RID is null or @SID is null
	begin
		RAISERROR('NO suck station/route',16,1)
		return -1
	end

	if exists(SELECT * FROM RoutesStations
		where RID = @RID and SID = @SID)
		update RoutesStations
		Set Arrival = @Arrival,Departure = @Dep
		where RID = @RID and SID = @SID

	else
		INSERT RoutesStations(RID,SID,Arrival,Departure)
		Values(@RID,@SID,@Arrival,@Dep)

go


insert TrainTypes Values('regio'),('interregio'),('rapid')
insert Trains Values('t1',1),('t2',1),('t3',1)
insert Stations Values('s1'),('s2'),('s3')
insert Routes Values('r1',1),('r2',2),('r3',3)



Select * from TrainTypes
Select * from Trains
Select * from Stations
Select * from Routes



exec uspStationOnRoute 'r1', 's1', '6:00', '6:10'
exec uspStationOnRoute 'r1', 's2', '6:20', '6:50'
exec uspStationOnRoute 'r1', 's3', '6:10', '6:35'
exec uspStationOnRoute 'r2', 's3', '6:10', '6:35'

Select * from RoutesStations

go
create or alter view vRoutesWithAllStations as
Select R.RName
from routes R
where not exists(
Select S.SID
from Stations S
Except
Select RS.SID
from RoutesStations RS
where RS.RID = R.RID
)
go

select * from vRoutesWithAllStations


go
create or alter function ufFilterStations
(@R int)
returns table
return 

Select S.SName
From Stations S
where S.Sid in(
select RS.SID
from RoutesStations RS
group by RS.SID
Having Count(*) >= @R
)
go


select *
from ufFilterStations(2)























