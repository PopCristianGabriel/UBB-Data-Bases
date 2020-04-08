
if object_id('Purchases','U') is not null
	drop table Purchases


if object_id('Storage','U') is not null
	drop table Storage

if object_id('Pharmacy','U') is not null
	drop table Pharmacy

if object_id('Medicine','U') is not null
	drop table Medicine


if object_id('Prescription','U') is not null
	drop table Prescription


if object_id('MedicalOffice','U') is not null
	drop table MedicalOffice






create table MedicalOffice(
MOID int primary key,
Name varchar(30) unique,
Address varchar(50)
)

create table Prescription(
PID int primary key,
MOName varchar(30) references MedicalOffice(Name)
)

create table Medicine(
MID int primary key,
Name varchar(30),
ExpireDate date,
PID int references Prescription(PID)
)

create table Pharmacy(
PHID int primary key,
Name varchar(30),
Address varchar(50),
)



create table Storage(
MID int references Medicine(MID),
PHID int references Pharmacy(PHID),
primary key(MID,PHID)
)





create table Purchases(
MID int references Medicine(MID),
PHID int references Pharmacy(PHID),
primary key(MID,PHID),
LastTimeOfPurchase DateTime
)


insert MedicalOffice values(1,'Andrei','Blabla')
insert MedicalOffice values(2,'Darius','Blabla2')


insert Prescription values(1,'Andrei')

insert Prescription values(2,'Andrei')

insert Prescription values(3,'Andrei')

insert Prescription values(4,'Darius')

insert Prescription values(5,'Darius')

insert Prescription values(6,'Darius')



go
create or alter proc DeletePrescriptions
@DoctorName varchar(30)
as
delete
from Prescription 
where Prescription.MOName = @DoctorName


select * from Prescription

exec DeletePrescriptions 'Andrei'

select * from Prescription



insert Medicine values(1,'med1','24-Jun-04',1)
insert Medicine values(2,'med2','24-July-04',2)
insert Medicine values(3,'med3','24-August-04',3)

select * from Medicine

insert Pharmacy values(1,'Ph1','address1')
insert Pharmacy values(2,'Ph2','address2')
insert Pharmacy values(3,'Ph3','address3')



insert Storage values(1,1)
insert Storage values(1,2)
insert Storage values(1,3)
insert Storage values(2,2)


select * from Storage



go

create or alter View GetMedicineAll
as
Select M.Name
from Medicine M
where (Select count(*) from Pharmacy) = (Select count(*) from Storage where MID = M.MID)

go


select * from GetMedicineAll


go


create or alter function FilterMeds
(@D date, @P int)
returns table
return
select M.Name
from Medicine M
where (M.ExpireDate > @D) and ((Select count(*) from Storage where M.MID = MID) > @P)

go
select *
from FilterMeds('23-Jun-04',2)










