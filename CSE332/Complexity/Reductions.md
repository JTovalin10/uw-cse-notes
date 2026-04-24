# CSE 332: Reductions

**[[Reduction]]**: A strategy for creating algorithms where you solve one problem by converting it into a different problem, then using an algorithm for that other problem. This demonstrates how two different problems relate to each other.

If there is a polynomial-time reduction from Problem A to Problem B, it means Problem B is at least as hard as Problem A. We can use a polynomial-time algorithm for B to solve A in polynomial time.

Example: **Independent Set reduces to Vertex Cover**
$S$ is an independent set of graph $G$ if and only if $V - S$ is a vertex cover of $G$.
1. Take the input for Independent Set ($G$ and $k$).
2. Transform it into an input for Vertex Cover in polynomial time ($O(V)$): use the same graph $G$, but ask for a vertex cover of size $|V| - k$.
3. Run the Vertex Cover algorithm.
4. Return the same boolean result.

Because this reduction exists in polynomial time, if we could solve Vertex Cover in polynomial time, we could solve Independent Set in polynomial time.

## Related
- [[NP-Completeness]]
