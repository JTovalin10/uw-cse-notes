# CSE341: Dynamic Scope

A scoping rule where the environment of a function is determined by the call stack at runtime.

### Formal Definition

Under **Dynamic Scope**, a function body is evaluated in the environment of the caller.

### Simplified Explanation

Functions look for variables in the place they are currently being called from. (Usually considered a bad idea.)

See: [[CSE341/Trefoil Basics/Trefoil Functions and Scoping|Trefoil Functions and Scoping]]
