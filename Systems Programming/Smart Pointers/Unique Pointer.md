# CSE333: Unique Pointer

A **`std::unique_ptr`** represents exclusive ownership of a heap-allocated resource. Exactly one `unique_ptr` can own a resource at any given time, making ownership unambiguous and cleanup automatic.

## Key Properties

- **Exclusive Ownership**: Only one pointer can own the resource.
- **No Copying**: The copy constructor and copy assignment operator are deleted.
- **Moving**: Ownership can be transferred using `std::move()`. After a move, the source pointer becomes `nullptr`.
- **Automatic Deallocation**: The resource is deleted when the `unique_ptr` goes out of scope (RAII).

## Defining and Using unique_ptr

```cpp
#include <memory>

// Preferred: make_unique (C++14) — avoids explicit new
auto ptr1 = std::make_unique<int>(42);

// Alternative: direct constructor (less preferred — requires explicit new)
std::unique_ptr<int> ptr2(new int(100));

// Arrays
auto array_ptr = std::make_unique<int[]>(5);

// Initialize with nullptr (empty)
std::unique_ptr<int> empty_ptr = nullptr;

// Dereferencing
*ptr1 = 100;

// Arrow operator for objects
auto obj_ptr = std::make_unique<std::string>("Hello");
std::cout << "Length: " << obj_ptr->length() << std::endl;

// Check if valid
if (ptr1) { /* ptr1 is not null */ }

// Get the raw pointer (use with caution — do not delete it)
int* raw = ptr1.get();
```

## Transferring Ownership

```cpp
auto ptr1 = std::make_unique<int>(42);

// Transfer ownership to ptr2
auto ptr2 = std::move(ptr1);
// ptr1 is now nullptr; ptr2 owns the resource

// Passing ownership to a function
void take_ownership(std::unique_ptr<int> ptr) {
    // ptr owns the resource; it is deleted when this function returns
}
take_ownership(std::move(ptr2)); // Must use std::move
// ptr2 is now nullptr
```

## Releasing Resources Explicitly

```cpp
auto ptr = std::make_unique<int>(42);

// Release ownership without deleting — returns raw pointer
int* raw_ptr = ptr.release();
// ptr is now nullptr; you must manually delete raw_ptr
delete raw_ptr;

// Reset with a new resource (old resource is deleted first)
ptr.reset(new int(100));

// Reset to null (deletes the current resource)
ptr.reset();
```

## Related

- [[Smart Pointers|Smart Pointers]]
- [[Shared Pointer|Shared Pointer]]
- [[Weak Pointer|Weak Pointer]]
- [[Object Lifecycle|Object Lifecycle — Move Semantics]]

## Industry Standard Terms

- **`std::unique_ptr`** — The go-to smart pointer for single ownership; zero overhead compared to a raw pointer in most cases
- **`std::make_unique`** — The preferred factory function (C++14); exception-safe and avoids memory leaks from partial evaluation of arguments in function calls
- **Exclusive ownership** — A design principle where exactly one entity is responsible for an object's lifetime; prevents double-frees and makes ownership transfer explicit via `std::move()`
