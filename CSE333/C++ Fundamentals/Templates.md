# CSE 333: Templates

C++ **templates** facilitate generic programming by allowing functions and classes to be defined with a placeholder type parameter.

## Parametric Polymorphism
Templates provide **parametric polymorphism**, allowing the same logic to be applied to different data types without rewriting the code.
- At **compile-time**, the compiler generates "specialized" code for each used type based on the template.
- Your template definition itself is not runnable code; it is a blueprint for the compiler.

## Function Templates
A **function template** defines a family of functions.
- **Syntax**:
  ```cpp
  template <typename T>
  int compare(const T& a, const T& b) {
    if (a < b) return -1;
    if (b < a) return 1;
    return 0;
  }
  ```
- **Compiler Inference**: In many cases, the compiler can infer the template parameter `T` from the arguments passed to the function (e.g., `compare(10, 20)` implies `T` is `int`).

## Template Non-types
Templates can also accept constant values as parameters, known as **non-types**.
- **Example**: `template <typename T, int N> class Array { ... };`
- These are often used for fixed-size buffers or arrays.

## Class Templates
**Class templates** allow you to define generic data structures.
- **Syntax**:
  ```cpp
  template <typename Thing>
  class Pair {
  public:
    Thing get_first() const { return first_; }
    void set_first(Thing &val) { first_ = val; }
  private:
    Thing first_, second_;
  };
  ```
- When defining member functions outside the class declaration, you must repeat the template prefix.

## Implementation Details
- **Instantiation**: The compiler generates template instantiations for each type used.
- **Header Files**: Because the compiler needs to see the template definition to instantiate it, template definitions (including member function bodies) are almost always placed entirely in **header files** (`.h`).
- **Lazy Compilation**: Only the template methods that are actually called in your program are instantiated and compiled.

## Related
- [[C++ Introduction]]
- [[C++ Classes]]
- [[Smart Pointers]]
