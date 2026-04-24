# CSE 333: Constructor Details

Constructors are special member functions that initialize newly instantiated objects. In C++, managing how objects are constructed, copied, and assigned is critical for memory safety.

## Constructors (ctors)
A **constructor** has the same name as the class and no return type.
- **Synthesized Default Constructor**: If no user-defined constructors are declared, the compiler automatically creates one that takes no arguments. It calls the default constructors for non-primitive member variables.
- **Overloading**: Classes can have multiple constructors with different parameter lists.

### Initialization Lists
**Initialization lists** are used to initialize member variables before the constructor body executes.
- **Syntax**: `ClassName::ClassName(args) : member1(val1), member2(val2) { ... }`
- **Preferred over assignment** inside the constructor body to avoid unnecessary default initialization followed by assignment.
- **Order**: Members are initialized in the order they are declared in the class, **not** the order in the initialization list.

## Copy Constructor (cctor)
A **copy constructor** is used to create a new object as a copy of an existing object of the same type.
- **Syntax**: `ClassName(const ClassName& copy_me);`
- **When copies happen**:
  - Initializing an object from another (`Point y = x;` or `Point y(x);`).
  - Passing an object by value to a function.
  - Returning an object by value from a function.
- **Synthesized cctor**: Performs a **shallow copy** of all member variables.

## Assignment Operator (`=`)
The **assignment operator** is used to assign values to an **already existing**, already constructed object.
- **Rules for overloading**:
  1. Always check for self-assignment (`if (this != &rhs)`).
  2. Return `*this` as a reference to allow chained assignments (`a = b = c`).
- **Synthesized version**: Performs a shallow copy of all fields.

## Rule of Three
If a class defines any of the following, it almost always needs to define all three:
1. **Destructor** (`~ClassName()`)
2. **Copy Constructor**
3. **Assignment Operator**

This is usually necessary when the class manages dynamic resources (like heap memory) to ensure deep copies and proper cleanup.

## Special Keywords
- **`default`**: Explicitly ask the compiler for the synthesized version (e.g., `Point() = default;`).
- **`delete`**: Disable a synthesized version to prevent its use (e.g., `Point(const Point& p) = delete;` prevents copying).

## Related
- [[C++ Classes]]
- [[Heap Management]]
- [[Smart Pointers]]
- [[Inheritance]]
