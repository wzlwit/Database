@'D:\Session I\Database\Lab4\registration.sql'

--Update multiple fields with substitution variable &
insert into faculty (f_id, f_last) values(&f_id, '&f_last');
update faculty set f_first='&f_first', birthday='&birthday', soc_ins='&soc_ins' where f_id = &f_id;

Enter value for f_id: 6
Enter value for f_last: Bennet
old   1: insert into faculty (f_id, f_last) values(&f_id, '&f_last')
new   1: insert into faculty (f_id, f_last) values(6, 'Bennet')

1 row created.

Enter value for f_first: Rock
Enter value for birthday: 13-Jun-83
Enter value for soc_ins: 222-333-444
Enter value for f_id: 6
old   1: update faculty set f_first='&f_first', birthday='&birthday', soc_ins='&soc_ins' where f_id = &f_id
new   1: update faculty set f_first='Rock', birthday='13-Jun-83', soc_ins='222-333-444' where f_id = 6

      F_ID F_LAST          F_FIRST         BIRTHDAY  SOC_INS
---------- --------------- --------------- --------- -----------
         1 Robertson       Myra            30-JUL-40 123-456-789
         2 Smith           Neal            12-MAY-50 321-456-789
         3 Arlec           Lisa            24-MAR-41 123-554-789
         4 Fillipo         Paul            11-JUL-71 123-456-987
         5 Denver          Paul            09-JUL-80 123-654-987
         6 Bennet          Rock            13-JUN-83 222-333-444
		 

--search using & in SELECT
select * from faculty where f_last = '&faculty_last';
Enter value for faculty_last: Fillipo
old   1: select * from faculty where f_last = '&faculty_last'
new   1: select * from faculty where f_last = 'Fillipo'

      F_ID F_LAST          F_FIRST         BIRTHDAY  SOC_INS
---------- --------------- --------------- --------- -----------
         4 Fillipo         Paul            11-JUL-71 123-456-987



--update using CASE structure
update course set max_enrl = case
	WHEN course_no='MIS 101' Then max_enrl*2
    WHEN course_no='MIS 301' THEN max_enrl*1.5
    when course_no='MIS 441' then max_enrl*3
    else max_enrl
    end;

7 rows updated.

select * from course;

COURSE_ COURSE_NAME                  CREDITS   MAX_ENRL
------- ------------------------- ---------- ----------
CS 155  Programming in C++                 3         90
MIS 101 Intro. To Info. Systems            3        280
MIS 301 Systems Analysis                   3         53
MIS 441 Database Management                3         36
MIS 451 Web-Based Systems                  3         30
MIS 551 Advanced Web                       3         30
MIS 651 Advanced Java                      3         30

7 rows selected.		 
		 		 
--function UPPER, LOWER, INITCAP				 
select upper(f_last), lower(f_first) from faculty;

UPPER(F_LAST)   LOWER(F_FIRST)
--------------- ---------------
ROBERTSON       myra
SMITH           neal
ARLEC           lisa
FILLIPO         paul
DENVER          paul
BENNET          rock

6 rows selected.


select course_no, upper(course_name) from course;

COURSE_ UPPER(COURSE_NAME)
------- -------------------------
CS 155  PROGRAMMING IN C++
MIS 101 INTRO. TO INFO. SYSTEMS
MIS 301 SYSTEMS ANALYSIS
MIS 441 DATABASE MANAGEMENT
MIS 451 WEB-BASED SYSTEMS
MIS 551 ADVANCED WEB
MIS 651 ADVANCED JAVA

7 rows selected.


--length
select f_last, f_first, f_id from faculty order by length (f_last);

F_LAST          F_FIRST               F_ID
--------------- --------------- ----------
Arlec           Lisa                     3
Smith           Neal                     2
Bennet          Rock                     8
Denver          Paul                     5
Fillipo         Paul                     4
Robertson       Myra                     1

6 rows selected.


select course_no, instr(course_no, 'S'), substr(course_no, 1, instr(course_no, ' ')-1), substr(course_no, instr(course_no, ' ')) from course;

COURSE_ INSTR(COURSE_NO,'S') SUBSTR(COURSE_NO,1,INSTR(COU SUBSTR(COURSE_NO,INSTR(COURS
------- -------------------- ---------------------------- ----------------------------
CS 155                     2 CS                            155
MIS 101                    3 MIS                           101
MIS 301                    3 MIS                           301
MIS 441                    3 MIS                           441
MIS 451                    3 MIS                           451
MIS 551                    3 MIS                           551
MIS 651                    3 MIS                           651

7 rows selected.


--table system DUAL
select instr('vanier', 'n'), length('college') from dual;

INSTR('VANIER','N') LENGTH('COLLEGE')
------------------- -----------------
                  3                 7
				  
--
	

select min(max_enrl), max(max_enrl), sum(max_enrl) from course;

MIN(MAX_ENRL) MAX(MAX_ENRL) SUM(MAX_ENRL)
------------- ------------- -------------
           12           140           367


select round (29.334) from dual;		   
 
ROUND(29.334)
-------------
           29

		   

		   --to_char()	, used for DATE type, or mod price as currency or accounting	   
select to_char (BIRTHDAY, 'DY, Month dd, yyyy hh:mm:ss p.m.') from faculty;

TO_CHAR(BIRTHDAY,'DY,MONTHDD,YYYYHH:MM:SSP.M.')
-------------------------------------------------------------------------
MON, July      30, 2040 12:07:00 a.m.
FRI, May       12, 1950 12:05:00 a.m.
SUN, March     24, 2041 12:03:00 a.m.
SUN, July      11, 1971 12:07:00 a.m.
WED, July      09, 1980 12:07:00 a.m.
THU, June      23, 1983 12:06:00 a.m.

6 rows selected.		   


select power(4,2) from dual;

POWER(4,2)
----------
        16

		
select sysdate from dual;

SYSDATE
---------
22-JUN-18


--show a date some months later as a due day or special day to give bonus.
 select f_last, ADD_MONTHS(birthday, 12) from faculty;

F_LAST          ADD_MONTH
--------------- ---------
Robertson       30-JUL-41
Smith           12-MAY-51
Arlec           24-MAR-42
Fillipo         11-JUL-72
Denver          09-JUL-81

select f_last, ADD_MONTHS(birthday, 12)"3M later" from faculty;

F_LAST          3M later
--------------- ---------
Robertson       30-JUL-41
Smith           12-MAY-51
Arlec           24-MAR-42
Fillipo         11-JUL-72
Denver          09-JUL-81

--upper apply to a column, cannot used for just a part, so be outside TO_CHAR();
select S_ID, upper(s_last) "Student Last", upper(to_char (BIRTHDAY, 'DY, Month dd, yyyy hh:mm:ss p.m.'))"Birthday Format" from student;

      S_ID Student Last    Birthday Format
---------- --------------- -------------------------------------------------------------------------
         1 GRAHAM          WED, JULY      30, 1980 12:07:00 A.M.
         2 SANCHEZ         TUE, MAY       12, 1981 12:05:00 A.M.
         3 WHITE           TUE, MARCH     24, 1987 12:03:00 A.M.
         4 PHELP           THU, FEBRUARY  11, 1988 12:02:00 A.M.
         5 LEWIS           FRI, OCTOBER   09, 1970 12:10:00 A.M.
         6 JAMES           WED, DECEMBER  07, 1960 12:12:00 A.M.

6 rows selected.


select Course_No, Course_Name, Max_Enrl, DECODE (Max_Enrl, 140, ' Extra Large Class', 90, ' Large Class', 30, ' Medium Class', 35, ' Unique Class',' Small') "Class Desc" from course;

COURSE_ COURSE_NAME                 MAX_ENRL Class Desc
------- ------------------------- ---------- ------------------
CS 155  Programming in C++                90  Large Class
MIS 101 Intro. To Info. Systems          140  Extra Large Class
MIS 301 Systems Analysis                  35  Unique Class
MIS 441 Database Management               12  Small
MIS 451 Web-Based Systems                 30  Medium Class
MIS 551 Advanced Web                      30  Medium Class
MIS 651 Advanced Java                     30  Medium Class

7 rows selected.

select Course_No, Course_Name, Max_Enrl, DECODE (Max_Enrl - 30, 110, ' Extra Large Class', 60, ' Large Class', 0, ' Medium Class', 5, ' Unique Class',' Small') "Class Desc" from course;
--can be used for numeric operation, but not for BOOLEAN.
select Course_No, Course_Name, Max_Enrl, DECODE (Course_no, CS 155, 'good', MIS 101, 'good', 'not') from course;


select Course_No, Course_Name, Max_Enrl, DECODE (Course_no, 'CS 155', 'good', 'MIS 101', 'good', 'not') from course;

COURSE_ COURSE_NAME                 MAX_ENRL DECO
------- ------------------------- ---------- ----
CS 155  Programming in C++                90 not
MIS 101 Intro. To Info. Systems          140 good
MIS 301 Systems Analysis                  35 not
MIS 441 Database Management               12 not
MIS 451 Web-Based Systems                 30 not
MIS 551 Advanced Web                      30 not
MIS 651 Advanced Java                     30 not
select round(25.465,2) from dual;



ROUND(25.465,2)
---------------
          25.47

select trunc(25.465,0) from dual;

TRUNC(25.465,0)
---------------
             25

select trunc(25.465,-1) from dual;

TRUNC(25.465,-1)
----------------
              20


--change format (accounting)			  
select to_char(Max_enrl, '$999.99') from course;

TO_CHAR(
--------
  $90.00
 $140.00
  $35.00
  $12.00
  $30.00
  $30.00
  $30.00

7 rows selected.

select count(*) "number of course" from course;

number of course
----------------
               7


select grade from enrollment group by grade order by grade asc;

GRADE
-----
A+
A-
B+
B-
C+


			   