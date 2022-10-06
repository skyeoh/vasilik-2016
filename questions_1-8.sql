/* Vasilik (2016) */

-- Question 1
SELECT * FROM Shippers;

-- Question 2
SELECT CategoryName, Description FROM Categories;

-- Question 3
SELECT FirstName, LastName, HireDate FROM Employees
WHERE Title = 'Sales Representative';

-- Question 4
SELECT FirstName, LastName, HireDate FROM Employees
WHERE Title = 'Sales Representative' AND Country = 'USA';

-- Question 5
SELECT OrderID, OrderDate FROM Orders
WHERE EmployeeID = 5;

-- Question 6
SELECT SupplierID, ContactName, ContactTitle
FROM Suppliers
	WHERE ContactTitle != 'Marketing Manager'; /* <> instead of != also works */

-- Question 7
SELECT ProductID, ProductName FROM Products
WHERE ProductName LIKE '%queso%'; /* = for exact match, LIKE for inexact match */

-- Question 8
SELECT OrderID, CustomerID, ShipCountry
FROM ORDERS
	WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium';