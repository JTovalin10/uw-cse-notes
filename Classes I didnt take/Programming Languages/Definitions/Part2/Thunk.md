# CSE341: Thunk

A zero-argument function used to delay a computation.

### Formal Definition

A **Thunk** is a function of type `unit -> 'a` that encapsulates an expression to be evaluated later.

### Simplified Explanation

Wrapping a piece of work in a function so it doesn't happen right now, but only when we "call" it later.

See: [[Delayed Evaluation|Delayed Evaluation]]
