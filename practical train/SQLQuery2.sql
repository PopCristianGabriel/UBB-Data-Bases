


if object_id('Transactions','U') is not null
	drop table Transactions

if object_id('ATMs','U') is not null
	drop table ATMs


if object_id('Cards','U') is not null
	drop table Cards

if object_id('BankAccounts','U') is not null
	drop table BankAccounts

if object_id('Customers','U') is not null
	drop table Customers



create table Customers(
CID int primary key,
Name varchar(20),
BDate DateTime
)

create table BankAccounts(
BID int primary key,
IBAN varchar(30),
CurrentBallance int,
CID int references Customers(CID)
)

Create Table Cards(
CardID int primary key,
CCV int,
BID int references BankAccounts(BID)
)

Create Table ATMs(
ATMID int primary key,
Address varchar(30)
)

Create table Transactions(
ATMID int references ATMs(ATMID),
CardID int references Cards(CardID),
SumOfMoney int,
TimeOfTransaction Time
)




insert Customers values(1,'dawd','20120617 10:34:09 AM')
insert Customers values(2,'dawd2','20120618 10:34:09 AM')
insert Customers values(3,'dawd3','20120615 10:34:09 AM')
insert Customers values(4,'dawd4','20120616 10:34:09 AM')


insert BankAccounts values(1,'12341241',2000,1)
insert BankAccounts values(2,'21234115',3000,1)
insert BankAccounts values(3,'23434646',250,2)
insert BankAccounts values(4,'32445464',500,3)
insert BankAccounts values(5,'54343545',2500,4)

insert Cards values(1,123,1)
insert Cards values(2,234,1)
insert Cards values(3,345,1)
insert Cards values(4,456,1)
insert Cards values(5,567,1)

insert ATMs values(1,'adresa1')
insert ATMs values(2,'adresa2')

insert Transactions values(1,1,1000,'20:18')
insert Transactions values(1,2,1500,'20:18')
insert Transactions values(2,1,1500,'20:18')
insert Transactions values(2,3,200,'20:18')






go





create or alter proc deleteTransactions
@CID int 
as
delete 
from Transactions 
 where CardID =  @CID


 go





create or alter view AllATMs
as
select C.CardID
from Cards C
where ((Select count(*) from Transactions T where T.CardID = C.CardID) = (Select count(*) from ATMs)) 

go



go
create or alter function GreaterThan2000
(@R int)
returns table
return
Select C.CardID,c.CCV
from Cards C
where (Select sum(T.SumOfMoney) from Transactions T where C.CardID = T.CardID) > @R
go

select *
from GreaterThan2000(10)












