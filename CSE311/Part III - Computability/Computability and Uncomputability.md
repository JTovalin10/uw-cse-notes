# CSE 311: Computability and Uncomputability

## Cardinality
Two sets $A$ and $B$ have the same **cardinality** ($|A| = |B|$) if there is a 1-to-1 (injective) and onto (surjective) function $f : A \to B$ (a bijection).
- A set $S$ is **countable** iff it has the same cardinality as some subset of the natural numbers $\mathbb{N}$.
- Examples of countable sets: $\mathbb{N}$, $\mathbb{Z}$, $\mathbb{Q}$, $\Sigma^*$ (strings over a finite alphabet), the set of all Java programs.
- **Cantor's Theorem:** The set of real numbers between 0 and 1 is not countable (uncountable). Proved using **diagonalization**.
- The set of all functions $f : \mathbb{N} \to \{0, \ldots, 9\}$ is uncountable.

## The Halting Problem
Because the set of Java programs is countable, but the set of functions is uncountable, there must be functions that cannot be computed by any program.

**The Halting Problem:** Given the code of a program $P$ and an input $x$, output `true` if $P$ halts on input $x$, and `false` if $P$ loops forever.
**Theorem (Turing):** There is no program that solves the Halting Problem. It is **undecidable**.
- The proof uses diagonalization: Assume a program $H$ solves it. Construct a program $D$ that takes program $P$ as input, runs $H(P, P)$, and if $H$ says $P$ halts, $D$ loops forever; if $H$ says $P$ loops, $D$ halts. If we run $D(D)$, we get a contradiction.

## Reductions and Rice's Theorem
We can prove other problems are undecidable by **reducing** the Halting Problem to them (i.e., showing that if a program could decide problem $B$, we could use it to decide the Halting Problem).
- Example: The CSE 121 Grading Problem (does a program output "HELLO" and exit?) is undecidable.
- **Rice's Theorem:** Any "non-trivial" property of the input-output behavior of Java programs is undecidable. This implies that perfect static analysis and compilation checks are impossible.
