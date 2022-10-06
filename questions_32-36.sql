/* Vasilik (2016) */

-- Question 32
SELECT
	CustomerID=Customers.CustomerID
	,CompanyName=Customers.CompanyName
	,OrderID=Orders.OrderID
	--,Quantity=OrderDetails.Quantity
	--,UnitPrice=OrderDetails.UnitPrice
	,TotalOrderAmount=SUM(OrderDetails.Quantity*OrderDetails.UnitPrice)
FROM Customers
	JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
WHERE
	Orders.OrderDate >= '20160101'
	AND Orders.OrderDate < '20170101'
GROUP BY
	Customers.CustomerID
	,Customers.CompanyName
	,Orders.OrderID
HAVING
	SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) >= 10000
ORDER BY
	TotalOrderAmount DESC;

-- Question 33
SELECT
	CustomerID=Customers.CustomerID
	,CompanyName=Customers.CompanyName
	--,OrderID=Orders.OrderID
	--,Quantity=OrderDetails.Quantity
	--,UnitPrice=OrderDetails.UnitPrice
	,TotalOrderAmount=SUM(OrderDetails.Quantity*OrderDetails.UnitPrice)
FROM Customers
	JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
WHERE
	Orders.OrderDate >= '20160101'
	AND Orders.OrderDate < '20170101'
GROUP BY
	Customers.CustomerID
	,Customers.CompanyName
	--,Orders.OrderID
HAVING
	SUM(OrderDetails.Quantity*OrderDetails.UnitPrice) >= 15000
ORDER BY
	TotalOrderAmount DESC;

-- Question 34
SELECT
	CustomerID=Customers.CustomerID
	,CompanyName=Customers.CompanyName
	--,OrderID=Orders.OrderID
	--,Quantity=OrderDetails.Quantity
	--,UnitPrice=OrderDetails.UnitPrice
	,TotalsWithoutDiscount=SUM(OrderDetails.Quantity*OrderDetails.UnitPrice)
	,TotalsWithDiscount=SUM(OrderDetails.Quantity*OrderDetails.UnitPrice*(1-OrderDetails.Discount))
FROM Customers
	JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
WHERE
	Orders.OrderDate >= '20160101'
	AND Orders.OrderDate < '20170101'
GROUP BY
	Customers.CustomerID
	,Customers.CompanyName
	--,Orders.OrderID
HAVING
	SUM(OrderDetails.Quantity*OrderDetails.UnitPrice*(1-OrderDetails.Discount)) >= 10000
ORDER BY
	TotalsWithDiscount DESC;

-- Question 35
SELECT
	EmployeeID
	,OrderID
	,OrderDate
FROM Orders
WHERE
	DAY(OrderDate) = DAY(EOMONTH(OrderDate))
ORDER BY
	EmployeeID
	,OrderID;

SELECT	-- Alternative solution
	EmployeeID
	,OrderID
	,OrderDate
FROM Orders
WHERE
	DAY(OrderDate) = DAY(DATEADD(month,1 + DATEDIFF(month,0,OrderDate),-1))
ORDER BY
	EmployeeID
	,OrderID;

-- Question 36
SELECT
	OrderID
	,TotalOrderDetails=COUNT(ProductID)
FROM OrderDetails
GROUP BY
	OrderID
ORDER BY
	TotalOrderDetails DESC
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;

SELECT TOP 10
	Orders.OrderID
	,TotalOrderDetails=COUNT(*)
FROM Orders
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
	Orders.OrderID
ORDER BY
	COUNT(*) DESC

SELECT TOP 10 WITH TIES
	Orders.OrderID
	,TotalOrderDetails=COUNT(*)
FROM Orders
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
	Orders.OrderID
ORDER BY
	COUNT(*) DESC