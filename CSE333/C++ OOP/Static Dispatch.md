## How Static Dispatch Actually Works

Static dispatch is simpler and more direct than dynamic dispatch:

### At Compile Time:

- The compiler identifies which functions are non-virtual
- For each function call, the compiler determines exactly which implementation to use based on the declared type of the pointer/reference
- The compiler generates a direct function call instruction with the target address
- No vtable or vptr is involved for these calls

### At Runtime:

- When a non-virtual function is called:
    1. The program jumps directly to the pre-determined function address
    2. No lookup or indirection occurs
    3. The same function is always called regardless of the actual object type

In a code example:

```c++
class Base {
  void Speak() {...}  // Non-virtual
}
class Sub : public Base {
  void Speak() {...}  // Hides base version, not an override
}

Base* ptr = new Sub();
ptr->Speak();  // Always calls Base::Speak() regardless of actual object
```

With static dispatch:

- The compiler resolves `ptr->Speak()` to `Base::Speak()` during compilation
- It generates a direct call to that specific function
- Even though `ptr` points to a `Sub` object, `Base::Speak()` will be called
- No runtime type checking or function lookup occurs

This is why static dispatch is more efficient but less flexible than dynamic dispatch - the decision is "hardcoded" at compile time rather than determined at runtime.