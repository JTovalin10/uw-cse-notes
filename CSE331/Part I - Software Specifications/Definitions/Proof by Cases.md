# Proof by Cases

Sometimes it is necessary to split a proof into different cases. This is because a fact may be hard to prove for all values at once, but easy to prove in separate subsets of values.

For example, we might not be able to prove a claim for all $x$ at once, but we can prove it if $x \ge 0$ and separately if $x < 0$.

If we can prove it in those two cases, then it holds for all $x$ because those cases are **exhaustive** (see [[CSE331/Part I - Software Specifications/Definitions/Exclusive and Exhaustive|Exclusive and Exhaustive]]). 

- We don't need cases to be mutually exclusive, only exhaustive.
- We can pick any cases we want, not just the cases explicitly present in the code.
- If the code contains branches (like an `if` statement), we often use the branch conditions as our cases, proving the postcondition holds in the "then" branch and separately in the "else" branch.
