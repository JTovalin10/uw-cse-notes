# CSE 332: P And NP

While some problems in $EXP$ don't have known polynomial-time algorithms to solve, their answers are easy to *check*. 
For instance, the **Hamiltonian Path Problem** asks if there is a path visiting every node exactly once. Finding a path takes exhaustive search $O(V!)$, but verifying a given sequence of nodes takes only polynomial time $O(V \cdot E)$.

- **[[Class P]]**: The set of problems solvable in polynomial time.
- **Class NP**: "Non-deterministic Polynomial" time. The set of problems for which a candidate solution can be **verified** in polynomial time. It corresponds to algorithms that can magically "guess" a solution and verify it efficiently.

Clearly, $P \subseteq NP$, because if you can solve a problem in polynomial time, you can verify it in polynomial time (by just solving it).

The most famous question in computer science: **Does P = NP?**
We know $P \subseteq NP \subseteq EXP$. 
If $P \neq NP$, some problems remain inherently intractable, and concepts like cryptography remain secure. If $P = NP$, we could efficiently solve major problems (like prime factorization and SAT), but cryptography would be compromised. 

## Related
- [[Complexity Classes]]
- [[NP-Completeness]]
