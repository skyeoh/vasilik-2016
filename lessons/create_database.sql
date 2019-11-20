# Creating a sample company database, by Mike Dane

# ======== Create tables ========
# Employee
create table employee (
	emp_id int primary key,
	first_name varchar(40),
	last_name varchar(40),
	birth_day date,
	sex varchar(1),
	salary int,
	super_id int,
	branch_id int
);

# Branch
create table branch (
	branch_id int primary key,
	branch_name varchar(40),
	mgr_id int,
	mgr_start_date date,
	foreign key(mgr_id) references employee(emp_id) on delete set null
);

# go back and set foreign keys for employee table
alter table employee
add foreign key(branch_id)
references branch(branch_id)
on delete set null;

alter table employee
add foreign key(super_id)
references employee(emp_id)
on delete set null;

# Client
create table client (
	client_id int primary key,
	client_name varchar(40),
	branch_id int,
	foreign key(branch_id) references branch(branch_id) on delete set null
);

# Works with
create table works_with (
	emp_id int,
	client_id int,
	total_sales int,
	primary key(emp_id, client_id),
	foreign key(emp_id) references employee(emp_id) on delete cascade,
	foreign key(client_id) references client(client_id) on delete cascade
);

# Branch supplier
create table branch_supplier (
	branch_id int,
	supplier_name varchar(40),
	supply_type varchar(40),
	primary key(branch_id, supplier_name),
	foreign key(branch_id) references branch(branch_id) on delete cascade
);

# ======== Populate tables ========
# Employee and Branch for the Corporate branch
insert into employee values (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, null, null);

insert into branch values (1, 'Corporate', 100, '2006-02-09');

update employee
set branch_id = 1
where emp_id = 100;

insert into employee values (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

# Employee and Branch for the Scranton branch
insert into employee values (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

insert into branch values (2, 'Scranton', 102, '1992-04-06');

update employee
set branch_id = 2
where emp_id = 102;

insert into employee values(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
insert into employee values(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
insert into employee values(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

# Employee and Branch for the Stamford branch
insert into employee values (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, null);

insert into branch values (3, 'Stamford', 106, '1998-02-13');

update employee
set branch_id = 3
where emp_id = 106;

insert into employee values(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
insert into employee values(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

# Branch supplier
insert into branch_supplier values(2, 'Hammer Mill', 'Paper');
insert into branch_supplier values(2, 'Uni-ball', 'Writing Utensils');
insert into branch_supplier values(3, 'Patriot Paper', 'Paper');
insert into branch_supplier values(2, 'J.T. Forms & Labels', 'Custom Forms');
insert into branch_supplier values(3, 'Uni-ball', 'Writing Utensils');
insert into branch_supplier values(3, 'Hammer Mill', 'Paper');
insert into branch_supplier values(3, 'Stamford Lables', 'Custom Forms');

# Client
insert into client values(400, 'Dunmore Highschool', 2);
insert into client values(401, 'Lackawana Country', 2);
insert into client values(402, 'FedEx', 3);
insert into client values(403, 'John Daly Law, LLC', 3);
insert into client values(404, 'Scranton Whitepages', 2);
insert into client values(405, 'Times Newspaper', 3);
insert into client values(406, 'FedEx', 2);

# Works with
insert into works_with values(105, 400, 55000);
insert into works_with values(102, 401, 267000);
insert into works_with values(108, 402, 22500);
insert into works_with values(107, 403, 5000);
insert into works_with values(108, 403, 12000);
insert into works_with values(105, 404, 33000);
insert into works_with values(107, 405, 26000);
insert into works_with values(102, 406, 15000);
insert into works_with values(105, 406, 130000);

# ======== Output tables ========
select * from employee;
select * from branch;
select * from branch_supplier;
select * from client;
select * from works_with;
