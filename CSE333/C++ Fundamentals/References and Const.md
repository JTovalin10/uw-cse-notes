# CSE 333: References and Const

References and the `const` keyword are fundamental tools in C++ for defining intent and managing data efficiently without unnecessary copying.

## References
A **reference** is an alias for another variable. In C++, a reference is another name that is bound to the aliased variable.

- **Syntax**: `type& name = variable;`
- Mutating a reference **is** mutating the aliased variable.
- Unlike pointers, references cannot be "null" and must be initialized when declared.
- Once a reference is bound to a variable, it cannot be rebound to another.

### Pass-by-Reference
C++ allows for **pass-by-reference**, where a function receives a reference to the caller's argument.
- Modifying a reference parameter modifies the caller's argument directly.
- Uses normal syntax for the caller (no need for `&` at the call site).

```cpp
void swap(int& x, int& y) {
  int tmp = x;
  x = y;
  y = tmp;
}
```

## The `const` Keyword
The **`const`** keyword indicates that a variable or data cannot be changed or mutated. It is a signal of intent to the compiler and results in compile-time errors if violated.

### const and Pointers
Pointers can be complex with `const` because they involve two entities: the pointer itself and the data it points to.
- **`const int *p`**: Pointer to a constant integer. The data cannot be changed through `p`, but `p` can point elsewhere. (Read as: "p is a pointer to an int that is const").
- **`int * const p`**: Constant pointer to an integer. The data can be changed, but `p` cannot point elsewhere. (Read as: "p is a const pointer to an int").
- **`const int * const p`**: Constant pointer to a constant integer.

**Tip**: Read variable declarations from **right-to-left** to understand the scope of `const`.

### const Parameters
A `const` parameter cannot be mutated inside the function.
- It provides a guarantee to the caller that their data will not be modified.
- It allows the function to accept both `const` and non-`const` variables as arguments.

## Google Style Guide Conventions
The Google C++ style guide recommends specific uses for references and pointers:
- **Input Parameters**: Use `const` references (e.g., `const string& s`) or call-by-value (for primitives). Using `const` references for large objects avoids expensive copying.
- **Output Parameters**: Use pointers (e.g., `int* result`). This makes it explicit at the call site that the variable might be modified (since you must pass `&var`).
- **Ordering**: List input parameters first, then output parameters last.

## Related
- [[C++ Introduction]]
- [[C++ Classes]]
- [[Constructor Details]]
