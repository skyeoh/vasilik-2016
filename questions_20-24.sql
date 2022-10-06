/* Vasilik (2016) */

-- Question 20
SELECT
	CategoryName
	,TotalProducts=COUNT(*)
FROM Categories
	JOIN Products
		ON Categories.CategoryID = Products.CategoryID
GROUP BY
	CategoryName
ORDER BY
	COUNT(*) DESC;

-- Question 21
SELECT 
	Country
	,City
	,TotalCustomer=COUNT(*)
FROM Customers
GROUP BY
	Country
	,City
ORDER BY
	COUNT(*) DESC;

-- Question 22
SELECT
	ProductID
	,ProductName
	,UnitsInStock
	,ReorderLevel
FROM Products
WHERE
	UnitsInStock < ReorderLevel
ORDER BY
	ProductID;

-- Question 23
SELECT
	ProductID
	,ProductName
	,UnitsInStock
	,UnitsOnOrder
	,ReorderLevel
	,Discontinued
FROM Products
WHERE
	UnitsInStock + UnitsOnOrder <= ReorderLevel
	AND Discontinued = 0
ORDER BY
	ProductID;

-- Question 24
SELECT
	CustomerID
	,CompanyName
	,Region
FROM Customers
ORDER BY
	CASE
		WHEN Region IS NULL THEN 1
		ELSE 0
	END
	,Region
	,CustomerID;

SELECT
	CustomerID
	,CompanyName
	,Region
	,RegionOrder=
		CASE
		WHEN Region IS NULL THEN 1
		ELSE 0
	END
FROM Customers
ORDER BY
	RegionOrder
	,Region
	,CustomerID;
