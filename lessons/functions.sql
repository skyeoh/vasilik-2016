# Functions, by Mike Dane

# Find the number of employees
select count(emp_id)
from employee;

# Find the number of employees with supervisors
select count(super_id)
from employee;

# Find the number of female employees born after 1970
select count(emp_id)
from employee
where sex = 'F' and birth_day > '1971-01-01';

# Find the average of all employee's salaries
select avg(salary)
from employee;

# Find the average of all male employee's salaries
select avg(salary)
from employee
where sex ='M';

# Find the sum of all employee's salaries
select sum(salary)
from employee;

# Find out how many males and females there are
select count(sex), sex
from employee
group by sex; # use aggregation

# Find the total sales of each salesman
select sum(total_sales), emp_id
from works_with
group by emp_id;

# Find the total purchase made by each client
select sum(total_sales), client_id
from works_with
group by client_id;

# Find the average salaries of each branch
select avg(salary), branch_id
from employee
group by branch_id;