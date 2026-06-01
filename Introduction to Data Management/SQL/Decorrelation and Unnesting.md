# SQL: Decorrelation and Unnesting

## Query Monotonicity
- A **monotonic query** q is one where, if I and J are data instances:
$$
I \subseteq J \rightarrow q(I) \subseteq q(J)
$$

That is, for any superset of I, the query over that superset must contain at least the query results of I.

In other words, adding more tuples to the input table never removes tuples from the output when q is re-executed.

**Theorem:** If Q is a SELECT-FROM-WHERE query without [[Sub-Queries|subqueries]] and [[Aggregates|aggregates]], then it is monotone
