-- switch to ContosoDW

USE ContosoDWWZL;

-- CREATE the HumanResources shema
CREATE SCHEMA HumanResources AUTHORIZATION dbo;
GO

/* Create HumanResources.Employees Table */
DROP TABLE HumanResources.Employees;

CREATE TABLE HumanResources.Employees (
    EmployeeID INT NOT NULL,
    LastName NVARCHAR(15) NOT NULL,
    FistName NVARCHAR(15) NOT NULL,
    JobTitle NVARCHAR(60) NOT NULL,
    HoursWorked INT NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY CLUSTERED(EmployeeID ASC)
)
;
GO

ALTER TABLE HumanResources.Employees
ADD FULLName NVARCHAR(120) NULL;
GO

-- add ModifiedDate column
ALTER TABLE HumanResources.Employees
ADD ModifiedDate datetime NULL;
GO

ALTER TABLE HumanResources.Employees
ADD CONSTRAINT df_ModifiedDate_Employees DEFAULT getdate() FOR ModifiedDate
;
GO

DELETE FROM HumanResources.Employees;

SELECT * FROM HumanResources.Employees;