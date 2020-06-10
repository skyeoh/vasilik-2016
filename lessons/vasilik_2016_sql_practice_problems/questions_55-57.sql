/* Vasilik (2016) */

-- Question 55
WITH FirstOrders AS (
	SELECT
		ShipCountry
		,OrderDate=MIN(OrderDate)
	FROM Orders
	GROUP BY
		ShipCountry
)
SELECT
	Orders.ShipCountry
	,Orders.CustomerID
	,Orders.OrderID
	,OrderDate=CONVERT(DATE, Orders.OrderDate)
FROM FirstOrders
	LEFT JOIN Orders
		ON FirstOrders.ShipCountry = Orders.ShipCountry
			AND FirstOrders.OrderDate = Orders.OrderDate
ORDER BY
	Orders.ShipCountry;

	-- Alternatively, using CTE and ROW_NUMBER()
WITH OrdersByCountry AS (
	SELECT
		ShipCountry
		,CustomerID
		,OrderID
		,OrderDate=CONVERT(DATE, OrderDate)
		,RowNumberPerCountry=ROW_NUMBER()
			OVER (PARTITION BY ShipCountry ORDER BY OrderDate)
	FROM Orders
)
SELECT
	ShipCountry
	,CustomerID
	,OrderID
	,OrderDate
FROM OrdersByCountry
WHERE
	RowNumberPerCountry=1
ORDER BY
	ShipCountry;

-- Question 56
	-- Count number of rows in self-join of Orders table
SELECT
	COUNT(*)
FROM Orders InitialOrder
	JOIN Orders NextOrder
		ON InitialOrder.CustomerID = NextOrder.CustomerID;

SELECT
	InitialOrder.CustomerID
	,InitialOrderID=InitialOrder.OrderID
	,InitialOrderDate=CONVERT(DATE, InitialOrder.OrderDate)
	,NextOrderID=NextOrder.OrderID
	,NextOrderDate=CONVERT(DATE, NextOrder.OrderDate)
	,DaysBetween=DATEDIFF(day, InitialOrder.OrderDate, NextOrder.OrderDate)
FROM Orders InitialOrder
	JOIN Orders NextOrder
		ON InitialOrder.CustomerID = NextOrder.CustomerID
WHERE
	InitialOrder.OrderID < NextOrder.OrderID
	AND DATEDIFF(day, InitialOrder.OrderDate, NextOrder.OrderDate) <= 5
ORDER BY
	InitialOrder.CustomerID
	,InitialOrder.OrderID;

-- Question 57
WITH NextOrders AS (
	SELECT
		CustomerID
		,OrderDate
		,NextOrderDate=LEAD(OrderDate, 1)
			OVER (PARTITION BY CustomerID ORDER BY OrderID)
	FROM Orders
)
SELECT
	CustomerID
	,OrderDate=CONVERT(DATE, OrderDate)
	,NextOrderDate=CONVERT(DATE, NextOrderDate)
	,DaysBetweenOrders=DATEDIFF(dd, OrderDate, NextOrderDate)
FROM NextOrders
WHERE
	NextOrderDate IS NOT NULL
	AND DATEDIFF(dd, OrderDate, NextOrderDate) <= 5;