/* Vasilik (2016) */

-- Question 16
SELECT
	Country
FROM Customers
	GROUP BY Country;

-- Question 17
SELECT 
	ContactTitle
	,TotalContactTitle=COUNT(ContactTitle)
FROM Customers
	GROUP BY ContactTitle
	ORDER BY TotalContactTitle DESC;

-- Question 18
SELECT
	ProductID
	,ProductName
	,Supplier=CompanyName
FROM Products
	JOIN Suppliers
		ON Products.SupplierID = Suppliers.SupplierID
	ORDER BY ProductID;

-- Question 19
SELECT 
	OrderID
	,OrderDate=CONVERT(DATE, OrderDate)
	,Shipper=CompanyName
FROM Orders
	JOIN Shippers
		ON Orders.ShipVia = Shippers.ShipperID
	WHERE OrderID < 10300
	ORDER BY OrderID;
