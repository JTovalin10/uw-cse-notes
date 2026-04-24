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
- **`override`**: In C++11 and later, use the `override` keyword in the derived class to explicitly tell the compiler that a method is intended to override a virtual function from the base class.

### How it Works: vtables and vptr
- **vtable**: For every class containing virtual functions, the compiler creates a single "virtual function table" containing function pointers.
- **vptr**: Every instance of such a class contains a hidden pointer (`vptr`) to its class's vtable.
- At runtime, the code follows the `vptr` to the `vtable` and invokes the correct function pointer.

## Inheritance and Memory
- **Derived-Class Objects**: Contain "subobjects" corresponding to the data members inherited from the base class.
- **Constructors**: A derived class constructor must call a base class constructor first. If not specified, the synthesized default base constructor is called.
- **Destructors**: The base class destructor should **always** be declared `virtual`. This ensures that when a derived object is deleted via a base class pointer, the derived class's destructor is called first.

## Abstract Classes
A class is **abstract** if it contains at least one **pure virtual function**.
- **Syntax**: `virtual void func() = 0;`
- Abstract classes cannot be instantiated.
- They serve as a specification (interface) for derived classes.

## Object Slicing
**Object slicing** occurs when a derived class object is assigned to a base class instance (by value).
- Only the base class portion of the object is copied; the derived portion is "sliced off".
- To avoid slicing and maintain polymorphism, always use **pointers or references** when dealing with class hierarchies.

## Related
- [[C++ Classes]]
- [[Constructor Details]]
- [[C++ Casting]]
- [[Smart Pointers]]
