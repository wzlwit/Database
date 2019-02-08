--@'D:\Session I\Database\Lab2\Registration'
--@'D:\Session I\Database\lab3\lab3command.sql'

set linesize 120
describe student --

alter table student ADD socialsecurity char(9);
--add new column
--alter table student DROP COLUMN socialsecurity;

--DESC
describe student;

update student set socialsecurity='33-82-97' where s_id=1;
update student set socialsecurity='12-33-45' where s_id=2;
update student set socialsecurity='45-12-78' where s_id=3;
update student set socialsecurity='67-89-01' where s_id=4;
update student set socialsecurity='23-45-67' where s_id=5;
update student set socialsecurity='89-01-23' where s_id=6;

drop table enrollment;
delete from student where s_id=5;

select * from student;

select f_first from faculty;
select distinct f_first from faculty;

select f_last "faculty_last", f_first "faculty_first" from  faculty;

select f_last || f_first from  faculty;
select f_last || ' ' || f_first  "Faculty Name"from faculty;

select f_last "faculty_last", f_first"faculty_first" from faculty where f_id=4;
select f_last "faculty_last", f_first"faculty_first" from faculty where f_id>=2 and f_id<=4;
select f_id "faculty ID", f_last "faculty_last", f_first"faculty_first" from faculty
where f_id between 2 and 4;
select f_id "faculty ID", f_last "faculty_last", f_first"faculty_first" from faculty

where f_id in (2,4,6);
select f_id "faculty ID", f_last "faculty_last", f_first"faculty_first" from faculty
where f_id not in (2,4,6); -- =in (1,3,5)

select f_id, f_last, f_first from faculty
where f_first like 'P%'; 
select f_id, f_last, f_first from faculty
where f_first like '%a%';
select f_id, f_last, f_first from faculty
where f_first like '_a%';

select f_id, f_last, f_first from faculty
order by f_first desc;
select f_id, f_last, f_first from faculty
order by f_first asc;


-- and or not !=
-- between ... and ... (values inclued)

-- query course records where max_enrl is between 30 and 90
select course_no, course_name, max_enrl from course where max_enrl between 30 and 90;

COURSE_ COURSE_NAME                      MAX_ENRL
------- ------------------------------ ----------
CS 155  Programming in C++                     90
MIS 301 Systems Analysis                       35
MIS 451 Web-Based Systems                      30
MIS 551 Advanced Web                           30
MIS 651 Advanced Java                          30

--query records using <= and >=
select course_name, course_no, max_enrl from course where max_enrl>= 30 and max_enrl <= 90;

COURSE_NAME                    COURSE_   MAX_ENRL
------------------------------ ------- ----------
Programming in C++             CS 155          90
Systems Analysis               MIS 301         35
Web-Based Systems              MIS 451         30
Advanced Web                   MIS 551         30
Advanced Java                  MIS 651         30

select course_name, course_no, max_enrl, credits from course where course_name like '%_dvanced%';
--display all advaned courses using operator LIKE and search pattern %.
COURSE_ COURSE_NAME                       CREDITS
------- ------------------------------ ----------
MIS 551 Advanced Web                            3
MIS 651 Advanced Java                           3

--display students of A+ using WHERE clause and operator =
select s_id, course_no, grade from enrollment where grade='A+'; --no space between grade and '='

      S_ID COURSE_ GRADE
---------- ------- -----
         1 MIS 101 A+
         2 MIS 451 A+
         5 MIS 451 A+
		 
		 
		 
select s_id, course_no, grade from enrollment where grade IN('A+','B+');
select s_id, course_no, grade from enrollment where grade='A+' or grade='B+';

      S_ID COURSE_ GRADE
---------- ------- -----
         1 MIS 101 A+
         2 MIS 451 A+
         4 MIS 551 B+
         5 MIS 301 B+
         5 MIS 451 A+
         6 MIS 551 B+

--display all students with A-, B-, C+ by order of student ID (ascending)
select s_id, course_no, grade from enrollment where grade IN('A-','B-','C+') order by s_id asc;
-- ORDER clause must be after WHERE Clause

      S_ID COURSE_ GRADE
---------- ------- -----
         2 MIS 441 A-
         3 MIS 301 B-
         3 CS 155  B-
         3 MIS 651 C+
         4 CS 155  B-
         4 MIS 441 A-
         6 MIS 651 C+
		 
--Display all student  (s_last, s_first) in one column (alias) and s_class in another field,
--where student are registered as Expert(EX)
select s_last || ' ' || s_first "Student Name", s_class "ST" from student where s_class='EX';
select s_last||' '||s_first "Student Name", s_class "ST" from student where s_class='EX';	

Student Name                                                  ST
------------------------------------------------------------- --
Sanchez Jim                                                   EX
White Peter                                                   EX

