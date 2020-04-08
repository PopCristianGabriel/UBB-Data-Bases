--if object_id('TakesPart','U') is not null
--	drop table TakesPart

--if object_id('Robot','U') is not null
--	drop table Robot

--if object_id('Tournament','U') is not null
--	drop table Tournament




create table Robot(
RID int Primary key identity(1,1),
speed int unique,
name Varchar(20),
city Varchar(30)
)


create table Tournament(
TID int primary key,
Prizepool int)

create table TakesPart(
TPID int primary key,
RID int references Robot(RID),
TID int references Tournament(TID)
)


go
create or alter proc populate
as
declare @speed int = 0
declare @name varchar(20)
declare @city varchar(20)
declare @AlLChars varchar(100) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
while(@speed < 50)
begin
set @name = (SELECT RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) + RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) +
RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) + RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) + RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1))
set @city = (SELECT RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) + RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) +
RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) + RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1) + RIGHT( LEFT(@AlLChars,ABS(BINARY_CHECKSUM(NEWID())%35) + 1 ),1))
insert into Robot Values(@speed,@name,@city)
set @speed = @speed + 1
--print(@speed)
end
go


create or alter proc populate2
as
declare @TID int = 51
declare @PrizePool int = 1
while(@TID < 500)
begin
insert Tournament values(@TId,@PrizePool)
set @TID = @Tid + 1
set @PrizePool = @PrizePool + 20
end
go
exec populate2



exec populate
exec populate2
create nonclustered index i on Robot(Speed)

select distinct(speed) from Robot --scan non clustered

drop index Robot.i


select Speed --seek nonclustered
from Robot
where Speed = 2 and RID > 6




Select *  --seek clustered
from Robot
where RID = 1


select * from Robot --scan clustered



select * from Robot --key lookup

where speed = 50




-----b



select * from Tournament
where Prizepool < 13 -- cost 100

create nonclustered index t on Tournament(Prizepool)

select * from Tournament
where Prizepool <3

drop index Tournament.t




--c




