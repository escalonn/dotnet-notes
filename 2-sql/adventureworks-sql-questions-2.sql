-- find all customers with no address: Customer, Address, CustomerAddress
SELECT CustomerID
FROM SalesLT.Customer
WHERE CustomerID NOT IN
	(
	SELECT CustomerID
	FROM SalesLT.CustomerAddress
	);

-- find all customers that ordered: Customer, SalesOrderHeader
SELECT DISTINCT CustomerID
FROM SalesLT.SalesOrderHeader;

-- find all products sold in 2006: SalesOrderHeader, SalesOrderDetail, Product
-- subquery version
SELECT DISTINCT ProductID
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID IN
	(
	SELECT SalesOrderID
	FROM SalesLT.SalesOrderHeader
	WHERE YEAR(OrderDate) = 2006
	);
-- join version
SELECT DISTINCT ProductID
FROM SalesLT.SalesOrderDetail AS sod
INNER JOIN SalesLT.SalesOrderHeader AS soh ON
soh.SalesOrderID = sod.SalesOrderID
WHERE YEAR(soh.OrderDate) = 2006;

-- find the most sold product ever: SalesOrderHeader, SalesOrderDetail, Product
SELECT sod.ProductID, SUM(sod.OrderQty) AS qty
INTO #product_qty
FROM SalesLT.SalesOrderDetail AS sod
INNER JOIN SalesLT.SalesOrderHeader AS soh ON
soh.SalesOrderID = sod.SalesOrderID
GROUP BY ProductID;
SELECT ProductID
FROM #product_qty
WHERE qty =
	(
	SELECT MAX(qty)
	FROM #product_qty
	);
DROP TABLE #product_qty;

-- find the most expensive order ever: SalesOrderHeader. Max / Order + Top
SELECT SalesOrderID
FROM SalesLT.SalesOrderHeader
WHERE TotalDue =
	(
	SELECT MAX(TotalDue)
	FROM SalesLT.SalesOrderHeader
	);

-- find the best customer ever: Max SalesOrderHeader Customer, SalesOrderHeader
SELECT CustomerID, SUM(TotalDue) AS spent
INTO #customer_spent
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID;
SELECT CustomerID
FROM #customer_spent
WHERE spent =
	(
	SELECT MAX(spent)
	FROM #customer_spent
	);
DROP TABLE #customer_spent;
