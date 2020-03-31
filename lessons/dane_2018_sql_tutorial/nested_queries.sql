# Nested queries, by Mike Dane

# SQL will process the innermost query first,
# and then go progressively outward, i.e.
# innermost to outermost.

# Find names of all employees who have
# sold over $30,000 to a single client
select employee.first_name, employee.last_name
from employee
where employee.emp_id in (
	select works_with.emp_id
	from works_with
	where works_with.total_sales > 30000
);

# Find all clients who are handled by the branch
# that Michael Scott manages
# Assume you know Michael's ID
select client.client_name
from client
where client.branch_id in (
	select branch.branch_id
	from branch
	where branch.mgr_id = 102
	# place "limit 1" here to limit output to only one branch id
	# in case multiple show up and only one is needed
);

# Alternatively
select client.client_name
from client
where client.branch_id in (
	select branch.branch_id
	from branch
	where branch.mgr_id in (
		select employee.emp_id
		from employee
		where employee.first_name = 'Michael' 
		      and employee.last_name = 'Scott'
	)
);