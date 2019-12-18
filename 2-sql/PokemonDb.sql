CREATE TABLE Pokemon (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(64) NOT NULL UNIQUE,
	Height INT NOT NULL,
	Weight INT NOT NULL
);

CREATE TABLE Type (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(64) NOT NULL UNIQUE
);

CREATE TABLE PokemonType (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	PokemonId INT NOT NULL FOREIGN KEY REFERENCES Pokemon (Id)
        ON DELETE CASCADE,
	TypeId INT NOT NULL FOREIGN KEY REFERENCES Type (Id)
        ON DELETE CASCADE
);

INSERT INTO Pokemon (Name, Height, Weight) VALUES
	('Bulbasaur', 7, 69),
	('Ditto', 3, 40);

INSERT INTO Type (Name) VALUES
	('Normal'),
	('Grass');

INSERT INTO PokemonType (PokemonId, TypeId) VALUES
	((SELECT Id FROM Pokemon WHERE Name = 'Bulbasaur'),
		(SELECT Id FROM Type WHERE Name = 'Grass')),
	((SELECT Id FROM Pokemon WHERE Name = 'Ditto'),
		(SELECT Id FROM Type WHERE Name = 'Normal'));

SELECT p.*, pt.*, t.*
FROM Pokemon AS p
    FULL JOIN PokemonType AS pt ON p.Id = pt.PokemonId
    FULL JOIN Type AS t ON pt.TypeId = t.Id;