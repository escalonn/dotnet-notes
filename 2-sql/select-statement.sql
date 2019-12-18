USE adventureworks;

--              the table
--  columns
SELECT * FROM Person.Person;

-- only the columns we want
SeLeCt FirstName, LastName
from Person.Person;

-- only the columns i want, only the rows i want
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName = 'Adams';

SELECT FirstName, LastName
FROM Person.Person
WHERE LastName >= 'A' and LastName < 'D';

-- 
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName like '[AB]%';

SELECT COUNT(*)
FROM Person.Person
WHERE LastName = 'Adams';

SELECT * FROM Sales.SalesOrderDetail;

-- total number of product 776 ordered ever
SELECT SUM(OrderQty)
FROM Sales.SalesOrderDetail
WHERE ProductID = 776;


SELECT COUNT(FirstName) as [dupe-count], FirstName, LastName
FROM Person.Person
WHERE LastName < 'B'
GROUP BY LastName, FirstName
HAVING COUNT(FirstName) > 1;

-- SELECT statement execution order

-- from
-- where
-- group by
-- having
-- select
-- order by

SELECT *
FROM Person.Person
ORDER BY LastName DESC;


