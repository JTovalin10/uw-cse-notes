# SQL: Sparse Matrix Algebra

## Introduction
Represent every non-zero entry by its row index, column index, and value.
![[Linear Algebra on Sparse Matrices.png]]

These techniques generalize beyond matrices:
- Sparse array: A(index, value)
- Sparse matrix: M(row, column, value)
- Sparse 3-d tensor: T(i, j, k, value)
- Sparse 7-d tensor

## Multiplication
Matrix multiplication = [[Joins|join]] + [[Aggregates#GROUP BY|GROUP BY]]
$$
C = A \times B \equiv C_{ik} = \sum_{j}A_{ij} \times B_{jk}
$$
In SQL:
```SQL
SELECT A.row, B.col, SUM(A.val * B.val)
FROM A, B
WHERE A.col = B.row
GROUP BY A.row, B.col;
```

## Addition
Surprisingly, $A + B$ is harder because we need to handle [[NULL]]s.

**[[Outer Joins]] approach:**
```SQL
SELECT (CASE WHEN A.row IS NULL THEN B.row ELSE A.row END) AS row,
	(CASE WHEN A.col IS NULL THEN B.col ELSE A.col END) AS col,
	(CASE WHEN A.val IS NULL THEN 0 ELSE A.val END)
	+ (CASE WHEN B.val IS NULL THEN 0 ELSE B.val END) AS val
FROM A
FULL OUTER JOIN B ON A.row = B.row AND A.col = B.col;
```

**[[Aggregates#GROUP BY|GROUP BY]] approach:**
```SQL
SELECT m.row, m.col, SUM(m.val)
FROM (SELECT * FROM A
	  UNION ALL
	  SELECT * FROM B) AS m
GROUP BY m.row, m.col;
```
