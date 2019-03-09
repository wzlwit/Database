-- create tables of Library database
-- script date: february 26,2019
-- Developed by Bianyu WANG(1896181) , Hongyu ZHAO(1895825), Yangyang MA(1896156), Zhaolong Wang(1896216 ) 

-- in order to create tables, switch to the Library database
-- add a statement that specifies the script runs in the context of the Library database


use Library;
go


-- Add FK between members and adults tables
alter table Member.adults
	add constraint fk_adults_members foreign key (member_no) references Member.members(member_no);
go

-- Add FK between members and Juveniles tables
alter table Member.Juveniles
	add constraint fk_Juveniles_members foreign key (member_no) references Member.members(member_no);
go

alter table Member.Juveniles
	add constraint fk_Juveniles_Adult foreign key (adult_member_no) references Member.adults(member_no);
go


-- Add FK between Reservations and members tables
alter table Operation.Reservations
	add constraint fk_Reservations_members foreign key (member_no) references Member.members(member_no);
go

-- Add FK between Reservations and items tables
alter table Operation.Reservations
	add constraint fk_Reservations_items foreign key (ISBN) references Operation.items(ISBN);
go

-- Add FK between items and titiles tables
alter table Operation.items
	add constraint fk_items_titles foreign key (title_no) references Operation.titles(title_no);
go



-- Add FK between loans and members tables
alter table Operation.loans
	add constraint fk_loan_members foreign key (member_no) references Member.members(member_no);
go 

-- Add FK between loanhist and copies tables
alter table Operation.loanhist
	add constraint fk_loanhist_copies foreign key (isbn,copy_no) references Operation.copies(isbn,copy_no);
go 


-- Add FK between loans and copies tables
alter table Operation.loans
	add constraint fk_loans_copies foreign key(isbn,copy_no) references Operation.copies(isbn,copy_no);
go
-- Add FK between loans and titles tables
alter table Operation.loans
	add constraint fk_loans_titles foreign key(title_no) references Operation.titles(title_no);
go



-- Add FK between copies and items tables
alter table Operation.copies
	add constraint fk_copies_items foreign key(ISBN) references Operation.items(ISBN);
go

-- add fk between copies and titles tables
alter table Operation.copies
	add constraint fk_copies_titles foreign key(title_no) references Operation.titles(title_no);
go



-- Create the default constraint that makes WA (Washington) the default for the state column in the adult table.
alter table Member.Adults
	add constraint df_State_Adults default ('WA') for State
;
go

/* Add the check constraint to the due_date column in the loan table. 
The value in the due_date column must be greater than or equal to the value in the out_date column (due_date >= out_date).
*/
alter table Operation.Loans
	add constraint ck_due_Date_Loans check (Due_Date >= out_Date) 
;
go

/*Add the default constraint a phone number to the adult table */
alter table Member.Adults
	add constraint df_PhoneNo_Adults default ('001-000-000-0000') for PhoneNo
;
go
