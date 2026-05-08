# Course: Dynamic Scope

A scoping rule where the environment of a function is determined by the call stack at runtime.

### Formal Definition
Under **[[CSE341/Definitions/Part2/Dynamic Scope|Dynamic Scope]]**, a function body is evaluated in the environment of the caller.

### Simplified Explanation
Functions look for variables in the place they are currently being called from. (Usually considered a bad idea).
