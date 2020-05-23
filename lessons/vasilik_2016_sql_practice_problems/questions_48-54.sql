/* Vasilik (2016) */

-- Question 48
WITH TotalOrders AS (
	SELECT
		CustomerID=Customers.CustomerID
		,CompanyName=Customers.CompanyName
		,TotalOrderAmount=SUM(Quantity*UnitPrice)
	FROM Customers
		JOIN Orders
			ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
	WHERE
		OrderDate >= '20160101'
		AND OrderDate < '20170101'
	GROUP BY
		Customers.CustomerID
		,Customers.CompanyName
)
SELECT
	CustomerID
	,CompanyName
	,TotalOrderAmount
	,CustomerGroup=
	CASE
		WHEN TotalOrderAmount<=1000 THEN 'Low'
		WHEN TotalOrderAmount<=5000 THEN 'Medium'
		WHEN TotalOrderAmount<=10000 THEN 'High'
		ELSE 'Very High'
	END
FROM TotalOrders
ORDER BY
	CustomerID;

	-- Solution proposed but there is a problem with it
WITH TotalOrders AS (
	SELECT
		CustomerID=Customers.CustomerID
		,CompanyName=Customers.CompanyName
		,TotalOrderAmount=SUM(Quantity*UnitPrice)
	FROM Customers
		JOIN Orders
			ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
	WHERE
		OrderDate >= '20160101'
		AND OrderDate < '20170101'
	GROUP BY
		Customers.CustomerID
		,Customers.CompanyName
)
SELECT
	CustomerID
	,CompanyName
	,TotalOrderAmount
	,CustomerGroup=
	CASE
		WHEN TotalOrderAmount BETWEEN 0 AND 1000 THEN 'Low'
		WHEN TotalOrderAmount BETWEEN 1001 AND 5000 THEN 'Medium'
		WHEN TotalOrderAmount BETWEEN 5001 AND 10000 THEN 'High'
		WHEN TotalOrderAmount > 10000 THEN 'Very High'
	END
FROM TotalOrders
ORDER BY
	CustomerID;

-- Question 49
   -- First solution to Question 48 is one possibility.

   -- Alternatively,
WITH TotalOrders AS (
	SELECT
		CustomerID=Customers.CustomerID
		,CompanyName=Customers.CompanyName
		,TotalOrderAmount=SUM(Quantity*UnitPrice)
	FROM Customers
		JOIN Orders
			ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
	WHERE
		OrderDate >= '20160101'
		AND OrderDate < '20170101'
	GROUP BY
		Customers.CustomerID
		,Customers.CompanyName
)
SELECT
	CustomerID
	,CompanyName
	,TotalOrderAmount
	,CustomerGroup=
	CASE
		WHEN TotalOrderAmount <= 1000 THEN 'Low'
		WHEN TotalOrderAmount > 1000 AND TotalOrderAmount <= 5000 THEN 'Medium'
		WHEN TotalOrderAmount > 5000 AND TotalOrderAmount <= 10000 THEN 'High'
		ELSE 'Very High'
	END
FROM TotalOrders
ORDER BY
	CustomerID;

WITH TotalOrders AS (
	SELECT
		CustomerID=Customers.CustomerID
		,CompanyName=Customers.CompanyName
		,TotalOrderAmount=SUM(Quantity*UnitPrice)
	FROM Customers
		JOIN Orders
			ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
	WHERE
		OrderDate >= '20160101'
		AND OrderDate < '20170101'
	GROUP BY
		Customers.CustomerID
		,Customers.CompanyName
)
SELECT
	CustomerID
	,CompanyName
	,TotalOrderAmount
	,CustomerGroup=
	CASE
		WHEN TotalOrderAmount BETWEEN 0 AND 1000 THEN 'Low'
		WHEN TotalOrderAmount BETWEEN 1000.01 AND 5000 THEN 'Medium'
		WHEN TotalOrderAmount BETWEEN 5000.01 AND 10000 THEN 'High'
		ELSE 'Very High'
	END
FROM TotalOrders
ORDER BY
	CustomerID;

-- Question 50
WITH TotalOrders AS (
	SELECT
		TotalOrderAmount=SUM(Quantity*UnitPrice)
	FROM Customers
		JOIN Orders
			ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
	WHERE
		OrderDate >= '20160101'
		AND OrderDate < '20170101'
	GROUP BY
		Customers.CustomerID
)
,CustomerCategories AS (
	SELECT
		CustomerGroup=
		CASE
			WHEN TotalOrderAmount <= 1000 THEN 'Low'
			WHEN TotalOrderAmount <= 5000 THEN 'Medium'
			WHEN TotalOrderAmount <= 10000 THEN 'High'
			ELSE 'Very High'
		END
	FROM TotalOrders
)
SELECT
	CustomerGroup
	,TotalInGroup=COUNT(*)
	,PercentageInGroup=COUNT(*)*1.0 / (SELECT COUNT(*) FROM CustomerCategories)
FROM CustomerCategories
GROUP BY
	CustomerGroup
ORDER BY
	TotalInGroup DESC;

-- Question 51
SELECT
	*
FROM CustomerGroupThresholds;

WITH TotalOrders AS (
	SELECT
		CustomerID=Customers.CustomerID
		,CompanyName
		,TotalOrderAmount=SUM(Quantity*UnitPrice)
	FROM Customers
		JOIN Orders
			ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails
			ON Orders.OrderID = OrderDetails.OrderID
	WHERE
		OrderDate >= '20160101'
		AND OrderDate < '20170101'
	GROUP BY
		Customers.CustomerID
		,CompanyName
)
SELECT
	CustomerID
	,CompanyName
	,TotalOrderAmount
	,CustomerGroupName
FROM TotalOrders
	JOIN CustomerGroupThresholds
		ON TotalOrderAmount > RangeBottom 
			AND TotalOrderAmount <= RangeTop;

-- Question 52
SELECT
	Country
FROM Suppliers
UNION
SELECT
	Country
FROM Customers;

SELECT DISTINCT -- There are duplicates
	Country
FROM Suppliers
UNION ALL
SELECT DISTINCT
	Country
FROM Customers
ORDER BY
	Country;

-- Question 53
WITH SupplierCountries AS (
	SELECT DISTINCT
		Country
	FROM Suppliers
)
,CustomerCountries AS (
	SELECT DISTINCT
		Country
	FROM Customers
)
SELECT
	SupplierCountry=S.Country
	,CustomerCountry=C.Country
FROM SupplierCountries S
	FULL JOIN CustomerCountries C
		ON S.Country = C.Country;

		-- Alternatively, using derived tables
SELECT
	SupplierCountry=SupplierCountries.Country
	,CustomerCountry=CustomerCountries.Country
FROM (
		SELECT DISTINCT
			Country
		FROM Suppliers
	 ) SupplierCountries
	FULL JOIN (
		SELECT DISTINCT
			Country
		FROM Customers
	 ) CustomerCountries
		ON SupplierCountries.Country = CustomerCountries.Country;

-- Question 54
WITH Countries AS (
	SELECT
		Country
	FROM Suppliers
	UNION
	SELECT
		Country
	FROM Customers
)
,SupplierCounts AS (
	SELECT
		Country
		,TotalSuppliers=COUNT(*)
	FROM Suppliers
	GROUP BY
		Country
)
,CustomerCounts AS (
	SELECT
		Country
		,TotalCustomers=COUNT(*)
	FROM Customers
	GROUP BY
		Country
)
SELECT
	Country=C.Country
	,TotalSuppliers=ISNULL(TotalSuppliers, 0)
	,TotalCustomers=ISNULL(TotalCustomers, 0)
FROM Countries C
	LEFT JOIN SupplierCounts SC
		ON C.Country = SC.Country
	LEFT JOIN CustomerCounts CC
		ON C.Country = CC.Country;

	-- Alternatively,
WITH SupplierCounts AS (
	SELECT
		Country
		,TotalSuppliers=COUNT(*)
	FROM Suppliers
	GROUP BY
		Country
)
,CustomerCounts AS (
	SELECT
		Country
		,TotalCustomers=COUNT(*)
	FROM Customers
	GROUP BY
		Country
)
SELECT
	Country=ISNULL(SC.Country, CC.Country)
	,TotalSuppliers=ISNULL(TotalSuppliers, 0)
	,TotalCustomers=ISNULL(TotalCustomers, 0)
FROM SupplierCounts SC
	FULL JOIN CustomerCounts CC
		ON SC.Country = CC.Country;