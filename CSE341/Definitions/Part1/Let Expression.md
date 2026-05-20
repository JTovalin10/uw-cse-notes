# CSE341: Let Expression

An expression that allows for the creation of local variable or function bindings within a specific scope.

### Formal Definition

`let x = e1 in e2`. $e_1$ is evaluated to $v_1$, and then $e_2$ is evaluated in a **[[CSE341/Definitions/Part1/Dynamic Environment|Dynamic Environment]]** where $x$ is bound to $v_1$.

### Simplified Explanation

A way to create a temporary variable that only exists inside a specific block of code.

See: [[CSE341/Data Structures/Options and Let Expressions|Options and Let Expressions]]
