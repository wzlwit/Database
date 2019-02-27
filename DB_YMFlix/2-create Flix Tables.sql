/*create tables in the Flix (DVDRentals) database
Script date: February 15, 2019
*/

/* switch to the Flix database
*/
use YMFlix
;
/*create a table
 partial SYNTAX: 
	create table table_name
	(
		colunm_name data_type constraint(s),
        colunm_name data_type constraint(s),
        ...
        colunm_name data_type constraint(s),
	)
    ;
where constraints define the business rules: 
not null, null, primary key, and so on
*/

/* note: use the following command during the development process-
NOT in the production server */
drop table if exists Customers
;

/***** 1-create customers table *****/
create table if not exists Customers
	(
		CustID smallint auto_increment not null primary key,
       CustFN varchar(20) not null,
       CustMN varchar(20) null,
        CustLN varchar(20) not null
	)
    ;
-- show the dtabase definition
show create database ymflix
;
show create table customers
;

show tables
;
describe customers
;
show columns from customers
;
/***** 2-create roles table *****/
drop table if exists Roles
;
create table Roles
	(
		RoleID varchar(4) not null primary key,
        RoleDescrip varchar(30) not null
	)
    ;
    
-- or
create table Roles
(
  RoleID varchar(4) not null,
        RoleDescrip varchar(30) not null,
        -- constraint constraint_label constraint_type
        constraint pk_Roles primary key (RoleID asc)
	)
    ;
    
show columns from roles
;  

-- create the lookup tables
/***** 3-create MovieTypes table *****/
drop table if exists MovieTypes
;
create table MovieTypes
	(
		MTypeID varchar(4) not null primary key,
        MTypeDescrip varchar(30) not null
	)
    ;
    
-- or
create table MovieTypes
(
  MTypeID varchar(4) not null,
        MTypeDescrip varchar(30) not null,
        -- constraint constraint_label constraint_type
        constraint pk_MovieTypes primary key clustered(MTypeID asc)
	)
    ;
    
show columns from MovieTypes
;  
/***** 4-create studios table *****/
drop table if exists Studios
;

create table Studios
(
  StudID varchar(4) not null,
        StudDescrip varchar(40) not null,
        -- constraint constraint_label constraint_type
        constraint pk_Studios primary key clustered(StudID asc)
	)
    ;
    
/***** 5-create Ratings table *****/
drop table if exists Ratings
;

create table Ratings
(
  RatingID varchar(3) not null,
        RatingDescrip varchar(20) not null,
        -- constraint constraint_label constraint_type
        constraint pk_Ratings primary key clustered(RatingID asc)
	)
    ;
    
/*modify the RatingID to varchar(4) in the ratings table */
alter table Ratings
	modify RatingID varchar(4) not null
;

alter table Ratings
	modify RatingDescrip varchar(30) not null
;

show columns from ratings
; 

/*-- drop the RatingID PRIMARY KEY 
alter table ratings
drop pk_ratings;*/


/***** 6-create Formats table *****/
drop table if exists Formats
;

create table Formats
(
  FormID varchar(4) not null,
        FormDescrip varchar(40) not null,
        -- constraint constraint_label constraint_type
        constraint pk_Formats primary key clustered(FormID asc)
	)
    ;
    
/***** 7-create Status table *****/
drop table if exists Status
;

create table Status
(
  StatID varchar(3) not null,
        StatDescrip varchar(20) not null,
        -- constraint constraint_label constraint_type
        constraint pk_Status primary key clustered(StatID asc)
	)
    ;
/***** 8-create Transactions table *****/
drop table if exists Transactions
;

create table Transactions
(
  TransID int not null auto_increment,
  OrderID int not null, -- foreign key (Orders table)
  DVDID smallint not null,-- foreign key (DVDs table)
  DateOut date not null,
  DateDue date not null,
   DateIn date null,
  
        -- constraint constraint_label constraint_type
        constraint pk_Transactions primary key clustered(TransID asc)
	)
    ;
    
    /***** 9-create Participants table *****/
drop table if exists Participants
;

create table Participants
(
  PartID smallint not null,
  PartFN varchar(20) not null,
	PartMN varchar(20) null,
	PartLN varchar(20) not null,
  
        -- constraint constraint_label constraint_type
        constraint pk_Participants primary key clustered(PartID asc)
	)
    ;
  alter table Participants
	modify PartID smallint auto_increment not null
    ;  
alter table dvdparticipants    
drop foreign key fk_DVDParticipants_Participants
;
    
/*remove the column RoleID */

ALTER TABLE participants
drop column RoleID
;

 /***** 10-create Employees table *****/
drop table if exists Employees
;

create table Employees
(
   EmpID smallint not null,
  EmpFN varchar(20) not null,
	EmpMN varchar(20) null,
	EmpLN varchar(20) not null,
  
        -- constraint constraint_label constraint_type
        constraint pk_Employees primary key clustered(EmpID asc)
	)
    ;
    
alter table Employees
	modify EmpID smallint auto_increment not null
    ;  
alter table Orders    
drop foreign key fk_Orders_Employees
;
    
    /***** 11-create DVDs table *****/
drop table if exists DVDs
;

create table DVDs
(
   DVDID smallint not null auto_increment,
  DVDName varchar(60) not null,
	NumDisks tinyint not null,
	YearRlsd year not null,
    MTypeID varchar(4) not null, -- foreign key (MovieTypes table)
    StudID varchar(4) not null, -- foreign key (Studios table)
    RatingID varchar(4) not null, -- foreign key (Ratings table)
    FormID varchar(2) not null, -- foreign key (Formats table)
    StatID char(3) not null, -- foreign key (Status table)
  
        -- constraint constraint_label constraint_type
        constraint pk_DVDs primary key clustered(DVDID asc)
	)
    ;
    
/* set the data type to char(4) for the column YearRlsd in table DVDS*/
alter table DVDs
	modify YearRlsd char(4) not null
    ;
    
-- set the data type StatID to char(2) in the table DVDs
alter table DVDS
	modify StatID char(2) not null
    ;
    
SHOW columns from DVDs
;
    
     /***** 12-create Orders table *****/
drop table if exists Orders
;

create table Orders
(
   OrderID int not null,
    CustID smallint not null, -- foreign key (Customers table)
    EmpID smallint not null, -- foreign key (Employees table)
    
  
        -- constraint constraint_label constraint_type
        constraint pk_Orders primary key clustered(OrderID asc)
	)
    ;
    
alter table Orders
	modify OrderID smallint auto_increment not null
    ;  
alter table transactions
drop foreign key fk_Transactions_Orders
;
    
    /***** 13-create DVDParticipants table *****/
drop table if exists DVDParticipants
;

create table DVDParticipants
(

   DVDID smallint not null,-- foreign key (DVDs table)
   PartID smallint not null,-- foreign key (Participants table)
   RoleID varchar(4) not null,-- foreign key (Roles table)
	
  
        -- constraint constraint_label constraint_type
        constraint pk_DVDParticipants primary key clustered
        ( DVDID asc,
       PartID asc,
        RoleID asc
        ) -- composite primary key
	)
    ;
  /*return the definition about the base tables in mysql server */   
    select*
    from information_schema.TABLES
    where TABLE_TYPE = 'base table'
    and TABLE_SCHEMA = 'ymflix'
    ;
    
    /*return the definition of the table customers */
    
    select*
    from information_schema.COLUMNS
    where TABLE_name = 'customers'
    ; 
    
-- how many base tables in the database
select count(TABLE_NAME) as 'No. of table'
from information_schema.TABLES
where CONSTRAINT_TYPE = 'base table'
and 
CONSTRAINT_SCHEMA = 'ymflix'
;

-- return the information about the table customers
  select column_name, data_type, is_nullable, column_key, column_default, column_type
    from information_schema.COLUMNS
    where TABLE_name = 'customers'
    and TABLE_SCHEMA = 'ymflix'
    ; 