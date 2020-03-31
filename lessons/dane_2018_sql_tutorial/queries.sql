# More basic queries, by Mike Dane

# Find all employees
select *
from employee;

# Find all employees ordered by salary (low to high)
select *
from employee
order by salary;

# Find all employees ordered by salary (high to low)
select *
from employee
order by salary desc;

# Find all employees ordered by sex and name
select *
from employee
order by sex, first_name, last_name;

# Find the first 5 employees
select *
from employee
limit 5;

# Find the first and last names of all employees
select first_name, last_name
from employee;

select first_name as forename, last_name as surname
from employee;

# Find out all the different genders
select distinct sex
from employee;

# Find out all the different branch IDs
select distinct branch_id
from employee;

# Find all clients
select *
from client;