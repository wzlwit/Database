/* partition tables with data in the flix(dvdrentals) database
Script date: February 18, 2019
*/
use YMFlix
;

show variables like 'secure_file_priv'
;

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Participant_Roles.csv'
into table Roles
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;

/* DO NOT EXECUTE - Data will be loaded fron external csv file */
/* Inserts into the Roles table */
INSERT INTO Roles ( RoleID, RoleDescrip)
VALUES ('r101', 'Actor'),
('r102', 'Director'),
('r103', 'Producer'),
('r104', 'Executive Producer'),
('r105', 'Co-Producer'),
('r106', 'Assistant Producer'),
('r107', 'Screenwriter'),
('r108', 'Composer');

select *
from roles
;

/* Inserts into the MovieTypes table */
INSERT INTO MovieTypes (MTypeID, MTypeDescrip)
VALUES ('mt10', 'Action'),
('mt11', 'Drama'),
('mt12', 'Comedy'),
('mt13', 'Romantic Comedy'),
('mt14', 'Science Fiction/Fantasy'),
('mt15', 'Documentary'),
('mt16', 'Musical');

select *
from movietypes
;

/* Inserts into the Studios table */
INSERT INTO Studios 
VALUES ('s101', 'Universal Studios'),
('s102', 'Warner Brothers'),
('s103', 'Time Warner'),
('s104', 'Columbia Pictures'),
('s105', 'Paramount Pictures'),
('s106', 'Twentieth Century Fox'),
('s107', 'Merchant Ivory Production');

select *
from studios
;

/* Inserts into the Ratings table */
INSERT INTO Ratings (RatingID, RatingDescrip)
VALUES ('NR', 'Not rated'),
('G', 'General audiences'),
('PG', 'Parental guidance suggested'),
('PG13', 'Parents strongly cautioned'),
('R', 'Under 17 requires adult'),
('X', 'No one 17 and under')
;

select *
from Ratings
;


/* Inserts into the Formats table */
INSERT INTO Formats (FormID, FormDescrip)
VALUES ('f1', 'Widescreen'),
('f2', 'Fullscreen')
;

/* Inserts into the Status table */
INSERT INTO Status (StatID , StatDescrip)
VALUES ('s1', 'Checked out'),
('s2', 'Available'),
('s3', 'Damaged'),
('s4', 'Lost')
;


/* Inserts into the Particpants table */
INSERT INTO Participants (PartFN, PartMN, PartLN)
VALUES ('Sydney', NULL, 'Pollack'),
('Robert', NULL, 'Redford'),
('Meryl', NULL, 'Streep'),
('John', NULL, 'Barry'),
('Henry', NULL, 'Buck'),
('Humphrey', NULL, 'Bogart'),
('Danny', NULL, 'Kaye'),
('Rosemary', NULL, 'Clooney'),
('Irving', NULL, 'Berlin'),
('Michael', NULL, 'Curtiz'),
('Bing', NULL, 'Crosby');

select *
from Participants
;

/* Inserts into the Employees table */
INSERT INTO Employees (EmpFN, EmpMN, EmpLN)
VALUES ('John', 'P.', 'Smith'),
('Robert', NULL, 'Schroader'),
('Mary', 'Marie', 'Michaels'),
('John', NULL, 'Laguci'),
('Rita', 'C.', 'Carter'),
('George', NULL, 'Brooks')
;
select *
from Employees
;

delete 
from Employees where empid>6
;

/* Inserts into the Customers table */
INSERT INTO Customers (CustFN, CustMN, CustLN)
VALUES ('Ralph', 'Frederick', 'Johnson'),
('Hubert', 'T.', 'Weatherby'),
('Anne', NULL, 'Thomas'),
('Mona', 'J.', 'Cavenaugh'),
('Peter', NULL, 'Taylor'),
('Ginger', 'Meagan', 'Delaney')
;

select *
from Customers
;

delete 
from Customers where custid>6
;

/* Inserts into the DVDs table */
INSERT INTO DVDs (DVDName, NumDisks, YearRlsd, MTypeID, StudID, RatingID, FormID, StatID)
VALUES ('White Christmas', 1, 2000, 'mt16', 's105', 'NR', 'f1', 's1'),
('What\'s Up, Doc?', 1, 2001, 'mt12', 's103', 'G', 'f1', 's2'),
('Out of Africa', 1, 2000, 'mt11', 's101', 'PG', 'f1', 's1'),
('The Maltese Falcon', 1, 2000, 'mt11', 's103', 'NR', 'f1', 's2'),
('Amadeus', 1, 1997, 'mt11', 's103', 'PG', 'f1', 's2'),
('The Rocky Horror Picture Show', 2, 2000, 'mt12', 's106', 'NR', 'f1', 's2'),
('A Room with a View', 1, 2000, 'mt11', 's107', 'NR', 'f1', 's1'),
('Mash', 2, 2001, 'mt12', 's106', 'R', 'f1', 's2')
;
/*
select * 
from dvds
;

delete 
from DVDs
;

alter table DVDs
	auto_increment = 1
;
*/

/* Inserts into the DVDParticipant table */
INSERT INTO DVDParticipants
VALUES (3, 1, 'r102'),
(3, 4, 'r108'),
(3, 1, 'r103'),
(3, 2, 'r101'),
(3, 3, 'r101'),
(4, 6, 'r101'),
(1, 8, 'r101'),
(1, 9, 'r108'),
(1, 10, 'r102'),
(1, 11, 'r101'),
(1, 7, 'r101'),
(2, 5, 'r107');

/* Inserts into the Orders table */
INSERT INTO Orders (CustID, EmpID)
VALUES (1, 3),
(1, 2),
(2, 5),
(3, 6),
(4, 1),
(3, 3),
(5, 2),
(6, 4),
(4, 5),
(6, 2),
(3, 1),
(1, 6),
(5, 4);

/* Inserts into the Transactions table */
INSERT INTO Transactions (OrderID, DVDID, DateOut, DateDue)
VALUES (1, 1, CURDATE(), CURDATE()+3),
(1, 4, CURDATE(), CURDATE()+3),
(1, 8, CURDATE(), CURDATE()+3),
(2, 3, CURDATE(), CURDATE()+3),
(3, 4, CURDATE(), CURDATE()+3),
(3, 1, CURDATE(), CURDATE()+3),
(3, 7, CURDATE(), CURDATE()+3),
(4, 4, CURDATE(), CURDATE()+3),
(5, 3, CURDATE(), CURDATE()+3),
(6, 2, CURDATE(), CURDATE()+3),
(6, 1, CURDATE(), CURDATE()+3),
(7, 4, CURDATE(), CURDATE()+3),
(8, 2, CURDATE(), CURDATE()+3),
(8, 1, CURDATE(), CURDATE()+3),
(8, 3, CURDATE(), CURDATE()+3),
(9, 7, CURDATE(), CURDATE()+3),
(9, 1, CURDATE(), CURDATE()+3),
(10, 5, CURDATE(), CURDATE()+3),
(11, 6, CURDATE(), CURDATE()+3),
(11, 2, CURDATE(), CURDATE()+3),
(11, 8, CURDATE(), CURDATE()+3),
(12, 5, CURDATE(), CURDATE()+3),
(13, 7, CURDATE(), CURDATE()+3);

