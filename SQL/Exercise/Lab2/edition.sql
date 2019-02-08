set pagesize 800
set linesize 800

drop table publisher cascade constraints;
create table publisher (
p_id number(5),p_name varchar2(30),p_address varchar2(40),
constraint publisher_p_id_pk primary key (p_id));

insert into publisher values(1,'Course Technology','13 Ontario Street Canada');
insert into publisher values(2,'Campus Press','21 Durocher Avenue Quebec Canada');
insert into publisher values(3,'Pearson Education','45 New York USA');
insert into publisher values(4,'Harvard Publishing','New Hamphshir, Boston');
insert into publisher values(5,'MIT Publishing','32 Square Paule Boston, USA');

drop table book cascade constraints;
create table book (
b_id number(5),b_author varchar2(20),b_title varchar2(30),b_isbn varchar2(13),b_type varchar2(2),b_price number(6,2),p_id number(5),
constraint book_b_id_pk primary key (b_id), 
constraint book_p_id_fk foreign key (p_id) references publisher(p_id));

insert into book values(1,'Stev_Jeff','Java Programming','1234987','BG',42.4,4);
insert into book values(2,'Amine Khan','Oracle Database','345675','EX',252.4,1);
insert into book values(3,'Eduard Becher','History of Art','098766','EX',202.3,5);
insert into book values(4,'James Peter','PHP Programming','765432','MD',66.7,2);
insert into book values(5,'Paul Tremblay','Economy and Wealth','1209845','BG',);
insert into book values(6,'Paul Henry','Business Principles','654321','BG',12.6,4);

drop table chapter cascade constraints;
create table chapter (
b_id number(5),c_no number(5),c_title varchar2(20),c_type varchar2(2),c_price number(6,2),
constraint chapter_cpk primary key (b_id,c_no),
constraint chapter_b_id_fk foreign key (b_id) references book(b_id));

insert into chapter values (1,1,'Java 1','TS',12);
insert into chapter values (1,2,'Java 2','NS',0);
insert into chapter values (2,1,'Oracle 1','TS',22);
insert into chapter values (2,2,'Oracle 2','TS',32);
insert into chapter values (2,3,'Oracle 3','TS',42);
insert into chapter values (3,1,'History 1','NS',0);
insert into chapter values (3,2,'History 2','NS',0);
insert into chapter values (3,3,'History 3','TS',65);
insert into chapter values (4,1,'PHP 1','TS',12);
insert into chapter values (4,2,'PHP 2','TS',65);
insert into chapter values (5,1,'Economy 1','TS',52);
insert into chapter values (5,2,'Economy 2','TS',76);
insert into chapter values (6,1,'Business 1','NS',0);


select table_name from user_tables;
select * from publisher;
select * from book;
select * from chapter;
