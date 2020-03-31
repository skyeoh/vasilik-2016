# Join, by Mike Dane

# Insert new branch into the branch table
insert into branch
values (4, 'Buffalo', null, null);

select * from branch;

# Find all branches and the names of their managers

    # Inner/Regular Join
select employee.emp_id, employee.first_name, branch.branch_name
from employee
join branch
on employee.emp_id = branch.mgr_id;

    # Left Join
select employee.emp_id, employee.first_name, branch.branch_name
from employee		# left table
left join branch	# right table
on employee.emp_id = branch.mgr_id;

    # Right Join
select employee.emp_id, employee.first_name, branch.branch_name
from employee		# left table
right join branch	# right table
on employee.emp_id = branch.mgr_id;

    # Full/Outer Join
# Combination of left and right joins where all the rows
# from the left and right tables are selected.

# Find the total sales from each employee
select employee.first_name, employee.last_name, sum(works_with.total_sales)
from employee
join works_with
on employee.emp_id = works_with.emp_id
group by employee.emp_id;

# Find the total purchases made by each client
select client.client_name, sum(works_with.total_sales)
from client
join works_with
on client.client_id = works_with.client_id
group by client.client_id;

# Find the supplier for each branch
select branch.branch_name, branch_supplier.supplier_name
from branch
join branch_supplier
on branch.branch_id = branch_supplier.branch_id;

# Find the employees and their branches
select employee.first_name, employee.last_name, branch.branch_name
from employee
join branch
on employee.branch_id = branch.branch_id;