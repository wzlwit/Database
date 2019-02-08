--@'D:\Session I\Database\Lab5Command\registration.sql'
set pagesize 32767	
--no ; at the end, it is not universal SQL command
set linesize 32767

drop table faculty cascade constraints;
drop table student cascade constraints;
drop table course cascade constraints;
drop table enrollment cascade constraints;
drop table levelclass cascade constraint;

CREATE TABLE faculty
(f_id NUMBER(5),f_last VarChar2(15) constraint faculty_f_last_nn not null
,f_first VarChar2(15), constraint faculty_f_id_pk primary key (f_id));

create table student
(s_id number(2),s_last varchar2(10),s_first varchar2(10),s_class char(2),f_id number(5),
constraint student_s_id_pk primary key (s_id),
constraint student_f_id_fk foreign key (f_id) references faculty(f_id));

create table course
(course_no varchar2(7),course_name varchar2(25),credits number(2),max_enrl number(5),
constraint course_course_no_pk primary key (course_no));


create table enrollment
(s_id number(4),course_no char(7),grade char(5),
constraint enrollment_cpk primary key(s_id,course_no),
constraint enrollment_s_id_fk foreign key (s_id) references student(s_id),
constraint enrollment_course_no_fk foreign key (course_no) references course(course_no)); 


create table levelclass
(lc_type number(2),lc_desc varchar2(20),lc_min number(3),lc_max number(3),
constraint leveclass_lc_type_pk primary key (lc_type));

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

--Insert Student Records
insert into student values (1,'Graham','Bill','JR',4);
insert into student values (2,'Sanchez','Jim','EX',3);
insert into student values (3,'White','Peter','EX',3);
insert into student values (4,'Phelp','David','JR',1);
insert into student values (5,'Lewis','Sheila','SR',2);
insert into student values (6,'James','Thomas','JR',1);

insert into course values ('CS 155','Programming in C++',3,90);
insert into course values ('MIS 101','Intro. To Info. Systems',3,140);
insert into course values ('MIS 301','Systems Analysis',3,35);
insert into course values ('MIS 441','Database Management',3,12);
insert into course values ('MIS 451','Web-Based Systems',3,30);
insert into course values ('MIS 551','Advanced Web',3,30);
insert into course values ('MIS 651','Advanced Java',3,30);

insert into enrollment values (1,'MIS 101','A+');
insert into enrollment values (2,'MIS 441','A-');
insert into enrollment values (2,'MIS 451','A+');
insert into enrollment values (3,'CS 155','B-');
insert into enrollment values (3,'MIS 301','B-');
insert into enrollment values (3,'MIS 651','C+');
insert into enrollment values (4,'CS 155','B-');
insert into enrollment values (4,'MIS 441','A-');
insert into enrollment values (4,'MIS 551','B+');
insert into enrollment values (5,'MIS 301','B+');
insert into enrollment values (5,'MIS 451','A+');
insert into enrollment values (6,'MIS 551','B+');
insert into enrollment values (6,'MIS 651','C+');


alter table faculty add birthday date;
alter table faculty add soc_ins char(11);
update faculty set birthday='30-jul-40' where f_id = 1;
update faculty set birthday='12-may-50' where f_id = 2;
update faculty set birthday='24-mar-41' where f_id = 3;
update faculty set birthday='11-jul-71' where f_id = 4;
update faculty set birthday='09-jul-80' where f_id = 5;
update faculty set soc_ins='123-456-789' where f_id = 1;
update faculty set soc_ins='321-456-789' where f_id = 2;
update faculty set soc_ins='123-554-789' where f_id = 3;
update faculty set soc_ins='123-456-987' where f_id = 4;
update faculty set soc_ins='123-654-987' where f_id = 5;

alter table student add birthday date;
alter table student add soc_ins char(11);
update student set birthday='30-jul-80' where s_id = 1;
update student set birthday='12-may-81' where s_id = 2;
update student set birthday='24-mar-87' where s_id = 3;
update student set birthday='11-feb-88' where s_id = 4;
update student set birthday='09-oct-70' where s_id = 5;
update student set birthday='07-dec-60' where s_id = 6;
update student set soc_ins='456-123-789' where s_id = 1;
update student set soc_ins='654-123-789' where s_id = 2;
update student set soc_ins='456-321-789' where s_id = 3;
update student set soc_ins='456-123-987' where s_id = 4;
update student set soc_ins='456-321-987' where s_id = 5;
update student set soc_ins='654-321-987' where s_id = 6;


insert into levelclass values (1,'Small Class',1,12);
insert into levelclass values (2,'Medium Class',13,30);
insert into levelclass values (3,'Large Class',31,90);
insert into levelclass values (4,'Extra Large Class',91,140);


alter table course add prereq char(7);
update course set prereq = decode (course_no,
'CS 155','MIS 101',
'MIS 301','MIS 651',
'MIS 441','MIS 301',
'MIS 451','MIS 101',
'MIS 551', 'MIS 451',
'MIS 651','MIS 101');
--update course set prereq = 'MIS 101' where course_no = 'CS 155';
--


select TABLE_NAME from user_tables;
--select f_id, f_last from faculty;
--select s_id, s_class from student;
select * from faculty;
select * from student;
select * from course;
select * from enrollment;
select * from levelclass;