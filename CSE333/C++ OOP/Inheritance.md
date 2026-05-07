# CSE 333: Inheritance

Inheritance allows for the creation of a hierarchy of classes related by an **"is-a" relationship**.

## Base and Derived Classes
- **Base Class**: The parent class (similar to Java superclass).
- **Derived Class**: The child class that extends the base class.
- **Syntax**: `class Derived : public Base { ... };`

## Dynamic Dispatch
**Dynamic dispatch** is the mechanism where the decision of which version of a function to call is made at **run-time** based on the actual type of the object.

### `virtual` Keyword
To enable dynamic dispatch for a method, it must be marked with the **`virtual`** keyword in the base class.
- If a method is not `virtual`, the decision is made at **compile-time** (static dispatch) based on the pointer/reference type, not the object's actual type.

### `override` Specifier
Introduced in C++11, the **`override`** keyword should be used in the derived class to explicitly tell the compiler that a method is intended to override a virtual function from the base class.
- **Explicit Intent**: Clearly documents which functions are overrides.
- **Compiler Checking**: The compiler will generate an error if the function doesn't actually override a base class method (e.g., due to a signature mismatch).
- **Prevents Bugs**: Catches subtle mistakes like forgetting `const` or having slightly different parameter types.

### How it Works: vtables and vptr
For a deep dive into timing and memory costs, see: **[[Virtual table]]**.

**At Compile Time:**
- The compiler creates exactly one **vtable** for each class with virtual functions.
- It identifies which functions are `virtual` and assigns them an index in the table.

**At Runtime:**
- Every object instance carries a hidden **vptr** (8 bytes on 64-bit systems) that points to its class's vtable.
- When a virtual function is called:
    1. The program follows the `vptr` to the vtable.
    2. It uses the reserved index to find the function pointer.
    3. It executes that function.

## Inheritance and Memory
- **Derived-Class Objects**: Contain "subobjects" corresponding to the data members inherited from the base class.
- **Constructors**: A derived class constructor must call a base class constructor first. If not specified, the synthesized default base constructor is called.

### Destructor Safety Rule
The general rule for base class destructors is: **A base class destructor should be either `public` and `virtual`, or `protected` and `non-virtual`.**

#### Option 1: `public` and `virtual`
This is the most common approach for polymorphic base classes.
- **Why**: It ensures that when you call `delete` on a base class pointer (e.g., `Base* b = new Derived(); delete b;`), the runtime uses the vtable to call the **Derived** destructor first, which then automatically calls the **Base** destructor.
- **Risk**: If the destructor is `public` and `non-virtual`, deleting via a base pointer is **undefined behavior** (usually leaks derived resources).

#### Option 2: `protected` and `non-virtual`
Use this for classes intended to be base classes but **not** intended for polymorphic deletion.
- **Why**: Making it `protected` prevents the user from calling `delete` on a base class pointer (compile-time error), which makes the lack of `virtual` safe.
- **Efficiency**: It avoids adding a vtable entry for the destructor if the class has no other virtual functions.

### The Destruction Sequence
Unlike other virtual functions, destructors are not "overridden" to replace the base version. Instead, they form a **chain**:
1.  The most-derived destructor is called first.
2.  Then, it automatically calls its parent's destructor.
3.  This continues up to the root `Base` class.
**Note**: This is the exact reverse of the construction order.

## Abstract Classes and Interfaces
A class is **abstract** if it contains at least one **pure virtual function**. Abstract classes cannot be instantiated and serve as a specification for derived classes.

- **Pure Virtual Syntax**: `virtual void func() = 0;`
- **Requirement**: Derived classes **must** implement all pure virtual functions to be instantiable themselves.

### Pure Abstract Classes (Interfaces)
In C++, a **Pure Abstract Class** is a class where **every** member function is pure virtual and it contains no data members. This is the C++ equivalent of a Java or C# `interface`.

```cpp
class Shape {
 public:
  virtual ~Shape() {} // Virtual destructor is mandatory!
  virtual void Draw() = 0;
  virtual double Area() const = 0;
};
```

### Why it Matters (The "Why")
1.  **Defining a Contract**: An interface defines a strict "contract." Any class that claims to "be a" `Shape` **guarantees** it has a `Draw()` and `Area()` method.
2.  **Decoupling (Dependency Inversion)**: You can write a `Renderer` class that takes a `Shape*`. The `Renderer` doesn't need to know if the shape is a `Circle` or a `Square`. It only cares that it fulfills the `Shape` contract.
3.  **Multiple Interfaces**: While C++ supports multiple inheritance, it is most commonly and safely used to allow a class to implement multiple "Interfaces" (e.g., a `SmartPhone` class might implement `ICamera`, `IPhone`, and `IWebBrowser`).

### Principle: "Program to an Interface, not an Implementation"
This is a core tenet of good OOP design. By using base class pointers to pure abstract classes, you make your system:
- **Extensible**: Add new types without changing existing code.
- **Testable**: Easily swap a real implementation (e.g., `Database`) with a "Mock" implementation for unit testing.

For more details and examples of Abstraction and other pillars, see: **[[OOP Principles]]**.

## Object Slicing
**Object slicing** occurs when a derived class object is assigned to a base class instance (by value).
- Only the base class portion of the object is copied; the derived portion is "sliced off".
- To avoid slicing and maintain polymorphism, always use **pointers or references** when dealing with class hierarchies.

### Example: Upcasting and Downcasting
For a detailed look at the design implications of casting, see: **[[C++ Casting]]**.

```cpp
class Base { public: virtual ~Base() {} };
class Derived : public Base { public: void Specific() {} };

// 1. Upcasting: Always safe and implicit
Base* b = new Derived(); 

// 2. Downcasting: Unsafe, requires explicit check
Derived* d = dynamic_cast<Derived*>(b);
if (d) {
    d->Specific(); // Safe to call derived-specific methods
}
```

## Related
- [[C++ Classes]]
- [[Object Lifecycle]]
- [[RAII]]
- [[C++ Casting]]
- [[Smart Pointers/Smart Pointers|Smart Pointers]]
