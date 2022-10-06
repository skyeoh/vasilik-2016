/* Vasilik (2016) */

-- Question 25
SELECT TOP 3
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
GROUP BY
	ShipCountry
ORDER BY
	AverageFreight DESC;

SELECT
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
GROUP BY
	ShipCountry
ORDER BY
	AverageFreight DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

-- Question 26
SELECT TOP 3
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
WHERE
	OrderDate BETWEEN '2015-01-01' AND '2016-01-01'
GROUP BY
	ShipCountry
ORDER BY
	AverageFreight DESC;

SELECT TOP 3
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
WHERE
	OrderDate >= '20150101' 
	AND OrderDate < '20160101' -- YYYYMMDD is correct worldwide
GROUP BY
	ShipCountry
ORDER BY
	AverageFreight DESC;

SELECT TOP 3
	ShipCountry
	,AverageFreight=AVG(Freight)
FROM Orders
WHERE
	YEAR(OrderDate)=2015
GROUP BY
	ShipCountry
ORDER BY
	AverageFreight DESC;

-- Question 27
SELECT
	OrderID
	,OrderDate
	,Freight
	,ShipCountry
FROM ORDERS
WHERE
	OrderDate BETWEEN '2015-12-31' AND '2016-01-01'
	AND ShipCountry = 'France';