USE adventureworks;

SELECT * FROM Sales.Currency
ORDER BY CurrencyCode DESC;

INSERT INTO Sales.Currency
VALUES ('ZZZ', 'Fred Currency', '2008');

-- simplest update

UPDATE Sales.Currency
SET ModifiedDate = '2012';

-- update by some condition

UPDATE Sales.Currency
SET ModifiedDate = '2016'
WHERE CurrencyCode = 'ZZZ';

DELETE FROM Sales.Currency
WHERE CurrencyCode = 'ZZZ' and ModifiedDate > '2008';
