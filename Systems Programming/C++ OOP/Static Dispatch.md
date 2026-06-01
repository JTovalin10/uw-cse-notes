# CSE333: Static Dispatch

**Static dispatch** is the resolution of a function call at **compile-time** based on the declared (static) type of the pointer or reference — as opposed to [[Inheritance|dynamic dispatch]], which resolves at runtime based on the actual object type.

## How Static Dispatch Works

### At Compile Time

- The compiler identifies which functions are non-virtual.
- For each non-virtual function call, it determines exactly which implementation to use based on the **declared type** of the pointer or reference.
- The compiler generates a **direct call instruction** with the target function's address embedded in the binary.
- No vtable or vptr is consulted for these calls.

### At Runtime

- When a non-virtual function is called, the program jumps directly to the pre-determined function address.
- No lookup or indirection occurs.
- The same function is always called regardless of the actual object type at that address.

## Code Example

```cpp
class Base {
 public:
  void Speak() { /* Base implementation */ }  // Non-virtual
};

class Sub : public Base {
 public:
  void Speak() { /* Sub implementation */ }  // Hides base version, does NOT override
};

Base* ptr = new Sub();
ptr->Speak();  // Always calls Base::Speak() regardless of actual object type
```

With static dispatch:

- The compiler resolves `ptr->Speak()` to `Base::Speak()` during compilation because `ptr` is declared as `Base*`.
- It generates a direct call to that specific function.
- Even though `ptr` points to a `Sub` object, `Base::Speak()` is called — `Sub::Speak()` is never invoked through this pointer.

## Static vs. Dynamic Dispatch Trade-offs

| Property | Static Dispatch | Dynamic Dispatch |
| :--- | :--- | :--- |
| **Resolution time** | Compile-time | Runtime |
| **Performance** | Faster (direct call) | Slower (vtable lookup) |
| **Flexibility** | Fixed to declared type | Correct for actual type |
| **Enabling mechanism** | Default (non-virtual) | `virtual` keyword |

Static dispatch is more efficient but less flexible — the decision is "hardcoded" at compile-time rather than determined at runtime based on the actual object.

## Related

- [[Inheritance|Inheritance]]
- [[C++ Classes|C++ Classes]]
- [[Virtual Table|Virtual Table]]
- [[C++ Introduction|C++ Introduction]]

## Industry Standard Terms

- **Static dispatch** — Also called "early binding"; the compiler resolves the call address at compile-time
- **Dynamic dispatch** — Also called "late binding" or "runtime polymorphism"; the call address is resolved at runtime via the vtable
- **Method hiding** — When a derived class defines a non-virtual method with the same name as a base class method; it hides (not overrides) the base version, and the base version is called through base pointers (static dispatch)
