# CSE333: Virtual Table (vtable)

The **Virtual Table (vtable)** is the underlying mechanism that enables **dynamic dispatch** (run-time polymorphism) in C++.

## Creation and Initialization
The vtable and its associated pointers are managed at different stages of the build and execution process:

1.  **Compile-Time**: The compiler creates exactly **one vtable for each class** that contains at least one virtual function. This table is a static array stored in the program's read-only data segment.
2.  **Run-Time (Constructor)**: When an object is instantiated, the **constructor** initializes the object's hidden **vptr** (virtual pointer) to point to the correct vtable for its class.

## Memory Overhead
Using virtual functions is not "free"; it adds a small memory cost to both the class definition and every object instance.

### 1. Per-Class Overhead (The vtable)
Each polymorphic class has one static vtable.
- **Size**: `(Number of Virtual Functions) * (Size of a Pointer)`.
- On a 64-bit system, a class with 5 virtual functions adds ~40 bytes to the program's static data segment.

### 2. Per-Instance Overhead (The vptr)
Every object instance of a polymorphic class carries a hidden member called the **vptr**.
- **Size**: Exactly one pointer (8 bytes on 64-bit, 4 bytes on 32-bit).
- **Impact**: This increases the `sizeof()` the object. For example, an "empty" class with a virtual destructor will have a `sizeof()` of 8 bytes instead of 1 byte.

## How it Works: The Lookup
When you call a virtual function through a base pointer (e.g., `ptr->Speak()`):
1.  The CPU follows the **vptr** inside the object to find the **vtable**.
2.  It looks up the function pointer at the specific index reserved for `Speak()`.
3.  It jumps to that address and executes the code.

## Inheritance and Overriding
- **Overriding**: If a derived class overrides a function, the compiler puts the address of the *new* implementation in the derived class's vtable.
- **Not Overriding**: If the derived class does *not* override, its vtable simply points to the base class's implementation.

## Related
- [[Inheritance]]
- [[C++ Casting]]
- [[CSE333/Memory Management/Data Type Sizes]]
