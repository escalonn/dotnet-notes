/*
USE master;
GO

CREATE DATABASE PizzaDB;
GO

USE PizzaDB;
GO
*/

/*
CREATE SCHEMA Pizza;
GO

CREATE TABLE Pizza.Topping
(
	ToppingID INT NOT NULL IDENTITY(1,1) PRIMARY KEY
);
GO
*/

CREATE TABLE Pizza.Topping
(
	ToppingID INT NOT NULL IDENTITY(1,1), --PRIMARY KEY, --TINYINT, SMALLINT, INT, BIGINT
	Name NVARCHAR(100) NOT NULL, --CHAR, VARCHAR, NCHAR, NVARCHAR
	ModifiedDate DATETIME2(0) NOT NULL, --DATE, TIME, DATETIME, DATETIME2
	Active BIT NOT NULL --DEFAULT(1)
);
GO

CREATE TABLE Pizza.Crust
(
	CrustID INT NOT NULL IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2(0) NOT NULL,
	Active BIT NOT NULL
);
GO

CREATE TABLE Pizza.Pizza
(
	PizzaID INT NOT NULL IDENTITY,
	CrustID INT NULL,
	Name NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2(0) NOT NULL,
	Active BIT NOT NULL
);
GO

CREATE TABLE Pizza.PizzaTopping
(
	PizzaToppingID INT NOT NULL IDENTITY,
	PizzaID INT NOT NULL,
	ToppingID INT NOT NULL,
	Active BIT NOT NULL
);
GO

--primary key
ALTER TABLE Pizza.Crust
	ADD CONSTRAINT PK_Crust_CrustID PRIMARY KEY CLUSTERED (CrustID);

ALTER TABLE Pizza.Pizza
	ADD CONSTRAINT PK_Pizza_PizzaID PRIMARY KEY CLUSTERED (PizzaID);

ALTER TABLE Pizza.PizzaTopping
	ADD CONSTRAINT PK_PizzaTopping_PizzaToppingID PRIMARY KEY CLUSTERED (PizzaToppingID);
	
ALTER TABLE Pizza.Topping
	ADD CONSTRAINT PK_Topping_ToppingID PRIMARY KEY CLUSTERED (ToppingID);

--foreign key
ALTER TABLE Pizza.Pizza
	ADD CONSTRAINT PK_Pizza_CrustID FOREIGN KEY (CrustID) REFERENCES Pizza.Crust(CrustID) ON UPDATE CASCADE;

ALTER TABLE Pizza.PizzaTopping
	ADD CONSTRAINT PK_PizzaTopping_PizzaID FOREIGN KEY (PizzaID) REFERENCES Pizza.Pizza(PizzaID) ON UPDATE CASCADE;

ALTER TABLE Pizza.PizzaTopping
	ADD CONSTRAINT PK_PizzaTopping_ToppingID FOREIGN KEY (ToppingID) REFERENCES Pizza.Topping(ToppingID) ON UPDATE CASCADE;

--default
ALTER TABLE Pizza.Pizza
	ADD CONSTRAINT DF_Pizza_Active DEFAULT(1) FOR Active;

ALTER TABLE Pizza.Crust
	ADD CONSTRAINT DF_Crust_Active DEFAULT(1) FOR Active;

ALTER TABLE Pizza.Topping
	ADD CONSTRAINT DF_Topping_Active DEFAULT(1) FOR Active;

ALTER TABLE Pizza.PizzaTopping
	ADD CONSTRAINT DF_PizzaTopping_Active DEFAULT(1) FOR Active;

--check
ALTER TABLE Pizza.Pizza
	ADD CONSTRAINT CK_Pizza_ModifiedDate CHECK (ModifiedDate <= GETDATE()); --SYSUTCDATETIME

--computed
ALTER TABLE Pizza.Pizza
	ADD ComputedName AS (Name + '-' + CrustID) PERSISTED;
GO

--view
CREATE VIEW Pizza.VW_Toppings WITH SCHEMABINDING
AS
SELECT Name
FROM Pizza.Topping
WHERE Active = 1;
GO

--function
CREATE FUNCTION Pizza.FN_Toppings()
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @ret NVARCHAR(MAX);

	SELECT TOP(1) @ret = Name
	FROM Pizza.Topping;

	RETURN @ret;
END
GO

CREATE FUNCTION Pizza.FN_ToppingsStatus(@status BIT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @ret NVARCHAR(MAX);

	SELECT TOP(1) @ret = Name
	FROM Pizza.Topping
	WHERE Active = @status;

	RETURN @ret;
END
GO

CREATE FUNCTION Pizza.FN_ToppingsTable()
RETURNS TABLE
AS
RETURN
SELECT Name
FROM Pizza.Topping;
GO

CREATE FUNCTION Pizza.FN_ToppingsTableStatus(@status BIT)
RETURNS TABLE
AS
RETURN
SELECT Name
FROM Pizza.Topping
WHERE Active = @status;
GO

--stored procedure
DROP PROCEDURE Pizza.SP_Toppings;
GO
CREATE PROCEDURE Pizza.SP_Toppings(@topping NVARCHAR(50), @something NVARCHAR(MAX) OUT)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @topid INT;

		SELECT @topid = ToppingID
		FROM Pizza.Topping
		WHERE Name = @topping;
	
		IF @topid IS NOT NULL
		BEGIN
			UPDATE Pizza.Topping
			SET Name = @topping
			WHERE ToppingID = @topid;

			--RAISERROR('this is an error', 16, 1)
			SET @something = 'variable';
			
			COMMIT TRANSACTION;
			--RETURN
				--SELECT @topid = ToppingID
				SELECT *
				FROM Pizza.Topping
				WHERE Name = @topping;
		END
		ELSE
		BEGIN
			SET IDENTITY_INSERT Pizza.Topping ON;
			INSERT INTO Pizza.Topping(ToppingID, Name, ModifiedDate, Active)
			VALUES (2, @topping, GETUTCDATE(), 1);

			--THROW 50001, 'this is another error', 1;
			COMMIT TRANSACTION;
		END
		SET IDENTITY_INSERT Pizza.Topping OFF;
	END TRY
	BEGIN CATCH
		PRINT @@ERROR;
		PRINT ERROR_MESSAGE();
		PRINT ERROR_STATE();
		PRINT ERROR_NUMBER();
		PRINT ERROR_SEVERITY();
		PRINT @@ROWCOUNT;
		PRINT @@TRANCOUNT;
		ROLLBACK TRANSACTION;
	END CATCH;
END
GO

-- use procedure, function, view
DECLARE @response NVARCHAR(MAX);
EXECUTE Pizza.SP_Toppings 'pepperoni', @response out;
PRINT @response;

SELECT * FROM Pizza.Topping;
--DELETE FROM Pizza.Topping;

SELECT * FROM Pizza.FN_ToppingsTableStatus(1);

PRINT Pizza.FN_ToppingsStatus(1);
SELECT Pizza.FN_ToppingsStatus(1);

SELECT * FROM Pizza.VW_Toppings;
GO

DROP PROCEDURE SP_Test;
GO
CREATE PROCEDURE SP_Test
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @topid INT;
		IF 1 = 1
		BEGIN
			SELECT * FROM Pizza.Topping;
		END
		ELSE
		BEGIN
			PRINT 1;
		END
	END TRY
	BEGIN CATCH
	END CATCH
	COMMIT TRANSACTION;
	SET IDENTITY_INSERT Pizza.Topping OFF;
END
GO
EXECUTE SP_Test;
GO

/*
CREATE TABLE Pizza.PizzaTopping
(
	PizzaID INT NOT NULL PRIMARY KEY,
	CrustID INT NOT NULL PRIMARY KEY,
	Cardinality INT NOT NULL DEFAULT(1)
);
GO
*/

--drop and truncate
/*
TRUNCATE TABLE Pizza.Topping;
DROP TABLE Pizza.Topping;
*/

CREATE TRIGGER Pizza.TR_Topping ON Pizza.Topping
FOR UPDATE
AS
SELECT * FROM Pizza.Pizza;

UPDATE Pizza.Topping
SET Name = 'peppers'
WHERE Name = 'pepperoni';

UPDATE Pizza.Topping
SET Name = 'pepperoni'
WHERE Name = 'peppers';

SELECT * FROM Pizza.Topping;
GO

DROP TRIGGER Pizza.TR_ToppingIO;
GO
CREATE TRIGGER Pizza.TR_ToppingIO ON Pizza.Topping
INSTEAD OF UPDATE
AS
IF EXISTS(SELECT 1 FROM INSERTED)
BEGIN
	SELECT * FROM DELETED;
	SELECT * FROM INSERTED;
END
	SELECT * FROM Pizza.Topping;
	
DECLARE @TempTable TABLE(Name NVARCHAR(MAX));
DECLARE @@TempTable TABLE(Name NVARCHAR(MAX));

UPDATE Pizza.Topping
SET Name = 'pepperoni'
OUTPUT INSERTED.Name INTO @TempTable
WHERE Name = 'peppers';

SELECT * FROM @TempTable;
SELECT * FROM @@TempTable;