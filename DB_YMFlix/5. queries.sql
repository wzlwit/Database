/*Manipulating the flix (DVDRENTALS) Database
 script date: February 19, 2019
*/

-- switch to ymdatabase
use ymflix
;

/* to answer any question about yout data, follow these steps:
1. read the questions
2. determin objects
3. column
4. run
5. define criteria, and run
*/

/* list all dvd id, name, and year released */
select DVDID, DVDName, YearRlsd
from dvds
;

/* 2. list all dvd id, name released in 2001*/
select DVDID, DVDName
from dvds
where YearRlsd = '2001'
;

/*
select *
from customers
where city like 'montreal'
order by
group by
;
*/

/* 3. list all dvd id, names that have more than one disk*/
select DVDID, DVDName
from dvds
where NumDisks > 1
;

