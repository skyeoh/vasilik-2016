/* Vasilik (2016) */

-- Question 40
SELECT
	OrderDetails.OrderID
	,ProductID
	,UnitPrice
	,Quantity
	,Discount
FROM OrderDetails
	JOIN (
		SELECT DISTINCT
			OrderID
		FROM OrderDetails
		WHERE
			Quantity >= 60
		GROUP BY
			OrderID
			,Quantity
		HAVING
			COUNT(*) > 1
	) PotentialProblemOrders
		ON PotentialProblemOrders.OrderID = OrderDetails.OrderID
ORDER BY
	OrderID
	,ProductID;

-- Question 41
SELECT 
	OrderID
	,OrderDate=CONVERT(DATE,OrderDate)
	,RequiredDate=CONVERT(DATE,RequiredDate)
	,ShippedDate=CONVERT(DATE,ShippedDate)
FROM Orders
WHERE
	ShippedDate >= RequiredDate;

-- Question 42
SELECT
	EmployeeID=Employees.EmployeeID
	,FirstName
	,LastName
	,TotalLateOrders=COUNT(*)
FROM Employees
	JOIN Orders
		ON Employees.EmployeeID = Orders.EmployeeID
WHERE
	ShippedDate >= RequiredDate
GROUP BY
	Employees.EmployeeID
	,FirstName
	,LastName
ORDER BY
	TotalLateOrders DESC;

-- Question 43
WITH TotalLateOrders AS (
	SELECT
		EmployeeID
		,LateOrders=COUNT(*)
	FROM Orders
	WHERE
		ShippedDate >= RequiredDate
	GROUP BY
		EmployeeID
)
,TotalAllOrders AS (
	SELECT
		EmployeeID
		,AllOrders=COUNT(*)
	FROM Orders
	GROUP BY
		EmployeeID
)
SELECT 
	EmployeeID=Employees.EmployeeID
	,FirstName
	,LastName
	,AllOrders
	,LateOrders
FROM Employees 
	JOIN TotalLateOrders
		ON Employees.EmployeeID = TotalLateOrders.EmployeeID
	JOIN TotalAllOrders
		ON Employees.EmployeeID = TotalAllOrders.EmployeeID
ORDER BY
	Employees.EmployeeID;

-- Question 44
WITH TotalLateOrders AS (
	SELECT
		EmployeeID
		,LateOrders=COUNT(*)
	FROM Orders
	WHERE
		ShippedDate >= RequiredDate
	GROUP BY
		EmployeeID
)
,TotalAllOrders AS (
	SELECT
		EmployeeID
		,AllOrders=COUNT(*)
	FROM Orders
	GROUP BY
		EmployeeID
)
SELECT 
	EmployeeID=Employees.EmployeeID
	,FirstName
	,LastName
	,AllOrders
	,LateOrders
FROM Employees 
	LEFT JOIN TotalLateOrders
		ON Employees.EmployeeID = TotalLateOrders.EmployeeID
	JOIN TotalAllOrders
		ON Employees.EmployeeID = TotalAllOrders.EmployeeID
ORDER BY
	Employees.EmployeeID;

-- Question 45
WITH TotalLateOrders AS (
	SELECT
		EmployeeID
		,LateOrders=COUNT(*)
	FROM Orders
	WHERE
		ShippedDate >= RequiredDate
	GROUP BY
		EmployeeID
)
,TotalAllOrders AS (
	SELECT
		EmployeeID
		,AllOrders=COUNT(*)
	FROM Orders
	GROUP BY
		EmployeeID
)
SELECT 
	EmployeeID=Employees.EmployeeID
	,FirstName
	,LastName
	,AllOrders
	,LateOrders=ISNULL(LateOrders, 0) -- alternatively, use CASE
FROM Employees 
	LEFT JOIN TotalLateOrders
		ON Employees.EmployeeID = TotalLateOrders.EmployeeID
	JOIN TotalAllOrders
		ON Employees.EmployeeID = TotalAllOrders.EmployeeID
ORDER BY
	Employees.EmployeeID;

-- Question 46
WITH TotalLateOrders AS (
	SELECT
		EmployeeID
		,LateOrders=COUNT(*)
	FROM Orders
	WHERE
		ShippedDate >= RequiredDate
	GROUP BY
		EmployeeID
)
,TotalAllOrders AS (
	SELECT
		EmployeeID
		,AllOrders=COUNT(*)
	FROM Orders
	GROUP BY
		EmployeeID
)
SELECT 
	EmployeeID=Employees.EmployeeID
	,FirstName
	,LastName
	,AllOrders
	,LateOrders=ISNULL(LateOrders,0)
	,PercentLateOrders=CAST(ISNULL(LateOrders,0) AS DECIMAL)/AllOrders -- alternatively, (ISNULL(LateOrders, 0) * 1.00)/AllOrders
FROM Employees 
	LEFT JOIN TotalLateOrders
		ON Employees.EmployeeID = TotalLateOrders.EmployeeID
	JOIN TotalAllOrders
		ON Employees.EmployeeID = TotalAllOrders.EmployeeID
ORDER BY
	Employees.EmployeeID;

-- Question 47
WITH TotalLateOrders AS (
	SELECT
		EmployeeID
		,LateOrders=COUNT(*)
	FROM Orders
	WHERE
		ShippedDate >= RequiredDate
	GROUP BY
		EmployeeID
)
,TotalAllOrders AS (
	SELECT
		EmployeeID
		,AllOrders=COUNT(*)
	FROM Orders
	GROUP BY
		EmployeeID
)
SELECT 
	EmployeeID=Employees.EmployeeID
	,FirstName
	,LastName
	,AllOrders
	,LateOrders=ISNULL(LateOrders,0)
	,PercentLateOrders=
		CAST(
			CAST(ISNULL(LateOrders,0) AS DECIMAL)/AllOrders 
			AS DECIMAL(10,2)
			)
/*
	alternatively,
		CONVERT(
			DECIMAL(10,2)
			,(ISNULL(LateOrders,0) * 1.00)/AllOrders
			)
*/
FROM Employees 
	LEFT JOIN TotalLateOrders
		ON Employees.EmployeeID = TotalLateOrders.EmployeeID
	JOIN TotalAllOrders
		ON Employees.EmployeeID = TotalAllOrders.EmployeeID
ORDER BY
	Employees.EmployeeID;