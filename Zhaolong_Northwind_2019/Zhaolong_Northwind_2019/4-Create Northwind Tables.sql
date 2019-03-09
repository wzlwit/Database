/* Create Zhaolong_Northwind Tables
	Script Date: Feb 22, 2019
	Developed by: Zhaolong Wang
*/

--switch to master database

use Zhaolong_Northwind;
go
--include end of batch markers (go statement)

/* Consider the following facts when you create tables in SQL Server.
    You can have up to
        Two billions tables per database
        1024 columns per table
        8092 bytes per row (this does NOT apply to image and text dat)        
 */

/* create a sample table using unique identifier data type with the NewID() function*/

create table myCustomers
(
    CustomerID uniqueidentifier NOT NULL default newID(),
    CompanyName NVARCHAR(40) NOT NULL
    --NVARCHAR (national) with double size
);

insert into myCustomers
    (CompanyName)
values
    ('Cocamola');
go

insert into myCustomers
    (CompanyName)
values
    ('Pepsimola');
go

select *
from myCustomers;
go

/* return the definition of myCustomers table */
execute sp_help myCustomers;
go

/* use only during the development process. Check for existence of a specific objectby verifying the object has an Object ID. If the object exists, it is deleted using the DROP statement. If the object does NOT exist, it will be deleted.
*/
if object_id('Sales.Customers','U') is NOT NULL
    drop table Sales.Customers;
go

-- create obj_type schema_name.object_name
create table Sales.Customers
(
    CustomerID nchar(5) NOT NULL,
    --based on customer name
    CompanyName NVARCHAR(40) NOT NULL,
    ContactName NVARCHAR(30) NULL,
    ContactTitle NVARCHAR(30) NULL,
    Address NVARCHAR(60) NOT NULL,
    --Street number and name
    City NVARCHAR(15) NOT NULL,
    Region NVARCHAR(15) NULL,
    -- State or Province
    PostalCode NVARCHAR(10) NOT NULL,
    Country NVARCHAR(15) NOT NULL,
    Phone NVARCHAR(24) NOT NULL,
    Fax NVARCHAR(24) NULL,
    CONSTRAINT pk_Customers primary key clustered (CustomerID asc)
);
go

/* Table No.2 Sales.Orders */
CREATE TABLE Sales.Orders
(
    OrderID INT IDENTITY(1,1) NOT NULL,
    CustomerID NCHAR(5) NOT NULL,
    --foreign key (CustomerID Sales.Customers)
    OrderDate DATETIME NOT NULL,
    ReuqireDate DATETIME NOT NULL,
    ShippedDAte DATETIME NULL,
    EmployeeID INT NOT NULL,
    --foreign key (EmployeeID in HumanResources.Employees)
    ShipVia INT NULL,
    -- foreign key (ShipperID in Sales.Shippers)
    Freight MONEY NULL,
    ShipName NVARCHAR(40) NULL,
    ShipAddress NVARCHAR (60) NULL,
    ShipCity NVARCHAR(24) NULL,
    ShipReign NVARCHAR(15) NULL,
    ShipPostalCode NVARCHAR(10) NULL,
    ShipCountry NVARCHAR(25) NULL,
    CONSTRAINT pk_Orders PRIMARY KEY CLUSTERED (OrderID ASC)
);
go

/* Table No.3 Sales.[Order Details] */

CREATE TABLE Sales.[Order Details]
(
    OrderID INT NOT NULL,
    --foreign key (OrderId in Sales.Orders)
    ProductID INT NOT NULL,
    --foreign key (ProductID)
    UnitPrice MONEY NOT NULL,
    Quantity SMALLINT NOT NULL,
    Discount REAL NOT NULL,
    CONSTRAINT pk_Order_Details PRIMARY KEY CLUSTERED
        (-- composite primary key
            OrderID ASC, 
            ProductID ASC
        )
);
GO

/* Table No.4 Production.Products */
CREATE TABLE Production.Products
(
    ProductID INT IDENTITY(1,1) NOT NULL,
    --auto generated number
    ProductName NVARCHAR(40) NOT NULL,
    SupplierID INT NULL,
    --foreign key (SupplierID in Production.Suppliers)
    CategoryID INT NULL,
    --foreign key (CategoryID in Production.Categories)
    QuantityPerUnit NVARCHAR(20) NULL,
    --(e.g., 24-count case, 1 liter bottle)
    UnitPrice MONEY NULL,
    UnitsInStock SMALLINT NULL,
    UnitsOnOrder SMALLINT NULL,
    ReorderLevel SMALLINT NULL,--Minimu units to maintain in stock
    Discontinued BIT NOT NULL,
    -- 1 means itme is no longer available
    CONSTRAINT pk_Products PRIMARY KEY CLUSTERED
    (
        ProductID ASC
    )
);
GO

/* Table No.5 Product.Suppliers */
CREATE TABLE Production.Suppliers
(
    SupplierID int IDENTITY(1,1) NOT NULL,--auto generated number
    CompanyName NVARCHAR(40) NOT NULL,
    ContactName NVARCHAR(30) NULL,
    ContactTitle NVARCHAR(30) NULL,
    Address NVARCHAR(60) NOT NULL,
    --Street number and name
    City NVARCHAR(15) NOT NULL,
    Region NVARCHAR(15) NULL,
    -- State or Province
    PostalCode NVARCHAR(10) NULL,
    Country NVARCHAR(15) NULL,
    Phone NVARCHAR(24) NULL,
    Fax NVARCHAR(24) NULL,
    HomePage NVARCHAR(60) NULL,
    CONSTRAINT pk_Suppliers PRIMARY KEY CLUSTERED (SupplierID ASC)
);
GO

/* Table No.6 Production.Categories */
CREATE TABLE Production.Categories
(
    CategoryID INT IDENTITY(1,1) NOT NULL,
    --auto generated number
    CategoryName NVARCHAR(15) NOT NULL,
    Description NVARCHAR(250) NULL,
    Picture IMAGE NULL,
    -- a picture representing the food category
    CONSTRAINT pk_Categories PRIMARY KEY CLUSTERED
    (
        CategoryID ASC
    )
);
GO

/* modify a column:
1. in Access and SQL server
    Alter table table_name
        alter column column_name data_type constraint
2. in MySQL
    alter table table_name
        modify column col_name dtat_type constraint
3. in Oracle
    alter table tb_name
        modify col_name data_type constraint
 */

ALTER TABLE Production.Products
    ALTER COLUMN UnitPrice DECIMAL(6,2) NULL;
GO

ALTER TABLE  Production.Categories
    ALTER COLUMN Picture VARBINARY(MAX) NULL;
GO

/* Return information about the table Production.Categories */
EXECUTE sp_help 'Production.Products';
GO

/* Rename Database objects: database, table, column 
1. rename a database
    execute sp_renamedb 'old db_name', 'new db_name'

2. rename a table
    execute sp_rename 'schema_name.old_tb_name', 'new_tb_name'

3. rename a column
    execute sp_rename 'schema_name.tb_name.old_col_name', 'new_column_name', 'column'; (3rd para to tell the type)
*/

/***** Table No. 7 - Sales.Shippers *****/
CREATE TABLE Sales.Shippers
(
    ShipperID int IDENTITY(1,1) NOT NULL,
    -- auto-generated number
    CompanyName nvarchar(40) NOT NULL,
    -- Name of the shipping company
    Phone nvarchar(24) NULL,
    -- Phone number includes country code and /or area code
    CONSTRAINT pk_Shippers PRIMARY KEY CLUSTERED 
	(
		ShipperID ASC
	)
)
;
go

/***** Table No. 8 - HumanResources.Employees  *****/
CREATE TABLE HumanResources.Employees
(
    EmployeeID int IDENTITY(1,1) NOT NULL,
    -- auto-generated number
    LastName nvarchar(20) NOT NULL,
    FirstName nvarchar(10) NOT NULL,
    Title nvarchar(30) NULL,
    TitleOfCourtesy nvarchar(25) NULL,
    BirthDate datetime NULL,
    HireDate datetime NULL,
    Address nvarchar(60) NULL,
    City nvarchar(15) NULL,
    Region nvarchar(15) NULL,
    PostalCode nvarchar(10) NULL,
    Country nvarchar(15) NULL,
    HomePhone nvarchar(24) NULL,
    Extension nvarchar(4) NULL,
    Photo varbinary(max) NULL,
    Notes nvarchar(250) NULL,
    ReportsTo int NULL,
    -- One employee may report to another employee (self-join) 
    PhotoPath nvarchar(255) NULL,
    DepartmentID smallint NULL,
    -- foreign key (DepartmentID in Departments)
    CONSTRAINT pk_Employees PRIMARY KEY CLUSTERED 
	(
		EmployeeID ASC
	)
)
;
go

/***** Table No. 9 - HumanResources.Region  *****/
CREATE TABLE HumanResources.Region
(
    RegionID int NOT NULL ,
    RegionDescription nchar (50) NOT NULL,
    constraint pk_Region primary key clustered (RegionID asc)
) 
;
GO


/***** Table No. 10 - HumanResources.Territories  *****/
CREATE TABLE HumanResources.Territories
(
    TerritoryID nvarchar (20) NOT NULL ,
    TerritoryDescription nvarchar (50) NOT NULL ,
    RegionID int NOT NULL,
    constraint pk_Territories primary key clustered (TerritoryID asc)
) 
;
GO

/***** Table No. 11 - HumanResources.EmployeeTerritories  *****/
CREATE TABLE HumanResources.EmployeeTerritories
(
    EmployeeID int NOT NULL,
    TerritoryID nvarchar(20) NOT NULL,
    constraint pk_EmployeeTerritories primary key clustered 
	(
		EmployeeID asc,
		TerritoryID asc
	)
) 
;
go

/***** Table No. 12 - Sales.CustomerCustomerDemo  *****/
CREATE TABLE Sales.CustomerCustomerDemo
(
    CustomerID nchar(5) not null,
    CustomerTypeID nvarchar(10) not null,
    CONSTRAINT pk_CustomerCustomerDemo PRIMARY KEY  CLUSTERED 
	(
		CustomerID asc,
		CustomerTypeID asc
	)
)
;
GO

/***** Table No. 13 - Sales.CustomerDemographics  *****/
CREATE TABLE Sales.CustomerDemographics
(
    CustomerTypeID nvarchar(10) not null,
    CustomerDesc nvarchar(250) not null,
    CONSTRAINT pk_CustomerDemographics PRIMARY KEY  CLUSTERED 
	(
		CustomerTypeID asc
	)
)
;
GO

/* display the user-defined and system tables */
exec sp_tables
@table_owner='Sales',
@table_qualifier='Zhaolong_Northwind'
;
go