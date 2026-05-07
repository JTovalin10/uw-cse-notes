# CSE 333: Constructor Details

Constructors are special member functions that initialize newly instantiated objects. In C++, managing how objects are constructed, copied, and assigned is critical for memory safety and performance.

## Initialization Lists
**Initialization lists** are used to initialize member variables before the constructor body executes.
- **Syntax**: `ClassName::ClassName(args) : member1(val1), member2(val2) { ... }`
- **Preferred over assignment** inside the constructor body to avoid unnecessary default initialization followed by assignment.
- **Order**: Members are initialized in the order they are declared in the class, **not** the order in the initialization list.

---

## Special Member Functions: Behavior and Activation

C++ defines six special member functions that govern the lifecycle of an object. If you don't define them, the compiler may synthesize "shallow" versions for you.

| Function | Mechanics (What it does) | Activation (When it's called) |
| :--- | :--- | :--- |
| **Default Constructor** | Allocates space and initializes members to default/garbage values. | `T obj;` or `new T();` |
| **Destructor** | Performs cleanup (e.g., `free`, `delete`, closing file handles). | Object goes out of scope or `delete ptr;` is called. |
| **Copy Constructor** | Creates a **new** object as a duplicate of an existing one. | `T b = a;`, `func(a)` (pass-by-value), or `return a;`. |
| **Copy Assignment** | Overwrites an **existing** object's data with another's. | `b = a;` (when both `a` and `b` were already initialized). |
| **Move Constructor** | Creates a **new** object by "stealing" resources from a temporary. | `T b = std::move(a);` or `T b = GetTemp();`. |
| **Move Assignment** | Overwrites an **existing** object by "stealing" from a temporary. | `b = std::move(a);` or `b = GetTemp();`. |

### 1. Copy vs. Move Mechanics
- **Copying**: Allocates new memory and duplicates the data. Both objects are independent afterward.
- **Moving**: Does not allocate new memory. It takes the pointer from the source and gives it to the destination. The source's pointer is typically set to `nullptr` to prevent double-frees.

### 2. Copy Constructor vs. Assignment
The activation difference is critical:
- **Copy Constructor** is for **initialization**: The object on the left-hand side is being born.
- **Assignment** is for **replacement**: The object on the left-hand side already exists and may already hold resources that need to be freed before the new data is copied in.

---

## The Rule of Five
If a class manages a resource (like a raw heap pointer), you must implement all five of these to ensure "Deep" behavior:
1.  **Destructor**: To free the owned resource.
2.  **Copy Constructor**: To allocate new memory and copy data.
3.  **Copy Assignment**: To free existing memory, then allocate and copy new data (check for self-assignment!).
4.  **Move Constructor**: To copy the pointer and null out the source.
5.  **Move Assignment**: To free existing memory, then copy the pointer and null out the source.

---

## The Rule of Zero
Modern C++ design encourages the **Rule of Zero**: If your class does not directly manage raw resources (e.g., it only uses `std::vector`, `std::string`, or `std::unique_ptr`), you should **not define any of the special member functions**.
- The compiler-generated versions will automatically do the right thing (calling the move/copy/destructors of the members).
- This is safer and less code to maintain.

---

## Move Mechanics: The Silent Fallback
A common point of confusion is what happens when you use `std::move()` on an object that doesn't have a move constructor defined.

- **The Fallback**: If a type is passed to `std::move()` but lacks a move constructor, the compiler **silently falls back to the copy constructor**.
- **Why**: `std::move(obj)` casts `obj` to an rvalue reference (`T&&`). Because `const T&` (the copy constructor's parameter) can bind to an rvalue, the copy constructor is a valid match.
- **Performance Note**: This means your code will still compile and run, but you lose the performance benefits of moving.

---

## Explicit Control: `= default` and `= delete`

- **`= default`**: Explicitly asks the compiler to generate the synthesized version. Useful if you want the "shallow" version despite having other constructors.
  ```cpp
  class Point {
   public:
    Point(int x, int y) : x_(x), y_(y) {}
    Point() = default; // Still want a no-arg constructor
   private:
    int x_, y_;
  };
  ```
- **`= delete`**: Disables the function. Used to make objects **non-copyable** (common for classes managing unique resources like File Handles).
  ```cpp
  class NonCopyable {
   public:
    NonCopyable(const NonCopyable&) = delete;            // No copy constructor
    NonCopyable& operator=(const NonCopyable&) = delete; // No copy assignment
  };
  ```

## Related
- [[C++ Classes]]
- [[C++ Fundamentals/Heap Management|Heap Management]]
- [[Smart Pointers/Smart Pointers|Smart Pointers]]
- [[Inheritance]]
