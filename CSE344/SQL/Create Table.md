```SQL
CREATE TABLE Payroll (
UserID INT,
Name VARCHAR(100),
...
);
```
## Data Types
- Each attribute has a type
	- strings: CHAR, VARCHAR, TEXT
	- Numbers: INT, SMALLINT, FLOAT, MONEY, DATETIME
- they are statically and strictly enforced
## Keys
### Primary Key
```SQL
CREATE TABLE Payroll (
UserID INT PRIMARY KEY,
Name VARCHAR(100),
...
);
or 
CREATE TABLE Payroll (
UserID INT PRIMARY KEY,
Name VARCHAR(100),
...
PRIMARY KEY (UserID)
);
```
### Foreign Key
```SQL
CREATE TABLE Registry (
UserID INT,
Car VARCHAR(100),
FOREIGN KEY (UserID) REFERENCES Payroll);
```