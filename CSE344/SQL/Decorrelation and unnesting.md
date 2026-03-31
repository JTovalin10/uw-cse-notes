## Query Monotonicity
- A monotonic query q is one where, if I and J are data instances:
 $$
I \subseteq j \rightarrow q(I) \subseteq q(J)
$$

That is, for any superset of I the query over that superset must contain at least the query results of I.

In other words, addings more tuples to the input table never removes tuples from the output when q is re-executed
Theorm: If Q is a SELECT-FROM-WHERE query without subqueries and aggregates, then it is monotone
