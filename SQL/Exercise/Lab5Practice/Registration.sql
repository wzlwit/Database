--@'D:\Session I\Database\Lab5Practice\registration.sql'
set pagesize 32767	
--no ; at the end, it is not universal SQL command
set linesize 32767

--alter session set NLS_DATE_FORMAT = 'DD-MM-YYYY';


drop table department cascade constraints;
create table department (DeptID number(2),DeptName varchar2(20),Location varchar2(10),
constraint dept_pk primary key (DeptID));
insert into department values(10,'Computer Science','Campus CS');
insert into department values(20,'Telecommunication','Campus TEL');
insert into department values(30,'Accounting','Campus AC');
insert into department values(40,'Math '|| '&' || ' Science','Campus MS');
insert into department values(50,'Liberal Arts','Campus LA');
--or chr(38) to replace '&'

drop table faculty cascade constraints;
CREATE TABLE faculty
(f_id NUMBER(5),f_last VarChar2(15) constraint faculty_f_last_nn not null
,f_first VarChar2(15), 
constraint faculty_f_id_pk primary key (f_id));

insert into faculty values
(1,'Robertson','Myra');
insert into faculty values
(2,'Smith','Neal');
insert into faculty values
(3,'Arlec','Lisa');
insert into faculty values
(4,'Fillipo','Paul');
insert into faculty values
(5,'Denver','Paul');

drop table student cascade constraints;
create table student
(s_id number(2),s_last varchar2(10),s_first varchar2(10),s_class char(2),f_id number(5),
constraint student_s_id_pk primary key (s_id),
constraint student_fk foreign key (f_id) references faculty(f_id));

insert into student values (1,'Graham','Bill','JR',4);
insert into student values (2,'Sanchez','Jim','EX',3);
insert into student values (3,'White','Peter','EX',3);
insert into student values (4,'Phelp','David','JR',1);
insert into student values (5,'Lewis','Sheila','SR',2);
insert into student values (6,'James','Thomas','JR',1);

drop table course cascade constraints;
create table course
(course_no varchar2(7),course_name varchar2(25),credits number(2),max_enrl number(5),
constraint course_course_no_pk primary key (course_no));
insert into course values ('CS 155','Programming in C++',3,90);
insert into course values ('MIS 101','Intro. To Info. Systems',3,140);
insert into course values ('MIS 301','Systems Analysis',3,35);
insert into course values ('MIS 441','Database Management',3,12);
insert into course values ('MIS 451','Web-Based Systems',3,30);
insert into course values ('MIS 551','Advanced Web',3,30);
insert into course values ('MIS 651','Advanced Java',3,30);





drop table enrollment cascade constraints;
create table enrollment
(s_id number(4),course_no varchar2(7),grade char(5),
constraint enrollment_pk primary key(s_id,course_no),
constraint enrollment_s_id_fk foreign key (s_id) references student(s_id),
constraint enrollment_course_no_fk foreign key (course_no) references course(course_no)); 

insert into enrollment values (1,'MIS 101','A+');
insert into enrollment values (2,'MIS 441','A-');
insert into enrollment values (2,'MIS 451','A+');
insert into enrollment values (3,'CS 155','B-');
insert into enrollment values (3,'MIS 301','B-');
insert into enrollment values (3,'MIS 651','C+');
insert into enrollment values (4,'CS 155','B-');
insert into enrollment values (4,'MIS 441','A-');
insert into enrollment values (4,'MIS 551','B+');
insert into enrollment values (5,'MIS 301','B-');
insert into enrollment values (5,'MIS 451','A+');
insert into enrollment values (6,'MIS 551','B+');
insert into enrollment values (6,'MIS 651','C+');




alter table faculty add birthday date;
alter table faculty add soc_ins char(11);
update faculty set birthday='30-jul-1940' where f_id = 1;
update faculty set birthday='12-may-1950' where f_id = 2;
update faculty set birthday='24-mar-1941' where f_id = 3;
update faculty set birthday='11-feb-1971' where f_id = 4;
update faculty set birthday='09-oct-1980' where f_id = 5;
update faculty set soc_ins='123-456-789' where f_id = 1;
update faculty set soc_ins='321-456-789' where f_id = 2;
update faculty set soc_ins='123-554-789' where f_id = 3;
update faculty set soc_ins='123-456-987' where f_id = 4;
update faculty set soc_ins='123-654-987' where f_id = 5;

alter table faculty add DeptID number(2);
alter table faculty add constraint faculty_fk foreign key (DeptID) references department(DeptID);
update faculty set DeptID=decode(f_id,1,10,2,20,3,30,4,10,5,40);

alter table student add birthday date;
alter table student add soc_ins char(11);
update student set birthday='30-jul-1980' where s_id = 1;
update student set birthday='12-may-1981' where s_id = 2;
update student set birthday='24-mar-1987' where s_id = 3;
update student set birthday='11-feb-1988' where s_id = 4;
update student set birthday='09-oct-1970' where s_id = 5;
update student set birthday='07-dec-1960' where s_id = 6;
update student set soc_ins='456-123-789' where s_id = 1;
update student set soc_ins='654-123-789' where s_id = 2;
update student set soc_ins='456-321-789' where s_id = 3;
update student set soc_ins='456-123-987' where s_id = 4;
update student set soc_ins='456-321-987' where s_id = 5;
update student set soc_ins='654-321-987' where s_id = 6;

drop table levelclass cascade constraint;
create table levelclass
(lc_type number(2),lc_desc varchar2(20),lc_min number(3),lc_max number(3),
constraint leveclass_lc_type_pk primary key (lc_type));
insert into levelclass values (1,'Small Class',1,12);
insert into levelclass values (2,'Medium Class',13,30);
insert into levelclass values (3,'Large Class',31,90);
insert into levelclass values (4,'Extra Large Class',91,140);

alter table course add prereq varchar2(7);
update course set prereq = decode (course_no,
'CS 155','MIS 101',
'MIS 301','MIS 651',
'MIS 441','MIS 301',
'MIS 451','MIS 101',
'MIS 551', 'MIS 451',
'MIS 651','MIS 101');
--update course set prereq = 'MIS 101' where course_no = 'CS 155'; 
--decode ( , 'CS 155 ', 'MIS 101'), with a space, otherwise it will not work


drop table worker cascade constraints;
create table worker (w_id number(2), w_last varchar2(10),w_first varchar2(10),
constraint worker_pk primary key (w_id));
insert into worker values (1,'Graham','Bill');
insert into worker values (2,'Craig','Daniel');
insert into worker values (3,'White','Peter');
insert into worker values (4,'Depp','Johnny');
insert into worker values (5,'Shell','Amanda');


drop table categorystudent cascade constraint;
create table categorystudent (CatStudID number(2),CatStartDate date, CatEndDate date, CatStudDESC varchar2(20),
constraint categorystudent_PK primary key (CatStudID));
insert into categorystudent values(1,'01-Jan-1960','31-Dec-1969','Generation X1');
insert into categorystudent values(2,'01-Jan-1970','31-Dec-1979','Generation X');
insert into categorystudent values(3,'01-Jan-1980','31-Dec-1989','Generation Y');

select TABLE_NAME from user_tables;
--select f_id, f_last from faculty;
--select s_id, s_class from student;
select * from faculty;
select * from student;
select * from course;
select * from enrollment;
select * from levelclass;
select * from worker;
select * from department;
select * from categorystudent;


inner join film_actor using(actor_id);