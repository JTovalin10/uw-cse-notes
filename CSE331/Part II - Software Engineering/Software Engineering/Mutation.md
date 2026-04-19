# CSE331: Mutation

**Mutation** is any change to state that persists after a statement executes. Reasoning about mutation requires knowing *what* can change and *who* observes the change.

![[Screenshot 2025-10-01 at 3.02.45 PM.png]]

## Kinds of Mutation in CSE331

The course distinguishes three cases, in increasing order of difficulty:

1. **[[Local Variable Mutation]]** — changes to a variable local to the current method. No caller can observe the change directly.
2. **[[Mutations of Arguments]]** — changes to objects passed in as arguments. The caller holds the same reference and *will* observe the change, so the spec must declare it with `@modifies` / `@effects`.
3. **[[Mutations in ADT]]** — changes to the fields of `this` inside an [[Abstract Data Type|ADT]] method. Must preserve the [[Representation Invariants|representation invariant]].

## Specifying Mutation

Java specifications use the [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]] and [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]] clauses to declare what is mutated and what the new state looks like.

## Related

- [[Local Variable Mutation]]
- [[Mutations of Arguments]]
- [[Mutations in ADT]]
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]
- [[Types of Operations]]
