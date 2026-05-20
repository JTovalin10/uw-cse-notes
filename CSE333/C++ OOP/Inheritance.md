# CSE333: Inheritance

Inheritance allows for the creation of a hierarchy of classes related by an **"is-a" relationship**. A derived class inherits the public interface and implementation of its base class and can extend or override it.

## Base and Derived Classes

- **Base Class**: The parent class (analogous to Java's superclass).
- **Derived Class**: The child class that extends the base class.
- **Syntax**: `class Derived : public Base { ... };`

## Dynamic Dispatch

**Dynamic dispatch** is the mechanism where the decision of which version of a function to call is made at **run-time** based on the actual type of the object (not the declared type of the pointer or reference).

### `virtual` Keyword

To enable dynamic dispatch for a method, it must be marked with the **`virtual`** keyword in the base class.

- If a method is **not** `virtual`, the decision is made at **compile-time** (static dispatch) based on the pointer or reference type, regardless of the actual object type. See [[CSE333/C++ OOP/Static Dispatch|Static Dispatch]].

### `override` Specifier

Introduced in C++11, the **`override`** keyword in the derived class explicitly tells the compiler that a method is intended to override a virtual function from the base class.

- **Explicit Intent**: Clearly documents which functions are overrides.
- **Compiler Checking**: The compiler generates an error if the function does not actually override a base class method (e.g., due to a signature mismatch or forgotten `const`).
- **Prevents Bugs**: Catches subtle mistakes like forgetting `const` or having slightly different parameter types that would silently create a *new* method instead of overriding.

### How it Works: vtables and vptr

For a deep dive into timing and memory costs, see [[CSE333/C++ OOP/Virtual Table|Virtual Table]].

**At Compile Time:**

- The compiler creates exactly one **vtable** for each class with virtual functions.
- It identifies which functions are `virtual` and assigns each an index in the table.

**At Runtime:**

- Every object instance carries a hidden **vptr** (8 bytes on 64-bit systems) that points to its class's vtable.
- When a virtual function is called:
    1. The program follows the `vptr` to the vtable.
    2. It uses the function's reserved index to find the function pointer.
    3. It executes that function.

## Inheritance and Memory

- **Derived-Class Objects**: Contain "subobjects" corresponding to the data members inherited from the base class, laid out contiguously in memory.
- **Constructors**: A derived class constructor must call a base class constructor first. If not specified, the synthesized default base constructor is called.

### Destructor Safety Rule

The general rule for base class destructors is: **a base class destructor should be either `public` and `virtual`, or `protected` and non-virtual.**

#### Option 1: `public` and `virtual`

The most common approach for polymorphic base classes.

- **Why**: When you call `delete` on a base class pointer (e.g., `Base* b = new Derived(); delete b;`), the runtime uses the vtable to call the **Derived** destructor first, which then automatically calls the **Base** destructor.
- **Risk**: If the destructor is `public` and non-virtual, deleting via a base pointer is **undefined behavior** and typically leaks the derived class's resources.

#### Option 2: `protected` and non-virtual

Use this for classes intended to be base classes but **not** intended for polymorphic deletion.

- **Why**: Making it `protected` prevents the user from calling `delete` on a base class pointer (compile-time error), which makes the absence of `virtual` safe.
- **Efficiency**: Avoids adding a vtable entry for the destructor if the class has no other virtual functions.

### The Destruction Sequence

Destructors form a **chain** (unlike other virtual functions, which "replace" the base version):

1. The most-derived destructor runs first.
2. It automatically calls its parent's destructor.
3. This continues up to the root base class.

**Note**: Destruction order is the exact reverse of construction order.

## Abstract Classes and Interfaces

A class is **abstract** if it contains at least one **pure virtual function**. Abstract classes cannot be instantiated and serve as a specification (contract) for derived classes.

- **Pure Virtual Syntax**: `virtual void func() = 0;`
- **Requirement**: Derived classes **must** implement all pure virtual functions to be instantiable themselves.

### Pure Abstract Classes (Interfaces)

In C++, a **pure abstract class** is a class where every member function is pure virtual and it has no data members. This is the C++ equivalent of a Java or C# `interface`.

```cpp
class Shape {
 public:
  virtual ~Shape() {}   // Virtual destructor is mandatory!
  virtual void Draw() = 0;
  virtual double Area() const = 0;
};
```

### Why Abstract Classes Matter

1. **Defining a Contract**: An interface defines a strict "contract." Any class claiming to "be a" `Shape` guarantees it has a `Draw()` and `Area()` method.
2. **Decoupling (Dependency Inversion)**: A `Renderer` class can take a `Shape*` without knowing whether the shape is a `Circle` or `Square`. It only cares that it fulfills the `Shape` contract.
3. **Multiple Interfaces**: While C++ supports multiple inheritance, it is most commonly and safely used to allow a class to implement multiple interfaces.

For more details and examples of Abstraction, see [[CSE333/C++ OOP/OOP Principles|OOP Principles]].

## Object Slicing

**Object slicing** occurs when a derived class object is assigned **by value** to a base class variable.

- Only the base class portion is copied; the derived portion is "sliced off".
- To avoid slicing and maintain polymorphism, always use **pointers or references** when working with class hierarchies.

### Upcasting and Downcasting

For a detailed look at the design implications of casting, see [[CSE333/C++ Casting|C++ Casting]].

```cpp
class Base { public: virtual ~Base() {} };
class Derived : public Base { public: void Specific() {} };

// (1) Upcasting: Always safe and implicit
Base* b = new Derived();

// (2) Downcasting: Unsafe, requires explicit check
Derived* d = dynamic_cast<Derived*>(b);
if (d) {
    d->Specific(); // Safe to call derived-specific methods
}
```

## Related

- [[CSE333/C++ OOP/C++ Classes|C++ Classes]]
- [[CSE333/C++ OOP/Object Lifecycle|Object Lifecycle]]
- [[CSE333/C++ OOP/RAII|RAII]]
- [[CSE333/C++ OOP/C++ Casting|C++ Casting]]
- [[CSE333/C++ OOP/Static Dispatch|Static Dispatch]]
- [[CSE333/C++ OOP/Virtual Table|Virtual Table]]
- [[CSE333/Smart Pointers/Smart Pointers|Smart Pointers]]

## Industry Standard Terms

- **Dynamic dispatch** — Runtime polymorphism; implemented via vtables in C++, virtual method tables in Java, and method lookup tables in Python
- **Abstract class / Interface** — A class that defines a contract but cannot be instantiated; in Java this is the `interface` keyword; in Python, `abc.ABC`
- **Object slicing** — A C++-specific pitfall where derived-class data is lost when assigning to a base-class object by value; avoided by using pointers or references
- **Pure virtual function** — A function declared with `= 0`; forces derived classes to provide an implementation; Java equivalent is an `abstract` method
