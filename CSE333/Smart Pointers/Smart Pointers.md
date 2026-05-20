# CSE333: Smart Pointers

**Smart pointers** are objects that store pointers to heap-allocated objects and manage their lifetime automatically using the **[[CSE333/C++ OOP/RAII|RAII]]** pattern. They look and behave like raw pointers (by overloading `*` and `->`), but additionally handle cleanup.

## Overview

A smart pointer's primary goal is to ensure that `delete` is called on the heap memory at the correct time, automatically preventing:

1. **Memory Leaks**: Memory that is allocated but never freed.
2. **Dangling Pointers**: Pointers that point to memory that has already been freed.
3. **Double Frees**: Attempting to free the same memory twice.

## Types of Smart Pointers (C++11)

### 1. `std::unique_ptr`

- **Ownership**: Exclusive. Exactly one `unique_ptr` owns the resource at any time.
- **Copying**: Not allowed (copy constructor and assignment are deleted).
- **Moving**: Allowed. `std::move()` transfers ownership; the source becomes `nullptr`.
- See more: [[CSE333/Smart Pointers/Unique Pointer|Unique Pointer]]

### 2. `std::shared_ptr`

- **Ownership**: Shared. Multiple `shared_ptr` instances can point to the same resource.
- **Mechanism**: Reference counting. The resource is deleted when the last `shared_ptr` is destroyed.
- **Copying**: Allowed (increments reference count).
- See more: [[CSE333/Smart Pointers/Shared Pointer|Shared Pointer]]

### 3. `std::weak_ptr`

- **Ownership**: None. Points to a resource managed by a `shared_ptr` without contributing to the reference count.
- **Use Case**: Breaking circular references. Must be "locked" to access the object.
- See more: [[CSE333/Smart Pointers/Weak Pointer|Weak Pointer]]

---

## Move Semantics

**Move semantics** (C++11) allow a smart pointer to transfer ownership of its resource to another pointer without copying the underlying data. This is enabled by **rvalue references** (`T&&`) and `std::move()`.

```cpp
auto p1 = std::make_unique<int>(42);
auto p2 = std::move(p1); // p1 is now nullptr; p2 owns the resource
```

For the full mechanics of move constructors and move assignment, see [[CSE333/C++ OOP/Object Lifecycle|Object Lifecycle]].

---

## Comparison Table

| Smart Pointer | Copyable? | Movable? | Ref Count? | Best Use Case |
| :--- | :--- | :--- | :--- | :--- |
| `unique_ptr` | No | Yes | No | Local variables, member variables with a clear single owner. |
| `shared_ptr` | Yes | Yes | Yes | Resources shared across multiple components (e.g., caches, shared state). |
| `weak_ptr` | Yes | Yes | No | Observers, breaking cycles in linked data structures. |

---

## Related

- [[CSE333/Memory Management/Heap Management|Heap Management]]
- [[CSE333/C++ OOP/Object Lifecycle|Object Lifecycle]]
- [[CSE333/C++ Fundamentals/Templates|Templates]]
- [[CSE333/C++ OOP/RAII|RAII]]

## Industry Standard Terms

- **Smart pointer** — A C++ RAII wrapper around a raw pointer that automates memory management; the standard library provides `unique_ptr`, `shared_ptr`, and `weak_ptr`
- **`std::make_unique` / `std::make_shared`** — Factory functions (C++14 / C++11) preferred over `new` directly; they are exception-safe and, for `shared_ptr`, more efficient (one allocation instead of two)
- **Move semantics** — The C++11 mechanism for transferring ownership of resources without copying; enabled by rvalue references (`T&&`) and `std::move()`
- **Reference counting** — The `shared_ptr` mechanism; a counter tracks how many owners exist and the resource is freed when the count reaches zero; cannot handle cycles (use `weak_ptr`)
