# CSE344: Create Table

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
	- **Strings**: CHAR, VARCHAR, TEXT
	- **Numbers**: INT, SMALLINT, FLOAT, MONEY, DATETIME
- Types are **statically** and **strictly** enforced by the DBMS

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

## Related
- [[Basics#Keys]] — conceptual overview of keys and foreign keys
- [[Joins]] — foreign keys are the basis for most joins
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — CHECK constraints, assertions, and ON DELETE/UPDATE behavior
- [[CSE344/Database Design/Entities, Relationships, and ER Diagrams|Entities, Relationships, and ER Diagrams]] — how schemas are designed before creating tables
- [[CSE344/Database Design/Normalization|Normalization]] — refining a schema into a good CREATE TABLE form
- [[CSE344/Database Design/Password Handling|Password Handling]] — SQL injection and how to store sensitive columns safely
