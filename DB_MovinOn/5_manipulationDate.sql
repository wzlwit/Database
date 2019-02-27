
/*   
	create views(queries) for MovinOn database
	script Date: Feb/19/2019
*/


/*	
	Switch to MovinOn database
*/
use Movinon;




/*
    1_4AxleDrivers
    
    Select all drivers with rating A or B
*/

CREATE VIEW view_1_4AxleDrivers AS
    SELECT 
        D.DriverID AS 'Employee ID',
        CONCAT_WS(' ', D.DriverFirst, ', ', D.Driverlast) AS 'Driver Name',
        D.startdate AS 'Start Date',
        D.phone AS 'Phone',
        D.DrivingRecord AS 'Rating'
    FROM
        drivers AS D
    WHERE
        D.DrivingRecord IN ('a' , 'b')
    ORDER BY D.DrivingRecord
; 

SELECT 
    *
FROM
    view_1_4AxleDrivers;

/*

    2_DriversWithLowRecords
    
     Select All drivers with rating C or E or F
     
     Rating C: Notice
     
     Rating D or F : Terminate immediately
    
*/

CREATE VIEW view_2_DriversWithLowRecords AS
    SELECT 
        D.DriverID AS 'Employee ID',
        CONCAT_WS(' ', D.DriverFirst, ', ', D.Driverlast) AS 'Driver Name',
        D.startdate AS 'Starting Date',
        D.phone AS 'Phone',
        D.DrivingRecord AS 'Rating',
        CASE D.DrivingRecord
            WHEN 'D' THEN 'Terminate Immediately'
            WHEN 'c' THEN 'Notice'
            WHEN 'f' THEN 'Terminate Immediately'
        END AS 'Comments'
    FROM
        drivers AS D
    WHERE
        D.DrivingRecord IN ('c' , 'd', 'f')
            AND D.EndDate IS NULL
    ORDER BY D.DrivingRecord DESC
;

SELECT 
    *
FROM
    view_2_DriversWithLowRecords;


/*
	3_DriversForTermination
	
	list all relevant employment information about drivers
	 
	who are to be terminated because of their driving record
*/

CREATE VIEW view_3_DriversForTermination AS
    SELECT 
        D.DriverID AS 'Employee ID',
        CONCAT_WS(' ', D.DriverFirst, ', ', D.Driverlast) AS 'Driver Name',
        D.DOB AS 'Date of birth',
        D.startdate AS 'Starting Date',
        CONCAT_WS (' ',
                D.Address,
                ', ',
                D.City,
                D.State,
                D.Zip) AS 'Full Adress',
        D.phone AS 'Phone',
        D.cell AS 'Cellphone',
        D.DrivingRecord AS 'Rating',
        CASE D.DrivingRecord
            WHEN 'D' THEN 'Terminated Immediately'
            WHEN 'f' THEN 'Terminated Immediately'
        END AS 'Comments'
    FROM
        drivers AS D
    WHERE
        D.DrivingRecord IN ('d' , 'f')
            AND D.EndDate IS NULL
    ORDER BY D.DrivingRecord DESC;

SELECT 
    *
FROM
    view_3_DriversForTermination;



/*
	4_EmployeeStatesProvinces
	In what states or provinces do the employees reside?
*/
CREATE VIEW view_4_EmployeeStatesProvinces AS
    SELECT 
        CONCAT (E.empfirst, ' ', E.emplast) AS 'employee name',
        E.State AS 'province'
    FROM
        employees AS E
    ORDER BY 'province'
;

SELECT 
    *
FROM
    view_4_EmployeeStatesProvinces;
 

/* 
	5_EmployeesPerCity 
	How many employees in each city
*/

CREATE VIEW view_5_EmployeesPerCity AS
    SELECT 
        COUNT(*) AS 'Number of Employees', E.city AS 'City'
    FROM
        employees AS E
    GROUP BY E.city
    ORDER BY COUNT(*)
;

SELECT 
    *
FROM
    view_5_EmployeesPerCity;


/*
	6_SalariedEmployees 
    Who makes the highest salary
*/

CREATE VIEW view_6_SalariedEmployees AS
    SELECT 
        CONCAT(E.empfirst, ' ', E.emplast) AS 'employee name',
        MAX(E.Salary) AS 'highest salary'
    FROM
        employees AS E
    WHERE
        e.Salary IS NOT NULL
;

SELECT 
    *
FROM
    view_6_SalariedEmployees;



/* 
 7_EmployeeLowWage  
 Who is paid the lowest hourly rate 
*/
CREATE VIEW view_7_EmployeeLowWage AS
    SELECT 
        CONCAT (E.empfirst, ' ', E.emplast) AS 'employee name',
        MIN(E.HourlyRate) AS 'lowest hourly rate'
    FROM
        employees AS E
    WHERE
        E.HourlyRate IS NOT NULL
;
 
 select * from view_7_EmployeeLowWage ;
 
 
 
/* 
 8_JobPositions 
 How many types of jobs are offered at MonivOn
*/

CREATE VIEW view_8_JobPositions AS
    SELECT 
        COUNT(DISTINCT E.PositionID) AS 'positions'
    FROM
        employees AS E
;

SELECT 
    *
FROM
    view_8_JobPositions;
 
 
 /* 
	9_JobsPerPosition 
	How many people are employed in each type of job
 */

CREATE VIEW view_9_JobsPerPosition AS
    SELECT 
        COUNT(*) AS 'Number of Employees', p.Title AS 'position'
    FROM
        employees AS E
            INNER JOIN
        positions AS P ON E.PositionID = p.PositionID
    GROUP BY E.PositionID
    ORDER BY COUNT(*) DESC
;

SELECT 
    *
FROM
    view_9_JobsPerPosition
;



/*
10_Payroll. 
 list all relevant employment information about emoloyees
*/

CREATE VIEW view_10_Payroll AS
    SELECT 
        e.EmpID AS 'Employee ID',
        CONCAT_WS (' ', E.EmpFirst, E.EmpLast) AS 'Employee Name',
        e.SSN AS 'Social Security Numbers',
        round (e.Salary / 12, 2) AS 'Monthly Wage',
        -- truncat (e.Salary / 12, 2) AS 'Monthly Wage',
        e.HourlyRate AS 'Hourly Rate'
    FROM
        employees AS E
    ORDER BY e.Salary desc ;

SELECT 
    *
FROM
    view_10_Payroll;


/*
	11_EmployeeContactByWarehouse.  
*/

CREATE VIEW view_11_EmployeeContactByWarehouse AS
    SELECT 
        e.WarehouseID AS `Warehouse ID`,
        w.Phone AS `Warehouse phone`,
        p.Title AS `Position`,
        CONCAT_WS(' ', E.EmpLast, E.EmpFirst) AS `Full name`,
        e.Cell AS `Cellphone`
    FROM
        employees AS E
            INNER JOIN
        warehouses AS W ON e.WarehouseID = w.WarehouseID
            INNER JOIN
        positions AS P ON e.PositionID = p.PositionID
    ORDER BY `Warehouse ID`;
 ;
 
select * from  view_11_EmployeeContactByWarehouse ;

/*
12_EmployeeLongevity. 
  Create an employee list that calculates the number of years each employee has worked for MovinOn.
  Organize the list by job title within each warehouse
*/
CREATE VIEW view_12_EmployeeLongevity AS
    SELECT 
        CONCAT_WS(' ', E.EmpFirst, E.EmpLast) AS `Employee Name`,
        p.Title AS 'position',
        e.WarehouseID AS 'warehouse',
        YEAR(LOCALTIME()) - YEAR(e.StartDate) AS `Number Of Service Years`
    FROM
        employees AS E
            INNER JOIN
        positions AS P ON E.PositionID = p.PositionID
    ORDER BY `Number Of Service Years` DESC;
  
SELECT 
    *
FROM
    view_12_EmployeeLongevity;
 
 
 /*
	13_OregonRateIncrease. 
	Create an employee list that calculates the number of years each employee has worked for MovinOn.
	Organize the list by job title within each warehouse
*/
CREATE VIEW view_13_OregonRateIncrease AS
    SELECT 
        e.EmpID AS `Employee ID`,
        CONCAT_WS(' ', E.EmpFirst, E.EmpLast) AS `Employee Name`,
        e.HourlyRate AS `old rate`,
        round (e.HourlyRate * 1.10, 2) AS `new rate`
    FROM
        employees AS E
    WHERE
        e.HourlyRate IS NOT NULL;

SELECT 
    *
FROM
    view_13_OregonRateIncrease;