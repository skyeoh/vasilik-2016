/* Vasilik (2016) */

-- Question 30
SELECT
	Customers_CustomerID=C.CustomerID
	,Orders_CustomerID=O.CustomerID
FROM Customers C
	LEFT JOIN Orders O
		ON C.CustomerID = O.CustomerID
WHERE
	O.CustomerID IS NULL
ORDER BY
	C.CustomerID;

SELECT
	CustomerID
FROM Customers
WHERE
	CustomerID NOT IN (	-- Alternative 1: Use NOT IN
		SELECT
			CustomerID
		FROM Orders
	);

SELECT
	CustomerID
FROM Customers
WHERE
	NOT EXISTS (  -- Alternative 2: Use NOT EXISTS and correlated subquery
		SELECT
			CustomerID
		FROM Orders
		WHERE
			Orders.CustomerID = Customers.CustomerID
	);

-- Question 31
SELECT
	CustomerID
FROM Customers
WHERE
	CustomerID NOT IN (
		SELECT
			CustomerID
		FROM Orders
		WHERE
			EmployeeID=4
	)
GROUP BY
	CustomerID;

SELECT
	CustomerID
FROM Customers
WHERE
	NOT EXISTS (
		SELECT
			CustomerID
		FROM Orders
		WHERE
			Orders.CustomerID = Customers.CustomerID
			AND Orders.EmployeeID = 4
	);

SELECT
	Customers_CustomerID=C.CustomerID
	,Orders_CustomerID=O.CustomerID
FROM Customers C
	LEFT JOIN Orders O
		ON C.CustomerID = O.CustomerID
		AND O.EmployeeID = 4
WHERE
	O.CustomerID IS NULL;