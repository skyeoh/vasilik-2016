# Triggers, by Mike Dane

# Create new table
create table trigger_test (
	message varchar(100)
);

# Create trigger #1
# When a new employee is inserted into the employee table,
# a row containing 'added new employee' is inserted into
# the trigger_test table.
# NOTE: This must be executed in a MySQL command line.
delimiter $$
create
	trigger my_trigger before insert
	on employee
	for each row begin
		insert into trigger_test values ('added new employee');
	end$$
delimiter ;

# Add new employee into employee table
insert into employee
values (109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

select * from employee;
select * from trigger_test;

# Create trigger #2
# When a new employee is inserted into the employee table,
# a new row containing the first name of the new employee is
# inserted into the trigger_test table.
# NOTE: This must be executed in a MySQL command line.
delimiter $$
create
	trigger my_trigger2 before insert
	on employee
	for each row begin
		insert into trigger_test values(new.first_name); # new refers to the new row
	end$$												 # that was just inserted into 
delimiter ;												 # the employee table

# Add new employee into employee table
insert into employee
values (110, 'Kevin', 'Malone', '1978-03-22', 'M', 62000, 106, 3);

select * from employee;
select * from trigger_test;

# Create trigger #3
# When a new employee is inserted into the employee table,
# a new row containing 'added male employee',
# 'added female employee' or 'added other employee'
# is inserted into the trigger_test table depending
# on the sex of the new employee.
# NOTE: This must be executed in a MySQL command line.
delimiter $$
create
	trigger my_trigger3 before insert
	on employee
	for each row begin
		if new.sex = 'M' then
			insert into trigger_test values('added male employee');
		elseif new.sex = 'F' then
			insert into trigger_test values('added female employee');
		else
			insert into trigger_test values('added other employee');
		end if;
	end$$
delimiter ;

# Add new employee into employee table
insert into employee
values (111, 'Pam', 'Beesly', '1979-03-25', 'F', 59000, 102, 2);

select * from employee;
select * from trigger_test;

# Remove triggers
drop trigger my_trigger;
drop trigger my_trigger2;
drop trigger my_trigger3;