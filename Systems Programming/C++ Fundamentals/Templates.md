# CSE333: Templates

C++ **templates** facilitate generic programming by allowing functions and classes to be defined with a placeholder type parameter. This enables the same logic to be applied to many types without code duplication.

## Parametric Polymorphism

Templates provide **parametric polymorphism**. At **compile-time**, the compiler generates specialized ("instantiated") code for each type the template is actually used with. The template definition itself is not runnable code — it is a blueprint for the compiler.

## Function Templates

A **function template** defines a family of functions, one for each possible type argument.

```cpp
template <typename T>
int compare(const T& a, const T& b) {
  if (a < b) return -1;
  if (b < a) return 1;
  return 0;
}
```

- **Compiler Inference**: In many cases, the compiler can infer the template parameter `T` from the arguments (e.g., `compare(10, 20)` implies `T = int`).
- **Constraint**: The type `T` must support the operations used in the template (here, `operator<`). If it does not, the compiler generates an error at the point of instantiation.

## Template Non-types

Templates can also accept constant values as parameters, known as **non-types**.

- **Example**: `template <typename T, int N> class Array { ... };`
- These are often used for fixed-size buffers or arrays whose size is known at compile-time.

## Class Templates

**Class templates** allow defining generic data structures.

```cpp
template <typename Thing>
class Pair {
 public:
  Thing get_first() const { return first_; }
  void set_first(Thing& val) { first_ = val; }
 private:
  Thing first_, second_;
};
```

- When defining member functions outside the class declaration, you must repeat the `template <typename Thing>` prefix.
- Usage: `Pair<int> p;` or `Pair<std::string> sp;`

## Implementation Details

- **Instantiation**: The compiler generates a concrete specialization of the template for each distinct type used. `compare<int>` and `compare<double>` are two separate compiled functions.
- **Header Files**: Because the compiler needs to see the full template definition to instantiate it, template definitions (including member function bodies) are almost always placed entirely in **header files** (`.h`). This is an exception to the normal rule of separating declarations from definitions.
- **Lazy Compilation**: Only the template methods that are actually called in your program are instantiated and compiled. Unused methods are not compiled.

## Related

- [[C++ Introduction|C++ Introduction]]
- [[C++ Classes|C++ Classes]]
- [[Smart Pointers|Smart Pointers]]

## Industry Standard Terms

- **Template** — Known as "generics" in Java and C#; C++ templates are more powerful (they operate at compile-time and support non-type parameters) but also more complex
- **Template instantiation** — The compiler-generated concrete code produced for a specific set of template arguments
- **Template specialization** — A custom implementation of a template for a specific type (e.g., `vector<bool>` uses a bitset instead of a bool array)
