# CSE331: Floyd Logic

**Floyd Logic** is a formal system for reasoning about program correctness using assertions about the program state. It was invented by Robert Floyd and Sir Anthony Hoare, who both won the Turing Award (1978 and 1980, respectively).

## Program State

The **program state** is the collection of values of all the variables at a given point during execution.

## Assertions

An **assertion**, written in `{{ }}`, is a true/false claim about the program state.

- An assertion **holds** if the claim is true in the current state.
- Assertions are **mathematics, not code** — they describe what is true about the state rather than computing anything.
- When we state a fact with mutation, we must say exactly *where* it holds — it may not hold anywhere else.
- Assertions are used to describe preconditions and postconditions in [[Hoare Triples]].

## Correctness Levels

Floyd Logic handles each level of mutation complexity:

| Description | Testing | Tools | Reasoning |
|-------------|---------|-------|-----------|
| No mutation | Coverage | Type checking | Calculation, induction |
| Local variable mutation | " | " | Floyd logic |
| Heap state mutation | " | " | Rep invariants |
| Array mutation | " | " | For-any facts |

## Stronger vs Weaker Assertions

An assertion is **stronger** if it holds in a smaller subset of states (see [[Stronger Assertions]]). Stronger assertions imply weaker ones.

- The **weakest** possible assertion is `true` (holds in all states). An empty assertion `{{ }}` also means `true`.
- The **strongest** possible assertion is `false` (holds in no states — the state after a `return` statement).

## Forward and Backward Reasoning

Forward and backward reasoning are mechanical rules for moving assertions through code. See [[Forward and Backward Reasoning]] for the complete treatment.

### Forward Reasoning through Assignments

**General rule:**

```
{{ P }}
x = y;
{{ P[x ↦ xk] and x = y[x ↦ xk] }}
```

Replace all occurrences of `x` in `P` and `y` with a fresh name `xk` (subscript for the previous value). In many cases this simplifies: if `x = x0 + 1`, then `x0 = x - 1`, and you can substitute directly without keeping the subscript.

### Backward Reasoning through Assignments

**General rule:**

```
{{ Q[x ↦ y] }}
x = y;
{{ Q }}
```

Just replace every `x` in the postcondition `Q` with `y`. No subscripts needed.

### Conditionals

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

The state after a `return` statement inside a branch is `false` (no states reach past the return), so the `or false` simplifies away:

```
{{ P }}
if (cond) {
    S1
    {{ A }}
} else {
    return something;
    {{ false }}
}
{{ A or false }}
```

Which simplifies to just `{{ A }}` after the `if`.

## Related

- [[Hoare Triples]] — pairs of assertions surrounding code
- [[Forward and Backward Reasoning]] — the full rules with worked examples
- [[Pre and Post Conditions]] — how assertions are used to specify methods
- [[Stronger Assertions]] — comparing assertion strength
- [[Propositions]] — stronger/weaker pre- and postconditions
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]] — things known to be true about variables
- [[CSE331/Part II - Software Engineering/Java Programming/Loops|Loops]] — applying Floyd logic to loops
- [[CSE311/Part I - Mathematical Foundations/Logic/Tautologies|Tautologies]] — related logical foundations from CSE311
