```c++
class Base {

void Speak() {...}
}

class Sub : public Base {

void Speak() {...}
}
```

## How Dynamic Dispatch Actually Works

There's a separation between compile-time and runtime activities:

### At Compile Time:

- The compiler identifies which functions are virtual
- For each class, the compiler creates a vtable containing pointers to virtual function implementations
- The compiler adds code to initialize each object with a hidden vptr (pointer to its class's vtable)
- For virtual function calls, the compiler generates code that will perform a vtable lookup

### At Runtime:

- When a virtual function is called through a pointer/reference:
    1. The program follows the object's vptr to its class's vtable
    2. It indexes into the vtable to find the correct function pointer
    3. It calls that function

In your example:

```c++
class Base {
  virtual void Speak() {...}
}
class Sub : public Base {
  void Speak() {...}
}
```

- `Base::Speak()` is declared virtual, so the compiler creates a vtable for Base
- When Sub overrides Speak(), the compiler updates Sub's vtable to point to Sub::Speak()
- When code calls `basePtr->Speak()`, the runtime system follows basePtr's vptr to find the appropriate Speak() implementation

The compiler doesn't "check" anything at runtime - it sets up the mechanism, and the runtime system follows the pointers. The key is that the actual function called depends on the object's runtime type, not its compile-time type.