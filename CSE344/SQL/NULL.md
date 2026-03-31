# SQL: NULL

- A **NULL** value means missing, unknown, undefined, or inapplicable

## Predicate Evaluation
A predicate can evaluate to:
- **False**: 0
- **Unknown**: 0.5
- **True**: 1

## Three-Valued Logic
- A op B is defined as:
	- False or True when both A and B are not null
	- **Unknown** otherwise
- Rules:
	- A AND B = min(A, B)
	- A OR B = max(A, B)
	- NOT A = 1 - A
- SQL only returns tuples whose condition evaluates to **True** (not Unknown)
![[three-value logic.png]]

## Related
- [[Aggregates]] — aggregate functions skip NULL values (except COUNT(*))
- [[Outer Joins]] — outer joins pad unmatched rows with NULLs
- [[Sparse Matrix Algebra#Addition]] — sparse matrix addition must handle NULLs
