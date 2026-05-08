# Course: Stream

An abstraction for an infinite sequence of values, produced on-demand.

### Formal Definition
A **[[CSE341/Definitions/Part2/Stream|Stream]]** is a recursive data structure, typically implemented as a **[[CSE341/Definitions/Part2/Thunk|Thunk]]** that returns a pair of a value and the next stream.

### Simplified Explanation
An infinite list that we only compute one element at a time as we need it.
