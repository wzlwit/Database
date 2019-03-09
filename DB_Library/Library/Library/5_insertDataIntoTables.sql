-- insert data into tables of Library database
-- script date: Mars 04,2019
-- Developed by Bianyu WANG(1896181) , Hongyu ZHAO(1895825), Yangyang MA(1896156), Zhaolong Wang(1896216 ) 

-- in order toinsert data into tables, switch to the Library database
-- add a statement that specifies the script runs in the context of the Library database


use Library;
go


--1*****************************************************

bulk insert [Member].[Adults]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\Adult.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '\t' 

	 )
;
select * from [Member].[Adults];

--2*****************************************************

bulk insert [Member].[Members]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\member.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '\t' 

	 )
;
select * from [Member].[Members];

--3*****************************************************

bulk insert [Member].[Juveniles]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\juvenile.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '\t' 

	 )
;
select * from [Member].[Juveniles]
--4*****************************************************

bulk insert [Operation].[Copies]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\copy.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '\t' 

	 )
;
select * from [Operation].[Copies]


--5*****************************************************



bulk insert [Operation].[Items]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\item.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\r' ,
		FIELDTERMINATOR = '\t' 

	 )
;
select * from [Operation].[Items]




--6*****************************************************


bulk insert [Operation].[Titles]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\title.txt'
with (
   
--		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '|' 

	 )
;
select * from [Operation].[Titles]



--7*****************************************************


bulk insert [Operation].[Loanhist]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\loanhist.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\r' ,
		FIELDTERMINATOR = '\t' 

	 )
;
select * from [Operation].[Loanhist]


--8*****************************************************
bulk insert [Operation].[Loans]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\loan.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '\t' 

	 )
;

select * from [Operation].[Loans]

--9*****************************************************



bulk insert [Operation].[Reservations]
from 'C:\Users\ipd\OneDrive - John Abbott College\sql2\Library\Library\data\reservation.txt'
with (
   
		firstrow = 1,
		ROWTERMINATOR = '\n' ,
		FIELDTERMINATOR = '|' 

	 )
;

select * from [Operation].[Reservations]



select * from [Operation].[Titles]