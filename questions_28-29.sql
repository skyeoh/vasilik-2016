/* Vasilik (2016) */

-- Question 28
SELECT
	LatestOrderDate=MAX(OrderDate)
FROM Orders;

SELECT
	DATEADD(YY, -1, (SELECT MAX(OrderDate) FROM Orders));

SELECT TOP 3
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
WHERE
	OrderDate>=(
		SELECT
			DATEADD(YY, -1, (SELECT MAX(OrderDate) FROM Orders))
	)
	AND OrderDate<(
		SELECT
			MAX(OrderDate)
		FROM Orders
	)
GROUP BY
	ShipCountry
ORDER BY
	AverageFreight DESC;

SELECT TOP 3
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
WHERE
	OrderDate>=DATEADD(YY, -1, (SELECT MAX(OrderDate) FROM Orders)) -- This condition is dynamic, i.e. 
GROUP BY                                                            -- it will always be 1 year from when the latest order is placed.
	ShipCountry
ORDER BY
	AverageFreight DESC;

-- Question 29
SELECT
	Employees.EmployeeID
	,Employees.LastName
	,Orders.OrderID
	,Products.ProductName
	,OrderDetails.Quantity
FROM Orders
	JOIN Employees
		ON Orders.EmployeeID = Employees.EmployeeID
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
	JOIN Products
		ON OrderDetails.ProductID = Products.ProductID
ORDER BY
	Orders.OrderID
	,OrderDetails.ProductID;

/* 
	Field		Table(s)
	-----		--------
    EmployeeID	Employees, Orders
	LastName	Employees
	OrderID		Orders, OrderDetails
	ProductName	Products
	Quantity	OrderDetails
	ProductID	OrderDetails, Products

	JOIN Employees + Orders ON EmployeeID -> EmployeeID, LastName, OrderID
	JOIN Products + OrderDetails ON ProductID -> ProductName, Quantity, OrderID, ProductID
	JOIN two tables above ON OrderID
*/
