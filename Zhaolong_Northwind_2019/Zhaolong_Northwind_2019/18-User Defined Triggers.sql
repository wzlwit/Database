/*  user defined triggers T-SQL functions
	Script Date: Mar 7, 2019
	Developed by: Zhaolong Wang
*/

--switch to Northwind database
USE Northwind2019;
GO

/* display a message to the client when anyone adds or changes data in the customers table */

CREATE TRIGGER Sales.NotifyCustomerTr
ON Sales.customers
AFTER INSERT,UPDATE
AS
    raiserror('Notify Customer on Changing Data',
    10, --severity
    1 -- state
    )
;
GO

-- testing Sales.NotifyCustomerTr
INSERT INTO Sales.Customers(CustomerID, CompanyName)
VALUES('ABCDE','ABCDE Corporation')
;
GO

SELECT * FROM Sales.Customers
WHERE CustomerID='ALFKI'

DELETE Sales.Customers
WHERE CustomerID='ABCDE' --no notifcation of change

UPDATE Sales.Customers
SET ContactName='Margeret Drump' --Maria Anders
WHERE CustomerID='ALFKI'
;
GO

UPDATE Sales.Customers
SET ContactName='Maria Anders'
WHERE CustomerID='ALFKI'
;
GO

/* create a trigger, checkModifiedDateTr, that checks the modified date column, which ensures that during the insert of a new department, the modified date is the current date. If it is not, the row will be updated, setting the modified date to the currnet date and time */

-- create the table Departments
CREATE TABLE HumanResources.Departments(
    DepartmentID INT identity(1,1) NOT NULL,
    DepartmentName nvarchar(40) NOT NULL,
    ModifiedDate datetime null,
    constraint pk_Departments primary key clustered (DepartmentID asc)
)
;
go

insert into HumanResources.Departments (DepartmentName)
VALUES ('IT')
;
go



alter trigger HumanResources.checkModifiedDateTr
on HumanResources.Departments
for insert, update
as 
    begin
        -- declare variables
        declare @ModifiedDate as datetime,
                @DepartmentID as int
        -- compute return value
        select @ModifiedDate=ModifiedDate,
                @DepartmentID=DepartmentID
        from inserted
        -- making decision
        if (abs(datediff(day, @ModifiedDate,getdate()))>0) or (@ModifiedDate is null)
            begin
                -- set the modified date to the current
                update Departments
                set ModifiedDate=getdate()
                where DepartmentID=@DepartmentID
            end
    end
;
go

create trigger HumanResources.chkModDateTr
on HumanResources.Departments
for insert, update
as 

    
    begin
        -- declare variables
        declare @ModifiedDate as datetime,
                @DepartmentID as int
        -- compute return value
        select @ModifiedDate=ModifiedDate,
                @DepartmentID=DepartmentID
        from inserted
        -- making decision
        if (abs(datediff(day, @ModifiedDate,getdate()))>0) or (@ModifiedDate is null)
            begin
                -- set the modified date to the current
                update Departments
                set ModifiedDate=getdate()
                where DepartmentID=@DepartmentID
            end
    end
;
go


insert into HumanResources.Departments(DepartmentName, ModifiedDate)
Values ('Production', '1/15/2020')
;
go

update HumanResources.Departments
set DepartmentName='IT Pro'
where DepartmentID=1
;
go

/* enable and disable trigger
    DISABLE | DISABLE trigger trigger_name on talbe_name.schema_name
 */

 disable trigger HumanResources.checkModifiedDateTr on HumanResources.Departments
 ;
 go
 
 set IDENTITY_INSERT HumanResources.Departments ON;
 dbcc checkident ('HumanResources.Departments',reseed,2);
 insert into HumanResources.Departments 
 Values('HR','3/3/2020')
 ;
 go

 insert into HumanResources.Departments (DepartmentName)
 Values('Sales')
 ;
 go

 select * from HumanResources.Departments;

 /* create EmployeleData and AuditEmployeeData tables */
 create table HumanResources.EmployeeData(
     EmployeeID int identity(1,1) not null,
     BankAccountNumber nchar(10) not null,
     Salary money not null,
     SocialInsuranceNumber nchar(11) not null,
     LastName nvarchar(30) not null,
     FirstName nvarchar(30) not null,
     ManagerID int not null,
     constraint pk_EmployeeDate primary key clustered (EmployeeID asc)
 )
 ;
 go


 create table HumanResources.AuditEmployeeData(
     AuditLogID uniqueidentifier default newID(),
     LogType nchar(3) not null,
     AuditEmployeeID int not null,
     AuditBankAccountNumber nchar(10) null,
     AuditSalary money null,
     AuditSocialInsuranceNumber nchar(11) null,
     /* return the login name associated with the security indentification number(SID) */
     AuditUser sysname default suser_name(),
     AuditModifiedDate datetime default getdate()
 )


/* create trigger EmployeeDataTr */
alter trigger HumanResources.EmployeeDataTr
on HumanResources.EmployeeData
for update
as 
    begin
        -- audit old record
        insert into HumanResources.AuditEmployeeData(
            LogType,
            AuditEmployeeID,
            AuditBankAccountNumber,
            AuditSalary,
            AuditSocialInsuranceNumber
        )
        select 'old', --just pass in the value
        del.EmployeeID,
        del.BankAccountNumber,
        del.Salary,
        del.SocialInsuranceNumber
        from deleted as del
		--audit new record
		        insert into HumanResources.AuditEmployeeData(
            LogType,
            AuditEmployeeID,
            AuditBankAccountNumber,
            AuditSalary,
            AuditSocialInsuranceNumber
        )
        select 'new', --just pass in the value
        ins.EmployeeID,
        ins.BankAccountNumber,
        ins.Salary,
        ins.SocialInsuranceNumber
        from inserted as ins
    end
;

/* add a new employee in the table EmployeeDate */
insert into HumanResources.EmployeeData(
    BankAccountNumber,
    Salary,
    SocialInsuranceNumber,
    LastName,
    FirstName,
    ManagerID
)
Values ('S-12345678',45000.00,'123-456-789','Smith','John',32)
;
go

/* to reset the identity value to start with 1:
step1: delete date data from the table
setp2 use this command:
    dbcc checkident ('schema_name.table.name', reseed, 0)
 */
 delete from HumanResources.EmployeeData;
dbcc checkident ('HumanResources.EmployeeData', reseed, 0);

-- increase John's salary -employee id=1
update HumanResources.EmployeeData
set salary=47000
where employeeid=1;
go

update HumanResources.EmployeeData
set salary=50000
where employeeid=1;
go

-- Union Join
/* retrun customer info and supplier info */
select c.CompanyName, c.Address, c.City, c.Region, c.Country, 'Customer' as 'Type'
from Sales.Customers c
union
select s.CompanyName, s.Address, s.City, s.Region, s.Country, 'Supplier' as 'Type'
from Production.Suppliers s;


select * from HumanResources.EmployeeData;

select * from HumanResources.AuditEmployeeData;