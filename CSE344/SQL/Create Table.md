# SQL: Create Table

## Syntax
```SQL
CREATE TABLE Payroll (
	UserID INT,
	Name VARCHAR(100),
	...
);
```

## Data Types
- Each attribute has a type
	- Strings: CHAR, VARCHAR, TEXT
	- Numbers: INT, SMALLINT, FLOAT, MONEY, DATETIME
- They are statically and strictly enforced

## Keys
### Primary Key
```SQL
CREATE TABLE Payroll (
	UserID INT PRIMARY KEY,
	Name VARCHAR(100),
	...
);
```
Or using a table-level constraint:
```SQL
CREATE TABLE Payroll (
	UserID INT,
	Name VARCHAR(100),
	...
	PRIMARY KEY (UserID)
);
```

### Foreign Key
- References a [[Basics#Keys|key]] in another table
```SQL
CREATE TABLE Registry (
	UserID INT,
	Car VARCHAR(100),
	FOREIGN KEY (UserID) REFERENCES Payroll
);
```
