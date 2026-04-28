# CSE331: Conditionals

Reasoning about `if` / `else` statements in [[Floyd Logic]].

## Basic Form

Inside a conditional, the branch condition strengthens what we know about the state:

```c
if (a >= 0 && b >= 0) {
    {{ a >= 0 and b >= 0 }}
    ...
}
```

That is, the assertion at the top of the `then` branch includes the truth of the condition as a new **[[CSE331/Part I - Software Specifications/Definitions/Facts|Fact]]**.

## If / Else Reasoning

- **Reason separately about each path to a return.**
  - Handle each path the same as before (using [[Hoare Triples]]).
  - But now there can be **multiple paths** to one return.
- For `if (cond) A else B`:
  - In the `then` branch assume `cond`.
  - In the `else` branch assume `not cond`.
- The general postcondition of an `if/else` statement is `{{ A or B }}`, where `A` is the state after the `then` branch and `B` is the state after the `else` branch.
- **State after a return**: The state immediately following a `return` statement is `false` (no states can reach beyond a return). This simplifies the `or` condition. For example, if the `else` branch returns, the postcondition simplifies from `{{ A or false }}` to just `{{ A }}`.
- The [[Postcondition]] must hold along **every** path.

## Why Separate Paths?

By splitting cases, we avoid reasoning about disjunctions directly. Each path becomes a linear sequence of statements that we can verify with the standard forward / backward reasoning rules.

## Related

- [[Floyd Logic]]
- [[Hoare Triples]]
- [[Loops]]
- [[Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Definitions/Exclusive and Exhaustive|Exclusive and Exhaustive]]
