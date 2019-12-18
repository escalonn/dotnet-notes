-- Part I – Working with an existing database

-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.
-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
-- 2.1 SELECT
-- Task – Select all records from the Employee table.
SET search_path TO chinook,public;
SELECT * FROM employee;
-- Task – Select all records from the Employee table where last name is King.
SELECT * FROM employee
	WHERE lastname = 'King';
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
SELECT * FROM employee
	WHERE firstname = 'Andrew' AND reportsto IS NULL;
-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
SELECT * FROM album ORDER BY title DESC;
-- Task – Select first name from Customer and sort result set in ascending order by city
SELECT firstname FROM customer ORDER BY city;
-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
INSERT INTO genre (genreid) VALUES ( 26 );
INSERT INTO genre (genreid) VALUES ( 27 );
-- Task – Insert two new records into Employee table
INSERT INTO employee (employeeid, lastname, firstname)
	VALUES ((SELECT MAX(employeeid) FROM employee) + 1, '', '');
INSERT INTO employee (employeeid, lastname, firstname)
	VALUES ((SELECT MAX(employeeid) FROM employee) + 1, '', '');
-- Task – Insert two new records into Customer table
INSERT INTO customer (customerid, firstname, lastname)
	VALUES ((SELECT MAX(customerid) FROM customer) + 1, '', '');
INSERT INTO customer (customerid, firstname, lastname)
	VALUES ((SELECT MAX(customerid) FROM customer) + 1, '', '');
-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
UPDATE customer SET firstname = 'Robert', lastname = 'Walter'
	WHERE firstname = 'Aaron' AND lastname = 'Mitchell';
-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
UPDATE artist SET name = 'CCR'
	WHERE name = 'Creedence Clearwater Revival';
-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”
SELECT * FROM invoice
	WHERE billingaddress LIKE 'T%';
-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
SELECT * FROM invoice
	WHERE total BETWEEN 15 AND 50;
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
SELECT * FROM employee
	WHERE hiredate BETWEEN '2003-06-01' AND '2004-03-01';
-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
DELETE FROM invoice_items
	WHERE invoiceid IN (SELECT invoiceid FROM invoice
		WHERE customerid IN (SELECT customerid FROM customer
			WHERE firstname = 'Robert' AND lastname = 'Walter'));
DELETE FROM invoice
	WHERE customerid IN (SELECT customerid FROM customer
			WHERE firstname = 'Robert' AND lastname = 'Walter');
DELETE FROM customer
	WHERE firstname = 'Robert' AND lastname = 'Walter';
-- 3.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions
-- Task – Create a function that returns the current time.
CREATE FUNCTION current_time() RETURNS time AS $$
	SELECT localtime();
$$ LANGUAGE SQL;
-- Task – create a function that returns the length of a mediatype from the mediatype table
CREATE FUNCTION mediatype_length(mediatypeid integer) RETURNS integer AS $$
	SELECT char_length(name) FROM mediatype
		WHERE mediatypeid = $1;
$$ LANGUAGE SQL;
-- 3.2 System Defined Aggregate Functions
-- Task – Create a function that returns the average total of all invoices
CREATE FUNCTION invoice_total_average() RETURNS numeric AS $$
	SELECT avg(total) FROM invoice;
$$ LANGUAGE SQL;
-- Task – Create a function that returns the most expensive track
CREATE FUNCTION most_expensive_track() RETURNS track AS $$
	SELECT * FROM track
		WHERE unitprice = (SELECT max(unitprice) FROM track);
$$ LANGUAGE SQL;
-- 3.3 User Defined Scalar Functions
-- Task – Create a function that returns the average price of invoiceline items in the invoiceline table
CREATE FUNCTION invoiceline_price_average() RETURNS numeric AS $$
	SELECT avg(unitprice) FROM invoiceline;
$$ LANGUAGE SQL;
-- 3.4 User Defined Table Valued Functions
-- Task – Create a function that returns all employees who are born after 1968.
CREATE FUNCTION employees_born_after_1968() RETURNS SETOF employee AS $$
	SELECT * FROM employee
		WHERE EXTRACT(YEAR FROM birthdate) > 1968;
$$ LANGUAGE SQL;
-- 4.0 Stored Procedures
--  In this section you will be creating and executing stored procedures. You will be creating various types of stored procedures that take input and output parameters.
-- 4.1 Basic Stored Procedure
-- Task – Create a stored procedure that selects the first and last names of all the employees.
CREATE FUNCTION employees_first_and_last_names()
RETURNS TABLE(firstname varchar(20), lastname varchar(20)) AS $$
	SELECT employee.firstname, employee.lastname FROM employee;
$$ LANGUAGE SQL;
-- 4.2 Stored Procedure Input Parameters
-- Task – Create a stored procedure that updates the personal information of an employee.
CREATE FUNCTION update_employee_personal_info(employeeid integer,
	lastname varchar(20), firstname varchar(20), title varchar(30),
	birthdate timestamp, hiredate timestamp, address varchar(70),
	city varchar(40), state varchar(40), country varchar(40),
	postalcode varchar(10), phone varchar(24), fax varchar(24),
	email varchar(60))
RETURNS void AS $$
	UPDATE employee
		SET (lastname, firstname, title, birthdate, hiredate, address, city,
			state, country, postalcode, phone, fax, email) = ($2, $3, $4, $5,
			$6, $7, $8, $9, $10, $11, $12, $13, $14)
		WHERE employee.employeeid = $1;
$$ LANGUAGE SQL;
-- Task – Create a stored procedure that returns the managers of an employee.
CREATE FUNCTION employee_managers(employee) RETURNS SETOF employee AS $$
	SELECT * FROM employee WHERE employeeid = $1.reportsto;
$$ LANGUAGE SQL;
-- 4.3 Stored Procedure Output Parameters
-- Task – Create a stored procedure that returns the name and company of a customer.
CREATE FUNCTION customer_name_and_company(customerid integer,
	OUT firstname varchar(20), OUT lastname varchar(20),
	OUT company varchar(80))
AS $$
	SELECT customer.firstname, customer.lastname, customer.company
		FROM customer
		WHERE customer.customerid = $1;
$$ LANGUAGE SQL;
-- 5.0 Transactions
-- In this section you will be working with transactions. Transactions are usually nested within a stored procedure. You will also be working with handling errors in your SQL.
-- Task – Create a transaction that given a invoiceId will delete that invoice (There may be constraints that rely on this, find out how to resolve them).
CREATE FUNCTION invoice_delete(invoiceid integer) RETURNS void AS $$
	DELETE FROM invoiceline WHERE invoiceline.invoiceid = $1;
	DELETE FROM invoice WHERE invoice.invoiceid = $1;
$$ LANGUAGE SQL;
-- Task – Create a transaction nested within a stored procedure that inserts a new record in the Customer table
CREATE FUNCTION customer_insert(customer) RETURNS void AS $$
	INSERT INTO customer VALUES ( $1.* );
$$ LANGUAGE SQL;
-- 6.0 Triggers
-- In this section you will create various kinds of triggers that work when certain DML statements are executed on a table.
-- 6.1 AFTER/FOR
-- Task - Create an after insert trigger on the employee table fired after a new record is inserted into the table.
CREATE TRIGGER employee_after_insert
	AFTER INSERT ON employee
	EXECUTE PROCEDURE suppress_redundant_updates_trigger();
-- Task – Create an after update trigger on the album table that fires after a row is inserted in the table
CREATE TRIGGER album_after_update
	AFTER UPDATE ON album
	EXECUTE PROCEDURE suppress_redundant_updates_trigger();
-- Task – Create an after delete trigger on the customer table that fires after a row is deleted from the table.
CREATE TRIGGER customer_after_delete
	AFTER DELETE ON customer
	EXECUTE PROCEDURE suppress_redundant_updates_trigger();
-- 6.2 Before
-- Task – Create a before trigger that restricts the deletion of any invoice that is priced over 50 dollars.
CREATE FUNCTION skip_row_operation_trigger()
RETURNS trigger AS $$
BEGIN
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER restrict_high_total_invoice_delete
	BEFORE DELETE ON invoice
	FOR EACH ROW
	WHEN (OLD.total > 50)
	EXECUTE PROCEDURE skip_row_operation_trigger();
-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
SELECT c.firstname, c.lastname, i.invoiceid
	FROM customer AS c NATURAL JOIN invoice AS i;
-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
SELECT c.customerid, c.firstname, c.lastname, i.invoiceid, i.total
	FROM customer AS c NATURAL FULL JOIN invoice AS i;
-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.
SELECT artist.name, album.title
	FROM album NATURAL RIGHT JOIN artist;
-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
SELECT * FROM album CROSS JOIN artist ORDER BY artist.name;
-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.
SELECT * FROM employee AS e JOIN employee AS m ON e.reportsto = m.employeeid;
