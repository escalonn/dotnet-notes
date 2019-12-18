use nicholassqlweek;
go

select *
from SalesLT.Customer;

select *
from SalesLT.Customer
where firstname = 'john';

select *
from SalesLT.Customer
where firstname = 'john' and firstname = 'arthur';

-- all with name john that are not arthur and all arthur.
select *
from SalesLT.Customer
where firstname = 'john' and lastname != 'arthur' or firstname = 'arthur';

select *
from SalesLT.Customer
where firstname > 'j';

select *
from SalesLT.Customer
where firstname >= 'j' and firstname < 'k';

select *
from SalesLT.Customer
where firstname like '%j%' and firstname like '%o%';

select *
from SalesLT.Customer
where firstname like '___' and firstname like '%j%';

select *
from SalesLT.Customer
where firstname like '[jo]__';

select COUNT(*), Title
from SalesLT.Customer
where firstname = 'john' and lastname = 'arthur'
group by Title;

select COUNT(*), Title
from SalesLT.Customer
where firstname like 'j%'
group by Title;

select COUNT(Title), Title
from SalesLT.Customer
where firstname like 'j%'
group by Title;

select COUNT(*) as [Count], Title as "Greeting"
from SalesLT.Customer
where firstname like 'j%'
group by Title;

SELECT COUNT(FirstName), FirstName, LastName
FROM SalesLT.Customer
WHERE FirstName = 'John'
GROUP BY LastName, FirstName
HAVING COUNT(FirstName) >= 0;

SELECT COUNT(FirstName), FirstName, LastName
FROM SalesLT.Customer
WHERE FirstName = 'John'
GROUP BY LastName, FirstName, CompanyName
HAVING COUNT(FirstName) >= 0
ORDER BY CompanyName ASC, LastName DESC;

SELECT COUNT(FirstName) as [count], FirstName as FN, LastName as LN, CompanyName as CN
FROM SalesLT.Customer
WHERE FirstName = 'John'
GROUP BY LastName, FirstName, CompanyName
HAVING COUNT(FirstName) >= 0
ORDER BY CN ASC, LN DESC;

--Execution
--from
--where
--group by
--having
--select
--order by