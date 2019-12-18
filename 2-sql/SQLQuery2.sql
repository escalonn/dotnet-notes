SELECT * FROM SalesLT.Address;

--simple INSERT
INSERT INTO SalesLT.Address
VALUES ('123 main st', null, 'reston', 'virginia', 'usa', '20190', '268AF621-76D7-4C78-9441-144FD139821F', '2017-12-13');

--normal INSERT
INSERT INTO SalesLT.Address(ModifiedDate, AddressLine1, City, StateProvince, CountryRegion, PostalCode, rowguid)
VALUES
('2017-12-13', '197 main st', 'reston', 'virginia', 'usa', '20190', '268AF621-76D7-4C78-9441-144FD139821D'),
('2017-12-13', '312 main st', 'reston', 'virginia', 'usa', '20190', '268AF621-76D7-4C78-9441-144FD139821C'),
('2017-12-13', '509 main st', 'reston', 'virginia', 'usa', '20190', '268AF621-76D7-4C78-9441-144FD139821B');

--enhanced INSERT
INSERT INTO SalesLT.Address(ModifiedDate, AddressLine1, City, StateProvince, CountryRegion, PostalCode)
SELECT ModifiedDate AS Epoch, AddressLine1 AS Street1, City AS Town, StateProvince, CountryRegion, PostalCode
FROM SalesLT.Address
WHERE ModifiedDate = '2006-07-01';

--bulk INSERT
BULK INSERT SalesLT.Address FROM 'C:\\Users\\Nicholas\\Documents\\Work Notes\\data.csv' WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');

--simple UPDATE
UPDATE SalesLT.Address
SET AddressLine2 = 'plaza america';

--simple DELETE
--DELETE from SalesLT.Address;

--normal UPDATE
SELECT *
FROM SalesLT.Address
WHERE ModifiedDate = '2006-07-01';

UPDATE SalesLT.Address
SET AddressLine2 = 'revature'
WHERE ModifiedDate = '2006-07-01';

--normal DELETE
DELETE FROM SalesLT.Address
WHERE ModifiedDate = '12-13-2017';

--enhanced UPDATE
UPDATE a
SET a.AddressLine2 = 'dotnet'
FROM SalesLT.Address as a
WHERE a.AddressLine2 = 'plaza america';

DELETE FROM a
FROM SalesLT.Address as a
WHERE a.ModifiedDate = '12-13-2017';
