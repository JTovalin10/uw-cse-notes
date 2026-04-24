# CSE 333: C++ Casting

C++ provides a set of explicit casting operators that are more informative and safer than the traditional C-style cast.

## C-style Casting
In C, casting is done with the syntax `(new_type)expression`.
- It can be used for any conversion (pointers, primitives, unrelated types).
- It is discouraged in C++ because it uses one notation for many different purposes, making it hard to search for and prone to errors.

## C++ Casting Operators
Always prefer these four operators in C++ code:

### `static_cast`
**`static_cast<to_type>(expression)`** is checked at compile-time.
- Used for conversions between related types (e.g., `float` to `int`).
- Used for pointer conversions between related classes (e.g., upcasting).
- Dangerous to use for downcasting without verification.

### `dynamic_cast`
**`dynamic_cast<to_type>(expression)`** is checked at both compile-time and **run-time**.
- Primarily used for downcasting in an inheritance hierarchy.
- For pointers: returns `nullptr` if the cast fails at runtime.
- Requires the base class to have at least one `virtual` function.

### `const_cast`
**`const_cast<to_type>(expression)`** is used to add or strip the `const` qualifier.
- Generally dangerous and should be used sparingly.

### `reinterpret_cast`
**`reinterpret_cast<to_type>(expression)`** is a low-level reinterpretation of the bit pattern.
- Used for casting between incompatible pointer types (e.g., `int*` to `char*`).
- Extremely dangerous and mostly used in systems programming.

## Implicit Conversion
The compiler automatically performs some conversions when types do not match and an explicit cast is not provided.
- Examples: `int` to `float`, `const char*` to `std::string`.
- **Constructor Exploitation**: If a class has a constructor with a single parameter, the compiler can use it for implicit conversion (e.g., passing an `int` to a function expecting a `Foo` if `Foo(int)` exists).

### `explicit` Keyword
To prevent the compiler from using a single-argument constructor for implicit conversions, use the **`explicit`** keyword.
```cpp
class Foo {
public:
  explicit Foo(int x); // cannot be used for implicit conversion
};
```

## Related
- [[Inheritance]]
- [[References and Const]]
- [[C++ Classes]]
