# CSE333: Shared Pointer

A **`std::shared_ptr`** allows multiple owners for the same heap-allocated object. It uses **reference counting** to manage the resource's lifetime — the resource is deleted only when the last `shared_ptr` that owns it is destroyed or reset.

## Key Properties

- **Shared Ownership**: Multiple `shared_ptr`s can own the same resource simultaneously.
- **Reference Counting**: The system tracks how many `shared_ptr`s point to the resource. When the count reaches zero, the resource is deleted.
- **Copying**: Assigning or copying a `shared_ptr` increments the reference count. Both pointers are valid owners.
- **Nullification**: Setting one `shared_ptr` to `nullptr` (or it going out of scope) decrements the reference count. Other `shared_ptr`s to the same resource remain valid.
- **Thread Safety**: Reference count operations are atomic, making it safe to copy `shared_ptr`s across threads. However, the pointed-to object itself is not thread-safe unless you protect it with a mutex.
- **Higher Overhead**: Slightly more expensive than `unique_ptr` due to the reference counting mechanism and the extra control block allocation.

## Defining and Using shared_ptr

```cpp
#include <memory>

// Preferred: make_shared — single allocation for object and control block
auto ptr1 = std::make_shared<int>(42);

// Alternative: direct constructor (two allocations)
std::shared_ptr<int> ptr2(new int(200));

// Sharing ownership — ref count becomes 2
auto ptr3 = ptr1;  // No std::move needed; copying is allowed
std::cout << "Ref count: " << ptr1.use_count() << std::endl; // 2

// Modifying through any pointer affects the shared object
*ptr3 = 100;
std::cout << "Value via ptr1: " << *ptr1 << std::endl; // 100

// Checking the raw pointer
int* raw = ptr1.get(); // Use with caution — do not delete

// Custom deleter (for non-standard cleanup)
auto custom_deleter = [](int* p) { delete p; };
std::shared_ptr<int> ptr4(new int(42), custom_deleter);
```

## Releasing and Resetting

```cpp
auto ptr1 = std::make_shared<int>(42);
auto ptr2 = ptr1; // ref count = 2

// Reset one pointer — decrements ref count
ptr1.reset();
std::cout << "Ref count via ptr2: " << ptr2.use_count() << std::endl; // 1

// Reset with a new resource (ptr1 now owns a different object)
ptr1.reset(new int(100)); // ref count for new object = 1

// When ptr2 goes out of scope, ref count for 42 reaches 0 and it is deleted
```

## Potential for Cycles

`shared_ptr` **cannot handle circular references**. If two objects hold `shared_ptr`s to each other, their reference counts will never reach zero, causing a memory leak. Use [[Weak Pointer|`std::weak_ptr`]] to break such cycles.

## Related

- [[Smart Pointers|Smart Pointers]]
- [[Unique Pointer|Unique Pointer]]
- [[Weak Pointer|Weak Pointer]]
- [[Object Lifecycle|Object Lifecycle]]

## Industry Standard Terms

- **`std::shared_ptr`** — Reference-counted shared ownership pointer; similar to `Arc<T>` in Rust, `SharedPtr` in Swift, and managed references in Java/Python
- **Reference counting** — A memory management technique where each object tracks how many references point to it; when the count reaches zero, the object is freed
- **Control block** — The internal `shared_ptr` data structure that stores the reference count, weak reference count, and custom deleter; allocated separately from the managed object (unless `make_shared` is used, which co-locates them)
- **`std::make_shared`** — The preferred factory (C++11); combines the object and control block into a single allocation, improving cache locality and reducing allocation overhead
