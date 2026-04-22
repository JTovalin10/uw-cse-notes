# CSE333: Virtual Table (vtable)

The **Virtual Table (vtable)** is a mechanism used in C++ to support **dynamic dispatch** (run-time polymorphism).

## How it Works
- Any class that contains at least one `virtual` function has its own vtable.
- The vtable is a static array of pointers to the virtual functions for that class.
- Each object of such a class contains a hidden pointer, called the **vptr**, which points to the class's vtable.

## Inheritance and Chaining
- When a class overrides a virtual function, the vtable entry for that function is updated to point to the new implementation.
- This chaining continues through multiple levels of inheritance (an override of an override is also placed in the vtable).
- If a class doesn't override a virtual function, its vtable entry points to the implementation in the base class.

## Related
- [[CSE333/C++ OOP/Dynamic Dispatch|Dynamic Dispatch]]
- [[CSE333/C++ OOP/Virtual Identifier|Virtual Identifier]]
- [[CSE333/C++ OOP/Upcasting|Upcasting]]
- [[CSE333/C++ OOP/C++ Inheritance I|C++ Inheritance]]
