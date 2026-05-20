# CSE333: C++ Classes

Classes are the core building block for object-oriented programming in C++, allowing for the encapsulation of data and behavior into a single unit.

## Class Definition Syntax

Classes are typically defined in a header file (`.h`) and their member functions are implemented in a source file (`.cc`).

- **Header File (`.h`)**: Declares the class, its data members, and its methods.
- **Source File (`.cc`)**: Defines the implementation of the methods using the scope resolution operator `::`.

```cpp
// Point.h
class Point {
 public:
  Point(int x, int y);  // Constructor
  int get_x() const;    // Getter (const method — does not modify the object)
 private:
  int x_, y_;           // Data members (naming convention: trailing underscore)
};

// Point.cc
Point::Point(int x, int y) : x_(x), y_(y) {}
int Point::get_x() const { return x_; }
```

## Class Organization

- **`struct` vs. `class`**: In C++, they are nearly identical. The only difference is the default access level: `struct` members are `public` by default, while `class` members are `private` by default.
- **Inline methods**: Small methods can be defined within the class declaration in the `.h` file. The compiler may choose to expand them inline at the call site.

## Member Access Control

| Specifier | Visible To |
| :--- | :--- |
| **`public`** | All code |
| **`protected`** | The class and its derived classes |
| **`private`** | Only the class itself |

## OOP Principles

For a detailed look at the core pillars of Object-Oriented Programming (Encapsulation, Abstraction, Inheritance, and Polymorphism) with code examples, see [[CSE333/C++ OOP/OOP Principles|OOP Principles]].

## Nonmember Functions

**Nonmember functions** are regular functions that are not part of a class but may interact with it.

- Useful for commutative operators or stream I/O (e.g., `operator<<`).
- Declared in the header file but outside the class definition.

### `friend` Keyword

A class can grant a non-member function or another class access to its `private` and `protected` members by using the **`friend`** keyword.

- **`friend` Functions**: Often used for overloaded operators (like `operator<<`) that need to access internal data but cannot be member functions (e.g., when the left-hand operand is not the class itself).
- **`friend` Classes**: If `class A` declares `friend class B;`, all member functions of `B` can access private members of `A`.
- **Encapsulation Note**: `friend` should be used sparingly. It bypasses the standard access control and can make code harder to maintain.

**Key Properties of Friendship**:

- Friendship is **granted, not taken**: Class A must declare B as a friend.
- Friendship is **not symmetric**: If A is a friend of B, B is not automatically a friend of A.
- Friendship is **not transitive**: If A is a friend of B and B is a friend of C, A is not a friend of C.

## Namespaces

**Namespaces** create a separate scope to avoid symbol collisions.

- Defined with the `namespace` keyword.
- Standard library components are in the `std` namespace.
- Access members using `namespace_name::member_name`.

## Related

- [[CSE333/C++ OOP/Object Lifecycle|Object Lifecycle]]
- [[CSE333/C++ OOP/Inheritance|Inheritance]]
- [[CSE333/C++ OOP/RAII|RAII]]
- [[CSE333/C++ OOP/OOP Principles|OOP Principles]]
- [[CSE333/C++ Fundamentals/References and Const|References and Const]]
- [[CSE333/C++ Fundamentals/Heap Management|Heap Management]]

## Industry Standard Terms

- **Class** — The fundamental unit of encapsulation in OOP; equivalent to a "class" in Java, Python, and C#
- **`friend`** — A controlled encapsulation escape hatch; used sparingly in well-designed APIs (e.g., for unit test access or operator overloading)
- **Namespace** — A scoping mechanism to prevent name collisions; the C++ equivalent of Java packages or Python modules
- **Scope resolution operator (`::`)** — Used to qualify a name with its enclosing namespace or class; e.g., `std::cout`, `Point::get_x()`
