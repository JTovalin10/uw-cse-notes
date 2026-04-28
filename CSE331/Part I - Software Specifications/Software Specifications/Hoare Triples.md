# CSE331: Hoare Triples

A **Hoare Triple** is a structure used in [[Floyd Logic]] to reason about program correctness. It consists of two assertions surrounding a piece of code.

```c
{{ P }}   // precondition
  S       // code
{{ Q }}   // postcondition
```

- A Hoare triple has **two assertions and some code**.
- The triple is **valid** if the code is correct:
  - Given `S`, we have $P \rightarrow Q$ (if `P` holds before `S` runs, then `Q` holds after).
  - Otherwise, the triple is false.

## Hoare Triples with No Code

```c
{{ P }}   // precondition
{{ Q }}   // postcondition
```

When is such a triple valid?
- It is valid when $P \rightarrow Q$.
- We can establish this using proof by calculation.

## Hoare Triples With Code

- We can use **forward and backward reasoning**.
- Move the assertions toward each other until they meet in the middle.

## Hoare Triples With Multiple Lines of Code

```c
{{ P }}
   S
{{ R }}
   T
{{ Q }}
```

- Valid **iff** there exists an `R` making both triples valid.

## Moving Forward / Backward

Forward and backward reasoning fill in missing assertions.

- **Forward reasoning**
  - Fills in the **postcondition**.
  - Gives the **strongest** postcondition making the triple valid.
  - Professionals are extremely fast at this (described as "Olympic athletes of forward reasoning").
- **Backward reasoning**
  - Fills in the **precondition**.
  - Gives the **weakest** precondition making the triple valid.
  - Mechanically simpler than forward reasoning — no subscripts needed.

See [[Stronger Assertions]] and [[Propositions]] for what "stronger" and "weaker" mean in this context.

## Forward Reasoning Rule for Assignments

```
{{ P }}
x = y;
{{ P[x ↦ xk] and x = y[x ↦ xk] }}
```

Replace all `x` in `P` and in `y` with a fresh subscripted name `xk`. If the assignment is invertible (e.g., `x = x0 + 1` means `x0 = x - 1`), you can avoid the subscript by substituting directly.

**Example:** Given `{{ n ≥ 1 }}` and `n = n + 3;`, forward reasoning gives `{{ n - 3 ≥ 1 }}` (i.e., `{{ n ≥ 4 }}`), since the old value `n0 = n - 3` must have been ≥ 1.

## Backward Reasoning Rule for Assignments

```
{{ Q[x ↦ y] }}
x = y;
{{ Q }}
```

Just substitute `y` everywhere `x` appears in `Q`. No subscripts required.

**Example:** Given postcondition `{{ n² ≥ 10 }}` and assignment `n = n + 3;`, backward reasoning gives `{{ (n+3)² ≥ 10 }}` as the required precondition.

## Combining Forward and Backward

Can use both at once on longer code, meeting in the middle:

```
{{ P }}
S
{{ R1 }}     ← forward reasoning from P through S
{{ R2 }}     ← backward reasoning from Q through T
T
{{ Q }}
```

Only need to check that `R1 ⇒ R2` (a Hoare triple with no code).

## Using Forward Reasoning for Correctness

```
{{ P }}       ← given
S
{{ R }}       ← computed by forward reasoning (always valid)
{{ Q }}       ← check: does R imply Q?
```

If `R ⇒ Q`, the code is correct. If not, the code has a bug (since `R` is the strongest possible postcondition).

## Using Backward Reasoning for Correctness

```
{{ P }}       ← check: does P imply R?
{{ R }}       ← computed by backward reasoning (always valid)
S
{{ Q }}       ← given
```

If `P ⇒ R`, the code is correct.

## Related

- [[Floyd Logic]] — the broader reasoning framework
- [[Forward and Backward Reasoning]] — complete rules and worked examples
- [[Pre and Post Conditions]] — how preconditions and postconditions appear in method specs
- [[Stronger Assertions]] — assertion strength
- [[Propositions]] — strengthening/weakening pre- and postconditions
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]] — collecting facts in code
