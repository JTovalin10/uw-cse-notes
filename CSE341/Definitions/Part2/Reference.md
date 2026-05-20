# CSE341: Reference

A mutable cell that holds a value and can be updated over time.

### Formal Definition

A **Reference** (of type `t ref`) is a pointer to a location on the heap containing a value of type `t`. It supports creation (`ref e`), dereferencing (`!e`), and assignment (`e1 := e2`).

### Simplified Explanation

A box that you can put a value into, look inside, or swap the contents for something else later.

See: [[CSE341/Mutation/Mutation and Aliasing|Mutation and Aliasing]]
