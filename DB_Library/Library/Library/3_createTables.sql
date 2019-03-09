-- create tables of Library database
-- script date: february 26,2019
-- Developed by Bianyu WANG(1896181) , Hongyu ZHAO(1895825), Yangyang MA(1896156), Zhaolong Wang(1896216 ) 

-- in order to create tables, switch to the Library database
-- add a statement that specifies the script runs in the context of the Library database


use Library
;
go



if OBJECT_ID('Member.Members','U') is not null
drop table Member.Members
;
go

-- Table No.1 - Member.Members
create table Member.Members
(
Member_no smallint identity(1,1) not null, -- auto generated number
LastName nvarchar(20) not null,
FirstName nvarchar(20) not null,
Middle_I nchar(1) null,
Photograph nvarchar(200) null,
constraint pk_member primary key clustered(Member_no asc)
)
;
go


if OBJECT_ID('Member.Adults','U') is not null
drop table Member.Adults
;
go

-- Table No.2 - Member.Adults
create table Member.Adults
(
Member_no smallint not null,
Street	nvarchar(20) not null,	
City	nvarchar(20)	not null,
State	nchar(2)	not null,
ZIP	nchar(10) not null,
PhoneNo	nchar(16)	 null,
-- Email	nvarchar(30)	not null,
Expr_Date	datetime	not null
-- expr_time time not null
constraint pk_Adults primary key clustered(Member_no asc)
)
;
go


if OBJECT_ID('Member.Juveniles','U') is not null
drop table Member.Juveniles
;
go

-- Table No.3 - Member.Juveniles
create table Member.Juveniles
(
Member_no	smallint not null,
--ExpireDate	date not null,  -- 
Adult_member_no	smallint	not null,
Birth_Date	datetime	not null,
--status      nvarchar(10) not null,

constraint pk_Juveniles primary key clustered(Member_no asc)
)
;
go



if OBJECT_ID('Operation.Titles','U') is not null
drop table Operation.Titles
;
go

-- Table No.4 - Operation.Titles
create table Operation.Titles
(
Title_no	smallint identity(1,1), -- auto generated number
Title	nvarchar(60)	not null,
Author	nvarchar(60)	not null,
Description	nvarchar(200)	 null,

constraint pk_Titles primary key clustered(Title_no asc)
)
;
go




if OBJECT_ID('Operation.Items','U') is not null
drop table Operation.Items
;
go
-- Table No.5 - Operation.Items
create table Operation.Items
(
ISBN	smallint identity(1,1) not null,
Title_no smallint not null,
Language	nvarchar(20) null,	
cover	nvarchar(8) null,	
-- PublishYear	date null,	
--Publisher	nvarchar(20) null,	
loanable nchar(1) null
constraint pk_Items primary key clustered(ISBN asc)
)
;
go



if OBJECT_ID('Operation.Copies','U') is not null
drop table Operation.Copies
;
go

-- Table No.6 - Operation.Copies
create table Operation.Copies
(
ISBN	smallint not null,
Copy_no	smallint not null,
title_no smallint not null,
on_loan	nchar(1) not null


constraint pk_Copies primary key clustered
( -- composite primary key
ISBN asc,
Copy_no	asc
))
;
go






if OBJECT_ID('Operation.Reservations','U') is not null
drop table Operation.Reservations
;
go

-- Table No.7 - Operation.Reservations
create table Operation.Reservations
(
ISBN 	smallint not null,
Member_no	smallint not null,
Log_Date	datetime  not null,
remarks nvarchar(200)	 null    

constraint pk_Reservations primary key clustered(
ISBN asc,
Member_no asc
)

)
;
go



if OBJECT_ID('Operation.Loans','U') is not null
drop table Operation.Loans
;
go

-- Table No.8 - Operation.Loans
create table Operation.Loans
(

--LoanID	smallint identity(1,1) not null, -- auto generated number
ISBN	smallint	not null,
Copy_no	smallint	not null,
title_no smallint not null,
Member_no	smallint	not null,
out_Date	datetime	not null,
due_Date	datetime	null



constraint pk_Loans primary key clustered(
 ISBN asc,
 Copy_no asc,
 out_date )
)
;
go 


if OBJECT_ID('Operation.Loanhist','U') is not null
drop table Operation.Loanhist
;
go

-- Table No.9 - Operation.Loanhist
create table Operation.Loanhist
(
ISBN	smallint	not null,
Copy_no	smallint	not null,
out_Date	datetime	not null,
title_no smallint not null,
Member_no	smallint	not null,
due_Date	datetime	null,
in_Date	datetime  null,
Fine_assessed	smallint  null,	
Fine_paid	smallint null,
Fine_waived	smallint	null,
Remarks	nvarchar(200)	null,

constraint pk_LoanHist primary key clustered(
ISBN asc,
Copy_no asc,
out_Date)

)
;
go 