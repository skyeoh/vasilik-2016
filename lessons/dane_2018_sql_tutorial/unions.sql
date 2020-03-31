# Unions, by Mike Dane

# Find a list of employee and branch names
select first_name as name	# Results of each select statement
from employee      			# must have the same number of columns
union			   			# and similar data types.
select branch_name
from branch;

# Find a list of employee, branch and client names
select first_name as name
from employee
union
select branch_name
from branch
union
select client_name
from client;

# Find a list of all clients and branch supplier names
select client_name as name, client.branch_id
from client
union
select supplier_name, branch_supplier.branch_id
from branch_supplier;

# Find a list of all money spent or earned by the company
select salary as money
from employee
union
select total_sales
from works_with;