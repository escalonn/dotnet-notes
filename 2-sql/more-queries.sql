USE adventureworks;

-- every person that has no middle name
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS NULL OR MiddleName = '';

-- every first name that is also a last name (self-join version)
SELECT DISTINCT a.FirstName
FROM Person.Person AS a
JOIN Person.Person AS b
ON a.FirstName = b.LastName;

-- every first name that is also a last name (set-operator version)
SELECT FirstName
FROM Person.Person
INTERSECT
SELECT LastName
FROM Person.Person;

-- every first name that is also a last name (subquery version)
SELECT FirstName
FROM Person.Person
WHERE FirstName IN (
	SELECT LastName
	FROM Person.Person
)
GROUP BY FirstName;

SELECT * FROM Sales.Customer;

SELECT * FROM Person.Person;

SELECT * FROM Sales.SalesOrderHeader;

SELECT * FROM Person.BusinessEntityContact;

SELECT * FROM Sales.Customer;

SELECT p.FirstName, p.LastName
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c
	ON soh.CustomerID = c.CustomerID
JOIN Person.BusinessEntityContact AS bec
	ON c.PersonID = bec.PersonID
JOIN Person.person AS p
	ON bec.BusinessEntityID = p.BusinessEntityID;
	
SELECT bec.BusinessEntityID
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c
	ON soh.CustomerID = c.CustomerID
JOIN Person.BusinessEntityContact AS bec
	ON c.PersonID = bec.PersonID;
