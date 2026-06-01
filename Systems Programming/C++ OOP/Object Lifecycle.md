# CSE333: Object Lifecycle

Constructors are special member functions that initialize newly instantiated objects. In C++, managing how objects are constructed, copied, moved, and destroyed is critical for memory safety and performance.

## Initialization Lists

**Initialization lists** initialize member variables before the constructor body executes.

- **Syntax**: `ClassName::ClassName(args) : member1(val1), member2(val2) { ... }`
- **Preferred over assignment** inside the constructor body: using an initialization list avoids a redundant default initialization followed by an assignment.
- **Order**: Members are initialized in the order they are **declared in the class**, not the order listed in the initialization list.

---

## Special Member Functions: Behavior and Activation

C++ defines six special member functions that govern the lifecycle of an object. If you do not define them, the compiler may synthesize "shallow" versions automatically.

| Function | Mechanics (What it does) | Activation (When it's called) |
| :--- | :--- | :--- |
| **Default Constructor** | Allocates space and initializes members to default or garbage values. | `T obj;` or `new T();` |
| **Destructor** | Performs cleanup (e.g., `free`, `delete`, closing file handles). | Object goes out of scope or `delete ptr;` is called. |
| **Copy Constructor** | Creates a **new** object as a duplicate of an existing one. | `T b = a;`, `func(a)` (pass-by-value), or `return a;`. |
| **Copy Assignment** | Overwrites an **existing** object's data with another's. | `b = a;` (when both `a` and `b` were already initialized). |
| **Move Constructor** | Creates a **new** object by "stealing" resources from a temporary. | `T b = std::move(a);` or `T b = GetTemp();`. |
| **Move Assignment** | Overwrites an **existing** object by "stealing" from a temporary. | `b = std::move(a);` or `b = GetTemp();`. |

### Copy vs. Move Mechanics

- **Copying**: Allocates new memory and duplicates the data. Both objects are independent afterward.
- **Moving**: Does not allocate new memory. It takes the pointer from the source and gives it to the destination. The source's pointer is set to `nullptr` to prevent double-frees.

### Copy Constructor vs. Assignment

The activation difference is critical:

- **Copy Constructor** is for **initialization**: The object on the left-hand side is being born for the first time.
- **Assignment** is for **replacement**: The object on the left-hand side already exists and may hold resources that need to be freed before the new data is copied in.

---

## The Rule of Five

If a class manages a raw resource (like a heap pointer), you must implement all five of these special functions to ensure "deep" copy and move behavior:

1. **Destructor**: To free the owned resource.
2. **Copy Constructor**: To allocate new memory and copy data.
3. **Copy Assignment**: To free existing memory, then allocate and copy new data (always check for self-assignment first: `if (this == &other) return *this;`).
4. **Move Constructor**: To copy the pointer and null out the source.
5. **Move Assignment**: To free existing memory, then copy the pointer and null out the source.

---

## The Rule of Zero

Modern C++ design encourages the **Rule of Zero**: If your class does not directly manage raw resources (e.g., it only uses `std::vector`, `std::string`, or `std::unique_ptr`), you should **not define any of the special member functions**. The compiler-generated versions will automatically call the move/copy/destructors of the member objects, doing the right thing.

---

## Move Mechanics: The Silent Fallback

A common point of confusion is what happens when `std::move()` is used on an object without a move constructor.

- **The Fallback**: If a type lacks a move constructor, the compiler **silently falls back to the copy constructor**.
- **Why**: `std::move(obj)` casts `obj` to an rvalue reference (`T&&`). Because `const T&` (the copy constructor's parameter) can bind to an rvalue, the copy constructor is a valid match.
- **Performance Note**: The code still compiles and runs, but you lose the performance benefit of moving.

---

## Explicit Control: `= default` and `= delete`

- **`= default`**: Explicitly asks the compiler to generate the synthesized version.
  ```cpp
  class Point {
   public:
    Point(int x, int y) : x_(x), y_(y) {}
    Point() = default; // Compiler generates the no-arg constructor
   private:
    int x_, y_;
  };
  ```
- **`= delete`**: Disables the function entirely. Used to make objects non-copyable (common for classes managing unique resources like file handles).
  ```cpp
  class NonCopyable {
   public:
    NonCopyable(const NonCopyable&) = delete;
    NonCopyable& operator=(const NonCopyable&) = delete;
  };
  ```

## Related

- [[C++ Classes|C++ Classes]]
- [[Systems Programming/C++ Fundamentals/Heap Management|C++ Heap Management]]
- [[Smart Pointers|Smart Pointers]]
- [[Inheritance|Inheritance]]
- [[RAII|RAII]]

## Industry Standard Terms

- **Rule of Five / Rule of Zero** — Core C++ resource management guidelines; the "Rule of Three" was the C++03 predecessor (before move semantics)
- **Move semantics** — The C++11 feature that enables transferring ownership of resources without copying; enabled via rvalue references (`T&&`) and `std::move()`
- **rvalue reference (`T&&`)** — A reference that binds to temporaries; the mechanism underlying move semantics and perfect forwarding
- **`= delete`** — Explicitly disabling a special member function; used to enforce non-copyability, non-assignability, or to prevent accidental implicit conversions
