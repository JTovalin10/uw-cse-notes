# CSE333: References and Const

References and the `const` keyword are fundamental tools in C++ for defining intent and managing data efficiently without unnecessary copying.

## References

A **reference** is an alias for another variable — it is another name bound to the same memory location as the aliased variable.

- **Syntax**: `type& name = variable;`
- Mutating a reference **is** mutating the aliased variable — they share the same address.
- Unlike pointers, references cannot be "null" and must be initialized when declared.
- Once a reference is bound to a variable, it **cannot be rebound** to another variable.

### Pass-by-Reference

C++ allows **pass-by-reference**, where a function receives a reference to the caller's argument. This avoids the cost of copying large objects and allows the function to modify the caller's variable.

- Modifying a reference parameter directly modifies the caller's argument.
- Uses normal syntax at the call site (no need for `&`).

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

Pointers involve two entities — the pointer itself and the data it points to — each of which can be `const` independently.

- **`const int *p`**: Pointer to a constant integer. The data cannot be changed through `p`, but `p` can be reassigned to point elsewhere. (Read right-to-left: "p is a pointer to an int that is const".)
- **`int * const p`**: Constant pointer to an integer. The data can be changed, but `p` cannot be reassigned. (Read right-to-left: "p is a const pointer to int".)
- **`const int * const p`**: Constant pointer to a constant integer — neither the pointer nor the data can change.

**Tip**: Read variable declarations from **right-to-left** to determine the scope of `const`.

### const Parameters

A `const` parameter cannot be mutated inside the function.

- Provides a guarantee to the caller that their data will not be modified.
- Allows the function to accept both `const` and non-`const` variables as arguments.

## Google Style Guide Conventions

The Google C++ style guide recommends specific uses for references and pointers:

- **Input Parameters**: Use `const` references (e.g., `const string& s`) or call-by-value for primitives. Using `const` references for large objects avoids expensive copying while preventing modification.
- **Output Parameters**: Use pointers (e.g., `int* result`). This makes it explicit at the call site that the variable might be modified (since you must pass `&var`).
- **Ordering**: List input parameters first, then output parameters last.

## Related

- [[C++ Introduction|C++ Introduction]]
- [[C++ Classes|C++ Classes]]
- [[Object Lifecycle|Object Lifecycle]]

## Industry Standard Terms

- **Reference** — An alias for a variable; in generated machine code, references are typically implemented as pointers but with additional compiler-enforced restrictions
- **`const` correctness** — The practice of marking every variable, parameter, and method that should not modify data as `const`; a hallmark of well-written C++ code
- **Pass-by-reference** — Passing the address of a variable to avoid copying; used in C++ via references (`T&`) or raw pointers (`T*`) in C
