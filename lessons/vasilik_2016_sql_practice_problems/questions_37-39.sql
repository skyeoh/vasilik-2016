/* Vasilik (2016) */

-- Question 37
SELECT TOP 2 PERCENT
	OrderID
FROM Orders
ORDER BY
	NEWID();

SELECT TOP 2 PERCENT
	OrderID
	,RandomValue=ABS(CHECKSUM(NEWID()))
FROM Orders
ORDER BY
	RandomValue;

-- Question 38
SELECT
	OrderID
	,Quantity
FROM OrderDetails
WHERE
	Quantity >= 60
GROUP BY
	OrderID
	,Quantity
HAVING
	COUNT(*) > 1
ORDER BY
	OrderID;

-- Question 39
SELECT
	OrderID
	,ProductID
	,UnitPrice
	,Quantity
	,Discount
FROM OrderDetails
WHERE
	OrderID IN (
		SELECT
			OrderID
		FROM OrderDetails
		WHERE
			Quantity >= 60
		GROUP BY
			OrderID
			,Quantity
		HAVING
			COUNT(*) > 1
	)
ORDER BY
	OrderID
	,Quantity;

WITH DoubleEntries AS ( -- Alternative solution using
	SELECT				-- common table expression (CTE)
		OrderID
	FROM OrderDetails
	WHERE
		Quantity >= 60
	GROUP BY
		OrderID
		,Quantity
	HAVING
		COUNT(*) > 1
)
SELECT
	OrderID
	,ProductID
	,UnitPrice
	,Quantity
	,Discount
FROM OrderDetails
WHERE
	OrderID IN (
		SELECT
			OrderID
		FROM
			DoubleEntries
	)
ORDER BY
	OrderID
	,Quantity;