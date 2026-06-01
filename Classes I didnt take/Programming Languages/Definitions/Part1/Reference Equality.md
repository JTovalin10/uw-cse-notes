# CSE341: Reference Equality

A form of equality that checks if two names refer to the exact same object in memory (aliasing).

### Formal Definition

Represented by the `==` operator in OCaml. For immutable data, its behavior is largely an implementation detail and should generally be avoided.

### Simplified Explanation

Two things are "equal" only if they are the exact same physical thing in the computer's memory.

See: [[Options and Let Expressions|Options and Let Expressions]], [[Mutation and Aliasing|Mutation and Aliasing]]
