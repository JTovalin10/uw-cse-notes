# CSE331: Forward and Backward Reasoning

**Forward and backward reasoning** are the two mechanical rules in [[Floyd Logic]] for propagating assertions through code. They allow you to verify a [[Hoare Triples|Hoare Triple]] by computing either the strongest postcondition (forward) or the weakest precondition (backward).

## Forward Reasoning

**Goal**: Given a precondition `P` before `x = y;`, compute the strongest postcondition.

**General rule:**

```
{{ P }}
x = y;
{{ P[x ↦ xk] and x = y[x ↦ xk] }}
```

Replace every occurrence of `x` in `P` and in `y` with a fresh subscripted name `xk` (representing the old value). If the assignment is invertible (e.g., `x = x0 + 1` implies `x0 = x - 1`), you can eliminate the subscript by substituting directly.

### Formal Definition

Given precondition $P$ and assignment $x := e$, the strongest postcondition is:

$$SP(P,\ x := e) \;=\; \exists x_0 \cdot P[x \mapsto x_0] \wedge x = e[x \mapsto x_0]$$

### Simplified Explanation

Keep a "receipt" of the old value under a fresh name, then record that `x` equals the expression (rewritten in terms of the old value).

### Worked Example

Given `{{ n ≥ 1 }}` and `n = n + 3;`:

1. Replace `n` with `n0`: `{{ n0 ≥ 1 }}`, and `n = n0 + 3`
2. Postcondition: `{{ n0 ≥ 1 and n = n0 + 3 }}`
3. Simplify: `n0 = n - 3`, so substitute: `{{ n - 3 ≥ 1 }}`, i.e., `{{ n ≥ 4 }}`

---

## Backward Reasoning

**Goal**: Given a postcondition `Q` after `x = y;`, compute the weakest precondition.

**General rule:**

```
{{ Q[x ↦ y] }}
x = y;
{{ Q }}
```

Simply substitute every occurrence of `x` in `Q` with `y`. No subscripts are needed.

### Formal Definition

Given postcondition $Q$ and assignment $x := e$, the weakest precondition is:

$$WP(x := e,\ Q) \;=\; Q[x \mapsto e]$$

### Simplified Explanation

Ask: "What must be true of the *old* state so that, after the assignment, `Q` holds?" Answer: whatever `Q` says about `x`, it must hold of `y` before the assignment.

### Worked Example

Given postcondition `{{ n² ≥ 10 }}` and `n = n + 3;`:

1. Substitute `n` → `n + 3` in `Q`: `{{ (n+3)² ≥ 10 }}`
2. Required precondition: `{{ (n+3)² ≥ 10 }}`

---

## Conditionals

Both reasoning directions apply inside branches:

```
{{ P }}
if (cond) {
    {{ P and cond }}
    S1
    {{ A }}
} else {
    {{ P and not cond }}
    S2
    {{ B }}
}
{{ A or B }}
```

When a branch ends in `return`, its postcondition is `false` (no states reach past the return):

```
{{ P }}
if (cond) {
    S1
    {{ A }}
} else {
    return something;
    {{ false }}
}
{{ A or false }}   →   {{ A }}
```

---

## Using Both Together

On longer code you can apply forward reasoning from the top and backward reasoning from the bottom simultaneously, meeting in the middle:

```
{{ P }}
S
{{ R1 }}     ← forward from P through S
{{ R2 }}     ← backward from Q through T
T
{{ Q }}
```

The code is correct iff `R1 ⇒ R2` (a Hoare triple with no code).

---

## Related

- [[Floyd Logic]] — the broader assertion-based reasoning framework
- [[Hoare Triples]] — the triple structure these rules operate on
- [[Stronger Assertions]] — "strongest postcondition" and "weakest precondition" rely on assertion ordering
- [[Pre and Post Conditions]] — how assertions appear in method specifications
- [[Software Design and Implementation/Part II - Software Engineering/Java Programming/Loops|Loops]] — applying these rules to loop invariants
