# CSE 333: Smart Pointers

Smart pointers are objects that store pointers to heap-allocated objects and manage their lifetime automatically using the RAII pattern.

## Overview
A **smart pointer** looks and behaves like a regular pointer by overloading the `*` and `->` operators. Its primary goal is to ensure that `delete` is called on the heap memory at the correct time, preventing memory leaks and dangling pointers.

## `std::unique_ptr`
A **`unique_ptr`** represents sole ownership of a pointer.
- It cannot be copied (the copy constructor and assignment operator are deleted).
- It **can be moved** using `std::move()`.
- Its destructor automatically calls `delete` on the owned pointer when the `unique_ptr` goes out of scope.
- **Methods**:
  - `get()`: Returns the raw pointer (dangerous).
  - `release()`: Relinquishes ownership and returns the raw pointer (responsibility for deletion passes to caller).
  - `reset(ptr)`: Deletes current object and takes ownership of a new pointer.

## `std::shared_ptr`
A **`shared_ptr`** allows multiple owners for the same heap object.
- It uses **reference counting** to track how many `shared_ptr` instances point to the same object.
- The reference count is incremented when a `shared_ptr` is copied and decremented when one is destroyed.
- When the reference count reaches 0, the owned object is automatically deleted.

## `std::weak_ptr`
A **`weak_ptr`** points to an object managed by a `shared_ptr` but does not contribute to the reference count.
- It is used to break circular references (cycles) that would otherwise prevent memory from being freed.
- You cannot dereference a `weak_ptr` directly. You must call **`lock()`** to obtain a temporary `shared_ptr`. If the object has been deleted, `lock()` returns a null `shared_ptr`.

## Move Semantics
Introduced in C++11, **move semantics** allow for "stealing" the resources of an object instead of copying them.
- **`std::move()`**: Casts an object to an "rvalue reference," signaling to the compiler that the object can be moved from.
- This is essential for `unique_ptr` since it cannot be copied. Moving a `unique_ptr` transfers ownership from the source to the destination.

## Reference Counting Perspective
**Reference counting** is a technique for managing resources by storing the number of references to them.
- **Pros**: Automated cleanup, prevents premature deletion.
- **Cons**: Overhead of maintaining counts, cannot handle cycles without help (like `weak_ptr`).

## Related
- [[Heap Management]]
- [[Constructor Details]]
- [[Templates]]
- [[Inheritance]]
