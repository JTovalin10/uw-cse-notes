# CSE 333: C++ Casting and OOP Design

C++ casting is more than just type conversion; it is the mechanism that enables **polymorphism** and the implementation of fundamental **Design Patterns**.

## Upcasting
**Upcasting** is the act of treating a pointer or reference to a **Derived** class as if it were a pointer or reference to its **Base** class.

```cpp
Derived d;
Base* b_ptr = &d; // Implicit upcasting
```

### Why it Matters (The "Why")
Upcasting is the foundation of **Subtype Polymorphism**. It allows you to write code that operates on a generic interface without knowing the specific implementation.
- **Open-Closed Principle**: You can add new derived classes without changing the code that uses the base class pointer.
- **Decoupling**: The caller is decoupled from the specific implementation details of the derived classes.

### Design Pattern: Strategy
The **Strategy Pattern** uses upcasting to swap algorithms at runtime. A class (the context) holds a pointer to a `Strategy` base class. You can "upcast" any specific implementation (e.g., `FastSort`, `BubbleSort`) into that pointer.

---

## Downcasting
**Downcasting** is the act of converting a **Base** class pointer/reference back into a **Derived** class pointer/reference.

### `dynamic_cast`
In C++, downcasting should almost always be done using **`dynamic_cast`**, which performs a runtime check to ensure the object is actually of the target type.
- **Requirement**: The base class must have at least one `virtual` function (polymorphic type).
- **Result**: Returns `nullptr` (for pointers) or throws an exception (for references) if the cast is invalid.

```cpp
Base* b = new Derived();
Derived* d = dynamic_cast<Derived*>(b); // Success!
if (d) { /* access derived members */ }
```

### Why it Matters & The "Code Smell"
Downcasting is often considered a **code smell** because it suggests that the base class interface is insufficient. However, it is necessary when:
- Using a framework that returns generic objects.
- Implementing the **Visitor Pattern**, where you must determine the specific type of an object to perform a type-specific operation.

---

## C++ Casting Operators Summary

| Operator | Use Case | Safety |
| :--- | :--- | :--- |
| **`static_cast`** | Related types (int/float) or known upcasts. | Compile-time check only. |
| **`dynamic_cast`** | **Downcasting** in inheritance hierarchies. | **Runtime check** (safest for OOP). |
| **`const_cast`** | Adding/removing `const` qualifier. | Dangerous; use sparingly. |
| **`reinterpret_cast`** | Raw bit reinterpretation (systems programming). | No checks; extremely dangerous. |

## Explicit vs Implicit
- **Implicit**: The compiler does it for you (e.g., Upcasting).
- **Explicit**: You must request it (e.g., Downcasting).
- **`explicit` Keyword**: Use on single-argument constructors to prevent the compiler from accidentally performing implicit "narrowing" or "conversion" casts that hide bugs.

## Related
- [[Inheritance]]
- [[C++ Classes]]
- [[Object Lifecycle]]
- [[Smart Pointers/Smart Pointers|Smart Pointers]]
