# Course: Currying

The technique of converting a function that takes multiple arguments into a sequence of functions that each take a single argument.

### Formal Definition
**[[CSE341/Definitions/Part2/Currying|Currying]]** is the transformation of a function $f: (A \times B) \to C$ into a function $f_{curried}: A \to (B \to C)$.

### Simplified Explanation
Instead of taking all arguments at once in a tuple, a function takes one argument and returns a new function that waits for the next one.
