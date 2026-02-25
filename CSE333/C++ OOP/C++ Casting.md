# Static Cast
Casting between related types at **compile-time** (no runtime safety check). Common for numeric conversions and pointer upcasting.
```c++
static_cast<type_to>(expression);

// numeric conversion
float f = static_cast<float>(intVal);

// pointer upcast (also works implicitly)
Derived* d = new Derived();
Base* b = static_cast<Base*>(d);
```
See: [[Static Dispatch]], [[Data Type Bytes]]

# Dynamic Cast
Safe **downcasting** at runtime (Base* → Derived*). Requires the base class to have at least one `virtual` function (uses RTTI via the vtable).
- Returns `nullptr` if the cast fails (for pointers)
- Throws `std::bad_cast` if the cast fails (for references)
```c++
dynamic_cast<type_to>(expression);

// downcasting example
Base* b = new Derived();
Derived* d = dynamic_cast<Derived*>(b);
if (d != nullptr) {
    // cast succeeded
}
```
> Note: Upcasting (Derived* → Base*) is implicit and does not need dynamic_cast.

See: [[Upcasting]], [[Dynamic Dispatch]], [[Virtual table]], [[Virtual Identifier]]

# Const Cast
Adding or removing `const` from a type. Mainly used when interfacing with legacy C APIs that don't use `const`.
```c++
const_cast<type_to>(expression);

// removing const to pass to a legacy function
void legacyFunc(char* s);
const char* msg = "hello";
legacyFunc(const_cast<char*>(msg));
```

# Reinterpret Cast
Reinterprets the raw bit pattern of a pointer as a different type. Used for low-level casting between incompatible pointer types. Does **not** do any conversion — can cause undefined behavior if misused.
```c++
reinterpret_cast<type_to>(expression);

// treating an int pointer as a byte pointer
int x = 42;
char* bytes = reinterpret_cast<char*>(&x);
```
See: [[Pointers]]
