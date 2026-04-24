# CSE 333: C++ Classes

Classes are the core building block for object-oriented programming in C++, allowing for the encapsulation of data and behavior.

## Class Definition Syntax
Classes are typically defined in a header file (`.h`) and their member functions are implemented in a source file (`.cc`).

- **Header File (`.h`)**: Declares the class, its data members, and its methods.
- **Source File (`.cc`)**: Defines the implementation of the methods using the scope resolution operator `::`.

```cpp
// Point.h
class Point {
 public:
  Point(int x, int y);  // Constructor
  int get_x() const;    // Getter (const method)
 private:
  int x_, y_;           // Data members (naming convention: trailing underscore)
};

// Point.cc
Point::Point(int x, int y) : x_(x), y_(y) {}
int Point::get_x() const { return x_; }
```

## Class Organization
- **Public vs. Private**: `public` members are accessible to any part of the program, while `private` members are accessible only to the class's own methods.
- **`struct` vs. `class`**: In C++, they are nearly identical. The only difference is visibility: `struct` members are `public` by default, while `class` members are `private` by default.
- **Inline methods**: Small methods can be defined within the class declaration in the `.h` file.

## Member Access Control
- **`public`**: Visible to all.
- **`protected`**: Visible to the class and its **derived classes**.
- **`private`**: Visible only to the class itself.

## Nonmember Functions
**Nonmember functions** are regular functions that are not part of a class but may interact with it.
- Useful for commutative operators or stream I/O (e.g., `operator<<`).
- Declared in the header file but outside the class definition.

### `friend` Functions
A class can grant a nonmember function access to its `private` members by declaring it as a **`friend`** within the class definition.
- Friends are usually unnecessary if the class provides appropriate public "getter" functions.

## Namespaces
**Namespaces** create a separate scope to avoid symbol collisions.
- Defined with the `namespace` keyword.
- Standard library components are in the `std` namespace.
- Access members using `namespace_name::member_name`.

## Related
- [[Constructor Details]]
- [[Inheritance]]
- [[References and Const]]
- [[Heap Management]]
