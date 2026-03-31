# Database Design: Integrity Constraints

Integrity constraints let the DBMS enforce application-level rules on the data automatically, beyond what foreign keys alone can express.

## CHECK Constraints

`CHECK(condition)` tells the DBMS to ensure a condition is always true.

Can be placed on:
- A **single attribute** (attribute-level constraint)
- A **single tuple** (tuple-level constraint)

```SQL
CREATE TABLE User (
	uid INT PRIMARY KEY,
	firstName VARCHAR(32),
	lastName VARCHAR(32),
	age INT CHECK (age > 12 AND age < 120),           -- attribute constraint
	email VARCHAR(64),
	phone VARCHAR(32),
	CHECK (email IS NOT NULL OR phone IS NOT NULL)    -- tuple constraint
);
```

## Global Assertions

`CREATE ASSERTION` enforces a condition over the entire database, not just one table or row:

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

Global assertions are expensive for the DBMS to check after every update and are rarely used in practice.

## Referential Integrity on Update/Delete

With foreign keys, we need to decide what happens when a referenced row is updated or deleted:

| Action | Behavior |
|---|---|
| `NO ACTION` (default) | Throw an error — disallow the update/delete |
| `CASCADE` | Update/delete all referencing rows automatically |
| `SET NULL` | Set the referencing field to NULL |
| `SET DEFAULT` | Set the referencing field to its declared default value |

```SQL
CREATE TABLE Registry (
	UserID INT REFERENCES Payroll ON DELETE CASCADE ON UPDATE CASCADE,
	Car VARCHAR(100)
);
```

## Related
- [[Entities, Relationships, and ER Diagrams]] — where constraints are identified during design
- [[CSE344/SQL/Create Table]] — full SQL syntax for table creation including constraints
- [[CSE344/SQL/NULL]] — how NULL interacts with CHECK constraints
