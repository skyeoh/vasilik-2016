# Wildcards, by Mike Dane

# % = any number of characters 
# _ = one character

# Find any client who is an LLC
select *
from client
where client_name like '%LLC';

# Find any branch suppliers who are in the label business
select *
from branch_supplier
where supplier_name like '% Label%' 
or supplier_name like '% Lable%'
or supplier_name like '% label%'
or supplier_name like '% lable%';

# Find any employee born in October
select *
from employee
where birth_day like '____-10%';

# Find any clients who are schools
select *
from client
where client_name like '%school%'
or client_name like '%School%';