/* apply data integrity to the flix (dvdrentals)
Script date: February 15, 2019
*/
/* switch to the Flix database
*/
use YMFlix
;

/* constraint types :
1. pk_table_name(column_name) -> pk_Customers(customerID)
2. fk_table_name1_table_name2 -> fk_Orders_Customers references ...
3. Default -> df_column_name_table_name -> df_City_Customers
4. check -> ck_column_name_table_name(condition) -> ck_OrderDate check OrderDate >= ...
5. unique -> uq_column_name_table_name -->uq_CompanyName_suppliers
6. null
7. not null
*/

/* add a primary key to an exsiting table 
	alter table table_name
    add constraint pk_table_name primary key [clustered](column_name [asc])
*/

/* add a default constraint to a column when a table is already exists 
	alter table table_name
    -- in MySQL
      alter column column_name
		set default 'value'
        
	-- in Oracle
    alter table table_name
		modify column_name default 'value'
        
	-- in Microsoft SQL SERVER
    alter table table_name
		alter column column_name
			set default 'value'
*/

/* add foreign key constraint(s) to the table DVDs */

-- 1. between DVDs and MovieTypes tables
alter table DVDs
	add constraint fk_DVDs_MovieTypes foreign key(MTypeID) references MovieTypes (MTypeID)
    ;


-- 2. between DVDs and Studios tables
alter table DVDs
	add constraint fk_DVDs_Studios foreign key(StudID) references Studios (StudID)
    ;

-- 3. between DVDs and Ratings tables
alter table DVDs
	add constraint fk_DVDs_Ratings foreign key(RatingID) references Ratings (RatingID)
    ;

-- 4. between DVDs and Formats tables
alter table DVDs
	add constraint fk_DVDs_Formats foreign key(FormID) references Formats (FormID)
    ;
-- 5. between DVDs and Status tables
alter table DVDs
	add constraint fk_DVDs_Status foreign key(StatID) references Status (StatID)
    ;

-- return the foriegn key constraint(s) in table DVDs
select count(*) as 'No. of Foreign Key constraints'
from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_TYPE = 'FOREIGN KEY'
and 
CONSTRAINT_SCHEMA = 'ymflix'
and
TABLE_NAME = 'dvds'
;

/* add foreign key constraint(s) to the table DVDParticipants */
-- 1. between DVDParticipants and DVDs tables
alter table DVDParticipants
	add constraint fk_DVDParticipants_DVDs foreign key(DVDID) references DVDs (DVDID)
    ;
-- 2. between DVDParticipants and Participants tables
alter table DVDParticipants
	add constraint fk_DVDParticipants_Participants foreign key(PartID) references Participants (PartID)
    ;
-- 3. between DVDParticipants and Roles tables
alter table DVDParticipants
	add constraint fk_DVDParticipants_Roles foreign key(RoleID) references Roles (RoleID)
    ;
    
-- return the foriegn key constraint(s) in table DVDParticipants
select count(*) as 'No. of Foreign Key constraints'
from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_TYPE = 'FOREIGN KEY'
and 
CONSTRAINT_SCHEMA = 'ymflix'
and
TABLE_NAME = 'DVDParticipants'
;

/* add foreign key constraint(s) to the table Orders */
-- 1. between Orders and Customers tables 
alter table Orders
	add constraint fk_Orders_Customers foreign key(CustID) references Customers (CustID)
    ;
-- 2. between Orders and Employees tables     
alter table Orders
	add constraint fk_Orders_Employees foreign key(EmpID) references Employees (EmpID)
    ;
    
-- return the foriegn key constraint(s) in table Orders
select count(*) as 'No. of Foreign Key constraints'
from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_TYPE = 'FOREIGN KEY'
and 
CONSTRAINT_SCHEMA = 'ymflix'
and
TABLE_NAME = 'Orders'
;

/* add foreign key constraint(s) to the Transactions table */
-- 1. between Transactions and Orders tables 
alter table Transactions
	add constraint fk_Transactions_Orders foreign key(OrderID) references Orders (OrderID)
    ;
-- 2. between Transactions and DVDs tables 
alter table Transactions
	add constraint fk_Transactions_DVDs foreign key(DVDID) references DVDs (DVDID)
    ;
-- return the foriegn key constraint(s) in table Transactions 
select count(*) as 'No. of Foreign Key constraints'
from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_TYPE = 'FOREIGN KEY'
and 
CONSTRAINT_SCHEMA = 'ymflix'
and
TABLE_NAME = 'Transactions'
;

-- set the unique constraint to the DVD name in table DVDs
alter table DVDs
  add constraint uq_DVDName_DVDs unique (DVDName)
  ;
  
/* check constraint 
SYNTAX:
	alter TABLE table_NAME
  add constraint CK_COLUMN_NAME_TABLE_NAME check (CONDITION)
  */
  
-- set a check constraint to the transactions table on the Date Due
-- to be greater than or equal to Date Out

alter table transactions
	add constraint ck_DateDue_Transactions
    check(DateDue >= DateOut)
    ;

/* set the default value of NumDisks to 1 in the table DVDS */
alter table DVDs
	alter column NumDisks
		set default '1'
;

show columns from DVDs
;

select *
from information_schema.KEY_COLUMN_USAGE
where 
CONSTRAINT_SCHEMA = 'ymflix'
;
    