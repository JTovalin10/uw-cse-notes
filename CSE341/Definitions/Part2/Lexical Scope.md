# CSE341: Lexical Scope

A scoping rule where the environment of a function is determined by its physical location in the source code.

### Formal Definition

Under **Lexical Scope**, a function body is evaluated in the environment where the function was defined, rather than the environment where it is called.

### Simplified Explanation

Functions look for variables in the place they were written, not where they are running.

See: [[CSE341/Functions/First Class Functions and Closures|First Class Functions and Closures]], [[CSE341/Trefoil Basics/Trefoil Functions and Scoping|Trefoil Functions and Scoping]]
