# CSE341: Exception

A mechanism for handling unexpected or exceptional situations in a program by transferring control to a designated handler.

### Formal Definition

**Exceptions** in OCaml are values of the extensible variant type `exn`. They are raised using the `raise` expression and caught using `try ... with` blocks.

### Simplified Explanation

A way to "jump out" of the current execution when something goes wrong and find a place that knows how to deal with the error.

See: [[CSE341/Functions/First Class Functions and Closures|First Class Functions and Closures]]
