# CSE 333: C++ Introduction

C++ is a major addition to C, providing support for classes, objects, and higher-level abstractions while remaining (roughly) a subset of C.

## C vs. C++
In C, developers often had to work hard to mimic encapsulation and abstraction using header file conventions, `static` specifiers for private functions, and casting structures to `void*`. C++ provides built-in language support for these concepts.

### Key Additions in C++
- **Classes**: Support for `public`, `private`, and `protected` **methods** and **instance variables**.
- **Polymorphism**:
    - **Static Polymorphism**: Function and method **overloading**, where multiple functions can have the same name but different argument types.
    - **Dynamic Polymorphism**: Derived classes can override methods of parents, which are dispatched correctly at runtime.
- **Templates**: Support for **parametric polymorphism**, allowing for generic data types (similar to Java generics).
- **Standard Library**: A massive library including **generic containers** (vector, list, map, etc.), a dedicated `string` class, and **streams** for I/O.
- **Namespaces**: Permits modules to define their own scope to avoid naming collisions in the global namespace.
- **Error Handling**: Support for `try`/`throw`/`catch` exceptions.
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
- **`iostream`**: Part of the C++ standard library. It declares stream object instances in the `std` namespace.
- **`std::cout`**: The stream object instance for standard output (C++'s name for `stdout`).
- **`std::endl`**: A **manipulator** function that writes a newline (`\n`) and flushes the output buffer.
- **`<<` Operator**: An overloaded operator used for "insertion" into a stream.
- **`using namespace std;`**: Introduces the `std` namespace into the current region, allowing you to refer to `std::cout` as simply `cout`. Use with caution in large projects.

## Primitive Types
C++ distinguishes between objects and **primitive types**.
- Primitives include familiar C types: `char`, `short`, `int`, `long`, `float`, `double`.
- C++ also defines `bool` as a primitive type.

## Console Input
**`std::cin`** is an object instance of class `istream` used for reading from standard input.
- It supports the **`>>`** operator for "extraction".
- It has a `getline()` method for reading entire lines.

## Formatting with `iomanip`
The `<iomanip>` header defines stream manipulator functions to affect formatting:
- **`setw(x)`**: Sets the width of the *next* field to `x` (not persistent).
- **`hex`**, **`dec`**, **`oct`**: Sets the numerical base for integer output (persistent).

## Related
- [[References and Const]]
- [[C++ Classes]]
- [[Heap Management]]
