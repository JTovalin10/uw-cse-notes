# CSE341: Stream

An abstraction for an infinite sequence of values, produced on-demand.

### Formal Definition

A **Stream** is a recursive data structure, typically implemented as a **[[Thunk|Thunk]]** that returns a pair of a value and the next stream.

### Simplified Explanation

An infinite list that we only compute one element at a time as we need it.

See: [[Delayed Evaluation|Delayed Evaluation]]
