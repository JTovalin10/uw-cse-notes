## Introduction to Database Design
Database Design or Logical Design or Relational Schema Design
organizes data by considering what data needs to be stored and the
interrelationship of the data.
## ER Diagrams
### Introduction
ER Diagrams visuallyh describe:
1. the data
2. its interrelationships
![[ER Model Relationship Example.png]]
- Why ER Diagrams
	- Our application will use an entity relationship (ER) diagram to conceptualize and communicate its design
		- they are rigorous, so we can easily and cleanly map its concepts into code
		- they rare standardized, so we can communicate its ideas and solicit design feedback
### Components
#### Entity Sets and Attributes
![[ER Diagram Building Blocks.png]]
- entity set is like a class
	- a description of the data
- An attribute is like a class's field
- an entity is like a specific object
	- an actual piece of data; corresponds to a specific row
![[ER Diagrams Example.png]]
To create the table as the example we would do
```SQL
CREATE TABLE (
	ssn INT PRIMARY KEY,
	name VARCHAR(...),
	address VARCHAR(...)
);
```
#### Relationships: multiplicity and multi-way
If A and B are entity sets, then a relationship is a subset of $A \times B$
![[Component Relationship.png]]
To create this we use foreign keys with
```SQL
CREATE TABLE example (
	pname VARCHAR(100) REFERENCES example2,
	cname VARCHAR(100) REFERENCES example3
);
```
Relationships can have attributes to, for example
a company makes a product

There are also different typers of relationshios
1. One-to-one
	1. when referencing the other table use UNIQUE REFERENCES
2. Many-to-one
	1. create a middle table that references the relationships, then whichever is the one part use UNIQUE REFERENCES and the other uses REFERENCES
3. many-to-many
	1. create a middle table that references relationships, unlike many-to-one all relations just use REFERENCES however the PRIMARY Key is all the foreign keys
```SQL
CREATE TABLE Purchase (
cname VARCHAR(100) REFERENCES Company,
pname VARCHAR(100) REFERENCES Product,
bname INT REFERENCES Buyer,
PRIMARY KEY (cname, pname, bname),
...);
```
![[Relationship Multiplictrty.png]]

Multi-way relatiobships
If A, B, and C are sets then a relation R is a subset of $A \times B \times C$
#### Subclassing and Weak Entity Sets
An entity set may be a  subclass of another entity set. thios means it implicitry inherits all the attributes, keys, and relationships of the superclass. In SQL we reporesent this via FOREIGN KEYS

Weak entity set
The key of a weak entity set includes the key fro another entity set
- implifying that subclasses are weak entities
the weak entity set and its relationship to the other (entity set's) key are both depicted with double-outlines
![[weak entity set.png]]
```SQL
CREATE TABLE University(
name VARCHAR(64) PRIMARY KEY,
size INTEGER);
CREATE TABLE Team(
tname VARCHAR(64),
uname VARCHAR(64) REFERENCES University,
sport VARCHAR(64),
PRIMARY KEY (tname, uname));
```
#### Union Types
- Sometimes you want to refer to the union of two entity sets
	- an entity set has a relationship with ES1 xor ES2
- When creating an ER diagram include edge cases such as if people can own multiple of the item or sucvh in whcih you would then need to adjust the diagram or add a unqiue key to convey this
### Integrity Constraints
- CHECK(condition)
	- tells DBMS to ensure condition is always true
- can place on
	- single attribute
	- single tuples
```SQL
CREATE TABLE User (
uid INT PRIMARY KEY,
firstName VARCHAR(32),
lastName VARCHAR(32),
age INT CHECK (age > 12 AND age < 120), // attribute constraint
email VARCHAR(64),
phone VARCHAR(32),
CHECK (email IS NOT NULL OR phone IS NOT NULL) // tuple constraint
);
```
##### Global Assertions
```SQL
CREATE ASSERTION myAssert CHECK
(NOT EXISTS (
SELECT Product.name
FROM Product, Purchase
WHERE Product.name = Purchase.prodName
GROUP BY Product.name
HAVING COUNT(*) > 200)
);
```
These are expensive for DBMS to check and rarely useed in practice

With foreign keys we want to ensure that the data is maintained when updating or deleting a row. Hence we can use ON UPDATE/DELTE pllus:
1. NO ACTION (default): throw an error
2. CASCADE: Update/delete referencers
3. SET NULL: set referencer's field to NULL
4. SET DEFAULT: set referenceer's field to their default
	1. asssumes default value was set during table createion
## Getting Design Wrong
