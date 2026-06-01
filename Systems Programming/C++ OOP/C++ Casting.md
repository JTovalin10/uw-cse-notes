# CSE333: C++ Casting

C++ casting is more than just type conversion; it is the mechanism that enables **polymorphism** and the implementation of fundamental design patterns. C++ provides four distinct cast operators, each with a specific use case and safety level.

## Upcasting

**Upcasting** is the act of treating a pointer or reference to a **Derived** class as a pointer or reference to its **Base** class.

```cpp
Derived d;
Base* b_ptr = &d; // Implicit upcasting — always safe
```

### Why it Matters

Upcasting is the foundation of **subtype polymorphism**. It allows you to write code that operates on a generic interface without knowing the specific implementation.

- **Open-Closed Principle**: You can add new derived classes without changing the code that uses the base class pointer.
- **Decoupling**: The caller is decoupled from the specific implementation details of the derived classes.

### Design Pattern: Strategy

The **Strategy Pattern** uses upcasting to swap algorithms at runtime. A class (the context) holds a pointer to a `Strategy` base class, and any specific implementation (e.g., `FastSort`, `BubbleSort`) can be "upcasted" into that pointer.

---

## Downcasting

**Downcasting** is the act of converting a **Base** class pointer or reference back into a **Derived** class pointer or reference.

### `dynamic_cast`

In C++, downcasting should almost always be done using **`dynamic_cast`**, which performs a runtime check to ensure the object is actually of the target type.

- **Requirement**: The base class must have at least one `virtual` function (it must be a polymorphic type). This is because `dynamic_cast` uses the vtable to verify the actual type.
- **Result**: Returns `nullptr` (for pointers) or throws `std::bad_cast` (for references) if the cast is invalid.

```cpp
Base* b = new Derived();
Derived* d = dynamic_cast<Derived*>(b); // Success — b actually points to a Derived
if (d) { /* safe to access derived members */ }

Base* b2 = new Base();
Derived* d2 = dynamic_cast<Derived*>(b2); // Returns nullptr — b2 is not a Derived
```

### Why it Matters and The "Code Smell"

Downcasting is often considered a **code smell** because it suggests that the base class interface is insufficient for the task. However, it is sometimes necessary when:

- Using a framework that returns generic objects.
- Implementing the **Visitor Pattern**, where you must determine the specific type of an object to perform a type-specific operation.

---

## C++ Casting Operators Summary

| Operator | Use Case | Safety |
| :--- | :--- | :--- |
| **`static_cast`** | Related types (int to float) or known-safe upcasts. | Compile-time check only. |
| **`dynamic_cast`** | **Downcasting** in inheritance hierarchies. | Runtime check (safest for OOP). |
| **`const_cast`** | Adding or removing `const` qualifier. | Dangerous — use sparingly. |
| **`reinterpret_cast`** | Raw bit reinterpretation (systems programming). | No checks — extremely dangerous. |

## Explicit vs. Implicit Casts

- **Implicit**: The compiler performs it automatically (e.g., upcasting a `Derived*` to `Base*`).
- **Explicit**: The programmer must request it (e.g., downcasting with `dynamic_cast`).
- **`explicit` Keyword**: Use on single-argument constructors to prevent the compiler from accidentally performing implicit conversion casts that could hide bugs.

## Related

- [[Inheritance|Inheritance]]
- [[C++ Classes|C++ Classes]]
- [[Object Lifecycle|Object Lifecycle]]
- [[Smart Pointers|Smart Pointers]]

## Industry Standard Terms

- **`dynamic_cast`** — The safe runtime type check for polymorphic hierarchies; uses the vtable (RTTI) to verify the actual object type
- **RTTI (Runtime Type Information)** — The metadata the C++ runtime maintains about polymorphic objects to support `dynamic_cast` and `typeid`; can be disabled with `-fno-rtti` for embedded systems
- **Upcasting** — "Widening" conversion toward a base type; always safe because a derived object is a superset of the base
- **Downcasting** — "Narrowing" conversion toward a derived type; unsafe unless verified at runtime; a code smell indicating a leaky abstraction
