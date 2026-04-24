# CSE 332: Complexity Classes

**Tractable**: A problem that is feasible to solve in the "real world" (e.g., $O(n)$, $O(n^2)$).
**Intractable**: A problem that is infeasible to solve in the "real world" (e.g., $O(2^n)$, $O(n!)$).

A **Complexity Class** is a set of problems whose most efficient algorithm has a specific upper bound on its running time.

- **[[Class P]]**: "Polynomial" time. The set of problems which have an algorithm whose running time is $O(n^p)$ for some constant $p$. We consider all problems in $P$ to be tractable. Examples: Sorting, Shortest Path, Euler Path.
- **Class EXP**: "Exponential" time. The set of problems bounded by $O(2^{n^p})$. Problems in $EXP$ but not in $P$ are intractable. Examples: Hamiltonian Path, Vertex Cover, Independent Set, Satisfiability.
  
Note that $P \subset EXP$. Since membership in $P$ is determined by the *most efficient* possible algorithm, knowing if a problem in $EXP$ is also in $P$ is often very difficult!

## Related
- [[P And NP]]
- [[NP-Completeness]]
- [[CSE311 Index|Math: Mathematical Foundations]]
