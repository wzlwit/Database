/*    create the MovinOn database 
script Date: Feb/18/2019
*/

use Movinon;



/* add a composite key constraints to table storageUnit
 alter table table_name
   add constraint pk_table_name primary key [clustered] (column_name[asc]);
*/
alter table storageunits
add constraint pk_storageunits primary key 
(UnitID,
 WarehouseID
);

/* add a check constraint  for column rent to table storageunits */
alter table StorageUnits
add constraint ck_rent_storageunits check(rent>0);

-- show columns from storageunits;

/* add a foreign key constraints to table unitrental*/

-- 1. between unitrental and customers tables
alter table unitrental 
add constraint fk_unitrental_customers 
foreign key (CustID) 
references customers(CustID);

show columns from unitrental;



-- 2. between unitrental and warehouses tables


alter table unitrental 
add constraint fk_unitrental_storageunits 
foreign key (UnitID,WarehouseID) 
references storageunits(UnitID,WarehouseID);

/*

select * 
from information_schema.TABLE_CONSTRAINTS
where 
CONSTRAINT_TYPE = 'foreign key'
and TABLE_SCHEMA ='Movinon'
and table_name='unitrental';

*/
-- 3. add composite primary key

alter table unitrental
add constraint pk_unitental primary key
( CustID,
  WarehouseID,
  UnitID);



-- 5. check dateOut > dateIn
alter table unitrental
add constraint ck_dateOut_transactions check (dateOut>=dateIn);





/* add a foreign key constraints to table JobOrders*/
 
--  between JobOrders and Customers

alter table JobOrders 
add constraint fk_JobOrders_Customers foreign key (CustID) references customers(CustID);


/* add a foreign key constraints to table JobDetail*/

-- 1. between JobDetail and JobOrders
alter table jobdetails
add constraint fk_JobDetail_JobOrders foreign key(JobID) references joborders(JobID);
-- 2. between JobDetail and vehicles
alter table jobdetails
add constraint fk_JobDetail_vehicles foreign key(VehicleID) references vehicles(VehicleID);
-- 3. between JobDetail and drivers
alter table jobdetails
add constraint fk_JobDetail_drivers foreign key(DriverID) references drivers(DriverID);
-- add  check MileageActual > 0
alter table jobdetails
add constraint ck_MileageActual_jobdetails check (MileageActual>0);

-- add  check WeightActual > 0
alter table jobdetails
add constraint ck_WeightActual_jobdetails check (WeightActual>0);

/* add a foreign key constraints to table employees*/
-- 1. between employees and positions
alter table employees
add constraint fk_employees_positions foreign key(PositionID) references positions(PositionID);

-- 1. between employees and warehouses
alter table employees
add constraint fk_employees_warehouse foreign key(WarehouseID) references warehouses (WarehouseID);


/* add a default value for column balance to table customers */
alter table customers
 alter column Balance
  set default '0';
  
  
alter table employees
	modify column dob date null
;  

