# CSE 333: Smart Pointers

**Smart pointers** are objects that store pointers to heap-allocated objects and manage their lifetime automatically using the **Resource Acquisition Is Initialization (RAII)** pattern.

## Overview
A smart pointer looks and behaves like a regular (raw) pointer by overloading the `*` and `->` operators. Its primary goal is to ensure that `delete` is called on the heap memory at the correct time, preventing:
1. **Memory Leaks**: Memory that is never freed.
2. **Dangling Pointers**: Pointers that point to memory that has already been freed.
3. **Double Frees**: Attempting to free the same memory twice.

## Types of Smart Pointers (C++11)

### 1. `std::unique_ptr`
- **Ownership**: Exclusive. Exactly one `unique_ptr` owns the resource.
- **Copying**: Not allowed.
- **Moving**: Allowed (transfers ownership).
- See more: [[CSE333/Smart Pointers/Unique Pointer|Unique Pointer]]

### 2. `std::shared_ptr`
- **Ownership**: Shared. Multiple `shared_ptr` instances can point to the same resource.
- **Mechanism**: Reference counting.
- **Copying**: Allowed (increments reference count).
- See more: [[CSE333/Smart Pointers/Shared Pointer|Shared Pointer]]

### 3. `std::weak_ptr`
- **Ownership**: None. Points to a resource managed by a `shared_ptr` without contributing to the reference count.
- **Use Case**: Breaking circular references.
- See more: [[CSE333/Smart Pointers/Weak Pointer|Weak Pointer]]

---

## Comparison Table

| Smart Pointer | Copyable? | Movable? | Ref Count? | Best Use Case |
| :--- | :--- | :--- | :--- | :--- |
| `unique_ptr` | No | Yes | No | Local variables, member variables with clear owner. |
| `shared_ptr` | Yes | Yes | Yes | Resources shared across multiple components (e.g., caches). |
| `weak_ptr` | Yes | Yes | No | Observers, breaking cycles in linked data structures. |

---

## Related
- [[CSE333/Memory Management/Heap Management|Heap Management]]
- [[CSE333/C++ OOP/Object Lifecycle|Object Lifecycle]]
- [[CSE333/C++ Fundamentals/Templates|Templates]]
- [[CSE333/C++ OOP/RAII|RAII]]
