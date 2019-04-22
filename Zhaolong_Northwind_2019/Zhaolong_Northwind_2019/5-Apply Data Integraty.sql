/* Apply Data Inegraty to tables in Zhaolong_Nortwind
	Script Date: Feb 26, 2019
	Developed by: Zhaolong Wang
*/

--switch to master database

use Zhaolong_Northwind;
go
--include end of batch markers (go statement)

/* Integrity Types:
    1. Domain (column)
    2. Entity (row)
    3. Referential (between two columns or tables)

    Constraint types:
    1. Primary Key(pk)
        alter table schema_name.tb_name
            add constraint pk_constraint_name primary key clustered
                (col_name ASC)
    2. Foreign Key(fk_)
        alter table schema_name.tb_name
            add constraint fk_1st_tb_name_2nd_tb_name 
                Foreign Key (col_name)
                References 2nd_tb_name(col_name)    
    3. Default (df_)
        alter table shema_name..tb_name
            add constraint df_col_name_tb_name default (value)
            FOR col_name
    4. Check (ck_)
        alter table shema_name..tb_name
            add constraint ck_col_name_tb_name Check (condition)
    5. Unique (uq_)
        alter table shema_name..tb_name
            add constraint uk_col_name_tb_name unique (col_name)
 */

/***** Table No. 1 - Sales.Customers *****/
-- No extra constraints (only one primary key)


/***** Table No. 2 - Sales.Orders *****/

-- Foreign key constraints
/* 1) Between Sales.Orders and Sales.Customers */


/* 2) Between Sales.Orders and Sales.Shippers */
ALTER TABLE Sales.Orders
    ADD CONSTRAINT fk_Orders_ShipVia FOREIGN KEY (ShipVia) REFERENCES Sales.Shippers(ShipperID);
GO

/* 3) Between Sales.Orders and HumanResources.Employees*/
ALTER TABLE Sales.Orders
    ADD CONSTRAINT fk_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES HumanResources.Employees(EmployeeID);
GO
-- Default constraints (set Freight column value to zero)
ALTER TABLE Sales.Orders
    ADD CONSTRAINT df_Freight_Orders DEFAULT 0 FOR Freight
;
GO

/***** Table No. 3 - Sales.[Order Details] *****/
-- Foreign key constraints

/* 1) Between Sales.[Order Details] and Sales.Orders */
ALTER TABLE Sales.[Order Details]
    WITH NOCHECK 
    -- ! will not check the column before adding contstraint
    add CONSTRAINT fk_OrderDetails_Orders FOREIGN KEY (OrderID)
        REFERENCES Sales.Orders (OrderID)
;
GO

/* 2) Between Sales.[Order Details] and Production.Products*/
ALTER TABLE Sales.[Order Details]
    WITH NOCHECK
    ADD CONSTRAINT fk_OrderDetails_Products FOREIGN KEY (ProductID)
        REFERENCES Production.Products (ProductID)
;
GO

-- Default constraints
/* set the default constraint value to 0 for UnitPrice and Discount, and 1 for Quantity column */

-- 1. set the default constraint value to 0 for UnitPrice
ALTER TABLE Sales.[Order Details]
    ADD CONSTRAINT df_UnitPrice_OrderDetails DEFAULT 0 FOR UnitPrice
;
GO
-- 2. set the default constraint value to 0 for Discount
ALTER TABLE Sales.[Order Details]
    ADD CONSTRAINT df_Discount_OrderDetails DEFAULT 0 for Discount
;
GO
-- 3. set the default constraint value to 1 for Quantity
ALTER TABLE Sales.[Order Details]
    ADD CONSTRAINT df_Quantity_OrderDetails DEFAULT 1 for Quantity
;
go

/***** Table No. 4 - Production.Products *****/

-- Foreign key constraints
/* 1) Between Production.Products and Production.Suppliers*/
ALTER TABLE Production.Products
    ADD CONSTRAINT fk_Production_Categories FOREIGN KEY (CategoryID)
    REFERENCES Production.Categories(CategoryID)
;
GO

/* 2) Between Production.Products and Production.Categories */
ALTER TABLE Production.Products
    ADD CONSTRAINT fk_Production_Suppliers FOREIGN KEY (SupplierID)
    REFERENCES Production.Suppliers(SupplierID)
;
GO

-- Default constraints
/* set the default value to 0 for: UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, and Discontinued columns in Production.Products*/

-- 1. set the default constraint value to 0 for UnitPrice
ALTER TABLE Production.Products
    ADD CONSTRAINT df_UnitPrice_Products DEFAULT 0 FOR UnitPrice
;
GO
-- 2. set the default constraint value to 0 for UnitsInStock
ALTER TABLE Production.Products
    ADD CONSTRAINT df_UnitsInStock_Products DEFAULT 0 FOR UnitsInStock
;
GO
-- 3. set the default constraint value to 0 for UnitsOnOrder
ALTER TABLE Production.Products
    ADD CONSTRAINT df_UnitsOnOrder_Products DEFAULT 0 FOR UnitsOnOrder
;
GO
-- 4. set the default constraint value to 0 for ReorderLevel
ALTER TABLE Production.Products
    ADD CONSTRAINT df_ReorderLevel_Products DEFAULT 0 FOR ReorderLevel
;
GO
-- 5. set the default constraint value to 0 for Discontinued
ALTER TABLE Production.Products
    ADD CONSTRAINT df_Discontinued_Products DEFAULT 0 FOR Discontinued
;
GO

-- Check constraint 
/* check that the following column values in the Products table must be >= 0: UnitPrice, ReorderLevel, UnitsInStock, UnitsOnOrder */

-- 1. check that UnitPrice >= 0
ALTER TABLE Production.Products
    ADD CONSTRAINT ck_UnitPrice_Products CHECK (UnitPrice>=0)
;
GO
-- 2. check that UnitsInStock >= 0
ALTER TABLE Production.Products
    ADD CONSTRAINT ck_UnitsInStock_Products CHECK (UnitsInStock>=0)
;
GO
-- 3. check that UnitsOnOrder >= 0
ALTER TABLE Production.Products
    ADD CONSTRAINT ck_UnitsOnOrder_Products CHECK (UnitsOnOrder>=0)
;
GO
-- 4. check that ReorderLevel >= 0
ALTER TABLE Production.Products
    ADD CONSTRAINT ck_ReorderLevel_Products CHECK (ReorderLevel>=0)
;
GO

/* create a unique constraint on the column ProductName in the Production.Products table */
ALTER TABLE Production.Products
    ADD CONSTRAINT uq_ProductName_Products UNIQUE (ProductName)
;
GO

/***** Table No. 5 - Production.Suppliers *****/
-- No extra constraints (only one primary key)

/***** Table No. 6 - Production.Categories *****/
-- No extra constraints (only one primary key)

/***** Table No. 7 - Sales.Shippers *****/
-- No extra constraints (only one primary key)

/***** Table No. 8 - HumanResources.Employees  *****/
-- Foreign key between Employees.EmployeeID and Employees.ReportsTo
ALTER TABLE HumanResources.Employees
    ADD CONSTRAINT fk_Employees_Employees FOREIGN KEY (ReportsTo) REFERENCES HumanResources.Employees(EmployeeID)
;
GO
-- Check Birth Date to be less than current date
ALTER TABLE HumanResources.Employees
    ADD CONSTRAINT ck_BirthDate_Employees CHECK (BirthDate<=GETDATE())
;
GO

/***** Table No. 9 - HumanResources.Region  *****/
-- No extra constraints (only one primary key)

/***** Table No. 10 - HumanResources.Territories  *****/
-- Foreign key constraints
/* Between HumanResources.Territories and HumanResources.Region*/
ALTER TABLE HumanResources.Territories
    ADD CONSTRAINT fk_Territories_Region FOREIGN KEY (RegionID) REFERENCES HumanResources.Region(RegionID)
;
GO

/***** Table No. 11 - HumanResources.EmployeeTerritories  *****/
-- Foreign key constraints
/* 1) Between HumanResources.EmployeeTerritories and HumanResources.Employees*/
ALTER TABLE HumanResources.EmployeeTerritories
    ADD CONSTRAINT fk_EmployeeTerritories_Employees FOREIGN KEY (EmployeeID) REFERENCES HumanResources.Employees(EmployeeID)
;
GO
/* 2) Between HumanResources.EmployeeTerritories and HumanResources.Territories*/
ALTER TABLE HumanResources.EmployeeTerritories
    ADD CONSTRAINT fk_EmployeeTerritories_Territories FOREIGN KEY (TerritoryID) REFERENCES HumanResources.Territories(TerritoryID)
;
GO

/***** Table No. 12 - Sales.CustomerCustomerDemo  *****/
-- No extra constraints (only one primary key)
-- Foreign key constraints
/* 1) Between Sales.CustomerCustomerDemo and Sales.CustomerDemographics */
ALTER TABLE Sales.CustomerCustomerDemo
    ADD CONSTRAINT fk_CustomerCustomerDemo_CustomerDemographics FOREIGN KEY (CustomerTypeID) REFERENCES Sales.CustomerDemographics(CustomerTypeID)
;
GO

/* 2) Between Sales.CustomerCustomerDemo and Sales.Customers */
ALTER TABLE Sales.CustomerCustomerDemo
    ADD CONSTRAINT fk_CustomerCustomerDemo_Customers FOREIGN KEY (CustomerID) REFERENCES Sales.Customers(CustomerID)
;
GO

/***** Table No. 13 - Sales.CustomerDemographics  *****/
-- No extra constraints (only one primary key)