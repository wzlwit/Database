/*    create the MovinOn database 
script Date: Feb/15/2019
*/

/*create tables
PARTIAL SYNTAX: create table table_name(
colume_name data_type constraint(s),
colume_name data_type constraint(s),
.
.
colume_name data_type constraint(s),

);

where constraints define the businedd rules:not null,null,
primary key, and so on  */

--  use database movinon

use Movinon;
-- note: use following command during the development process-NOT in the production 


/*----1 create tables Customers*/

drop table if exists Customers;

 create table Customers
 (
 CustID smallint not null auto_increment,
 CompanyName varchar(30) null,
 ContactFirst varchar(15) not null,
 ContactLast varchar(15) not null,
 Address varchar(40) not null,
 City varchar(20) not null,
 State char(2) not null,
 Zip char(5) not null,
 Phone char(14) not null,
 Balance int not null,
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_Customers primary key clustered (CustID asc)
 );


/*----2 create tables Drivers*/

drop table if exists Drivers;

 create table Drivers
 (
 DriverID smallint not null auto_increment,
 DriverFirst varchar(15) not null,
 DriverLast varchar(15) not null,
 SSN char(9) not null,
 DOB date not null,
 StartDate date not null,
 EndDate date null,
 Address varchar(40) not null,
 City varchar(20) not null,
 State char(2) not null,
 Zip char(5) not null,
 Phone char(10) not null,
 Cell char(10) not null,
 MileageRate DECIMAL(3,2)  not null,
 Review date null,
 DrivingRecord char(1) not null,
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_Drivers primary key clustered (DriverID asc)
 );



/*----3 create tables Employees*/

drop table if exists Employees;

 create table Employees
 (
 EmpID smallint not null auto_increment,
 EmpFirst varchar(15) not null,
 EmpLast varchar(15) not null,
 Address varchar(40) not null,
 City varchar(20) not null,
 State char(2) not null,
 Zip char(5) not null,
 Phone char(10) not null,
 Cell char(10) not null,
 SSN char(9) not null,
 DOB date not null,
 StartDate date not null,
 EndDate date null,
 PositionID tinyint not null ,
 Salary DECIMAL(8,2) null,
 HourlyRate DECIMAL(4,2) null,
 Review date null,
 Memo varchar(60) null,
 WarehouseID varchar(10) not null,
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_Employees primary key clustered (EmpID asc)
 );
 
 


/*----4 create tables Vehicles*/

drop table if exists Vehicles;

 create table Vehicles
 (
 VehicleID char(7) not null ,
 LicensePlateNum char(7) not null,
 Axle tinyint not null,
 color varchar(10) not null,
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_Vehicles primary key clustered (VehicleID asc)
 );
 
 
 
/*----5 create tables StorageUnits*/

drop table if exists StorageUnits;

 create table StorageUnits
 (
 UnitID smallint not null,
 WarehouseID varchar(10) not null,
 UnitSize varchar(10) not null,
 Rent tinyint not null
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
-- constraint pk_StorageUnits primary key clustered (id asc)
 );
 
 
 
/*----6 create tables Warehouses*/

drop table if exists Warehouses;

 create table Warehouses
 (

 WarehouseID varchar(10) not null,
 Address varchar(40) not null,
 City varchar(20) not null,
 State char(2) not null,
 Zip char(5) not null,
 Phone char(10) not null,
 ClimateCont boolean not null,
 SecuDoor boolean not null,

 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_Warehouses primary key clustered (WarehouseID asc)
 );
 

 
 /*----7 create tables UnitRental*/
drop table if exists UnitRental;

 create table UnitRental
 (

 CustID smallint not null,
 WarehouseID varchar(10) not null,
 UnitID smallint not null,
 DateIn date not null,
 DateOut date null
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 -- constraint pk_Warehouses primary key clustered (WarehouseID asc)
 );
 
 
 /*----8 create lookup tables Position*/
drop table if exists Positions;

 create table Positions
 (

 PositionID tinyint not null auto_increment,
 Title varchar(20),
 
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_Positions primary key clustered (PositionID asc)
 );
 
 
 
 /*----9 create lookup tables JobOrders*/
drop table if exists JobOrders;

 create table JobOrders
 (
 JobID smallint not null auto_increment,
 CustID smallint not null ,
 MoveDate date not null,
 FromAddress  varchar(40) not null,
 FromCity varchar(20) not null,
 FromState char(2) not null,
ToAddress  varchar(40) not null,
 ToCity varchar(20) not null,
 ToState char(2) not null,
 DistanceEst smallint not null,
 WeightEst smallint not null,
 Packing boolean not null,
 Heavy boolean not null,
 Storage boolean not null,
 
 /* boolean:These types are synonyms for TINYINT(1). A value of zero is considered false.
 Nonzero values are considered true*/
 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_JobOrders primary key clustered (JobID asc)
 
 );
 
  /*----10 create lookup tables JobDetails*/
drop table if exists JobDetails;

 create table JobDetails
 (
 JobID smallint not null ,
 VehicleID char(7) not null ,
 DriverID smallint not null ,
 MileageActual smallint not null,
 WeightActual smallint not null,

 -- constraint constraint_label constraint_type  (colume_name constraint)
 constraint pk_JobDetails primary key clustered (JobID asc)
 );
 

 