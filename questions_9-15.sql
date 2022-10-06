/* Vasilik (2016) */

-- Question 9
SELECT 
	OrderID
	,CustomerID
	,ShipCountry
FROM Orders
WHERE
	ShipCountry IN 
		(
		'Brazil'
		,'Mexico'
		,'Argentina'
		,'Venezuela'
		);

-- Question 10
SELECT
	FirstName
	,LastName
	,Title
	,BirthDate
FROM Employees
ORDER BY BirthDate ASC;

-- Question 11
SELECT
	FirstName
	,LastName
	,Title
	,CONVERT(DATE,BirthDate) AS DateOnlyBirthDate /* CONVERT(Target_type, Expression) */
FROM Employees
ORDER BY BirthDate ASC;

-- Question 12
SELECT
	FirstName
	,LastName
	,FirstName + ' ' + LastName AS FullName /* Alternatively, use CONCAT(string1, string2, ...) */
FROM Employees;

-- Question 13
SELECT
	OrderID
	,ProductID
	,UnitPrice
	,Quantity
	,UnitPrice*Quantity AS TotalPrice
FROM OrderDetails
ORDER BY OrderID, ProductID;

-- Question 14
SELECT
	COUNT(*) AS TotalCustomers
FROM Customers;

-- Question 15
SELECT 
	MIN(OrderDate) AS FirstOrder /* Alternatively, FirstOrder = MIN(OrderDate) */
FROM Orders;
