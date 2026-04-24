# CSE 332: NP-Completeness

To study whether $P=NP$, we identify the "hardest" problems in $NP$.

**[[NP-Hard]]**: A problem $B$ is NP-Hard if *every* problem within $NP$ reduces to $B$ in polynomial time. If any NP-Hard problem can be solved in polynomial time, then all $NP$ problems can be solved in polynomial time (meaning $P=NP$).

**[[NP-Complete]]**: The intersection of $NP$ and $NP-Hard$. These are the "together they stand, together they fall" problems. They are all problems in $NP$ that can be transformed into each other in polynomial time.
- If *any* one $NP-Complete$ problem belongs to $P$, then $P = NP$.
- If *any* one $NP-Complete$ problem is outside $P$, then $P \neq NP$.

To show a problem is $NP-Complete$:
1. Show it belongs to $NP$ (provide a polynomial time verifier).
2. Show it is $NP-Hard$ (provide a polynomial time reduction from another known $NP-Hard$ problem).

Examples of $NP-Complete$ problems:
- **[[Independent Set]]**: Given a graph $G$ and number $k$, is there a set of $k$ nodes where no two share an edge?
- **[[Vertex Cover]]**: Given a graph $G$ and number $k$, is there a set of $k$ nodes such that every edge has at least one endpoint in the set?

## Related
- [[P And NP]]
- [[Reductions]]
