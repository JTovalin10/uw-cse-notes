# CSE333: C++ Introduction

C++ is a major extension of C, providing support for classes, objects, and higher-level abstractions while remaining (roughly) backward-compatible with C.

## C vs. C++

In C, developers often had to mimic encapsulation and abstraction using header file conventions, `static` specifiers for private functions, and casting structures to `void*`. C++ provides built-in language support for these concepts.

### Key Additions in C++

- **Classes**: Support for `public`, `private`, and `protected` **methods** and **instance variables**.
- **Polymorphism**:
    - **Static Polymorphism**: Function and method **overloading** — multiple functions can share the same name but have different argument types.
    - **Dynamic Polymorphism**: Derived classes can override virtual methods of parent classes, dispatched correctly at runtime.
- **Templates**: Support for **parametric polymorphism**, allowing generic data types (similar to Java generics). See [[CSE333/C++ Fundamentals/Templates|Templates]].
- **Standard Library**: A massive library including **generic containers** (`vector`, `list`, `map`, etc.), a dedicated `string` class, and **streams** for I/O.
- **Namespaces**: Permits modules to define their own scope to avoid naming collisions in the global namespace.
- **Error Handling**: Support for `try` / `throw` / `catch` exceptions.
- **Memory Management**: Introduction of **Smart Pointers** and the **RAII** (Resource Allocation Is Initialization) pattern to help prevent memory leaks.

## Hello World in C++

A simple C++ program uses `iostream` for console I/O and the `std` namespace.

```cpp
#include <iostream>
#include <cstdlib>

int main(int argc, char** argv) {
  std::cout << "Hello, World!" << std::endl;
  return EXIT_SUCCESS;
}
```

### Components

- **`iostream`**: Part of the C++ standard library. Declares stream object instances in the `std` namespace.
- **`std::cout`**: The stream object instance for standard output (C++'s equivalent of `stdout`).
- **`std::endl`**: A **manipulator** function that writes a newline (`\n`) and flushes the output buffer.
- **`<<` Operator**: An overloaded operator used for "insertion" into a stream.
- **`using namespace std;`**: Introduces the `std` namespace into the current scope, allowing `cout` instead of `std::cout`. Use with caution in large projects — it can cause name collisions.

## Primitive Types

C++ distinguishes between objects and **primitive types**.

- Primitives include familiar C types: `char`, `short`, `int`, `long`, `float`, `double`.
- C++ also defines `bool` as a primitive type (values: `true` and `false`).

## Console Input

**`std::cin`** is an object instance of class `istream` used for reading from standard input.

- It supports the **`>>`** operator for "extraction".
- It has a `getline()` method for reading entire lines (including spaces).

## Formatting with `iomanip`

The `<iomanip>` header defines stream manipulator functions to affect output formatting:

- **`setw(x)`**: Sets the width of the *next* field to `x` (not persistent — applies only to the next insertion).
- **`hex`**, **`dec`**, **`oct`**: Sets the numerical base for integer output (persistent until changed).

## Related

- [[CSE333/C++ Fundamentals/References and Const|References and Const]]
- [[CSE333/C++ OOP/C++ Classes|C++ Classes]]
- [[CSE333/C++ Fundamentals/Heap Management|Heap Management]]
- [[CSE333/C++ Fundamentals/Templates|Templates]]
- [[CSE333/Smart Pointers/Smart Pointers|Smart Pointers]]

## Industry Standard Terms

- **C++ Standard Library (STL)** — "Standard Template Library"; the collection of generic containers (`vector`, `map`, etc.), algorithms, and utilities in the `std` namespace
- **Namespace** — A scope mechanism to avoid name collisions; the `std` namespace contains all standard library components
- **Stream** — A generalized I/O abstraction; `std::cout` and `std::cin` are instances of `ostream` and `istream` respectively
