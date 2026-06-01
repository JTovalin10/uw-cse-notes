# CSE333: RAII (Resource Allocation Is Initialization)

**RAII** is the most important programming idiom in C++. It binds the lifecycle of a resource (heap memory, file handles, network sockets, mutexes) to the lifecycle of a stack-allocated object.

## The Core Concept

1. **Acquisition**: A resource is acquired in the **Constructor**.
2. **Release**: The resource is automatically released in the **Destructor**.

Because the C++ compiler guarantees that an object's destructor is called when it goes out of scope (even if an exception is thrown), the resource is guaranteed to be cleaned up — no manual cleanup required.

```cpp
class FileHandler {
 public:
  FileHandler(const char* filename) {
    file_ = fopen(filename, "r"); // Resource Acquired
  }
  ~FileHandler() {
    if (file_) fclose(file_);     // Resource Released automatically
  }
 private:
  FILE* file_;
};
```

## Why it Matters

### Exception Safety

In languages without RAII (like C), an exception or early `return` can bypass a `free()` or `fclose()` call, causing a resource leak. In C++, RAII ensures the cleanup code *always* runs as the stack unwinds — even through exceptions.

### Manual vs. Automatic Management

- **Manual**: You must remember to pair every `malloc` with a `free` and every `open` with a `close`.
- **RAII**: You manage the **object**; the object manages the **resource**. The scope of the object becomes the lifetime of the resource.

## Common RAII Examples in C++

- **Smart Pointers**: `std::unique_ptr` and `std::shared_ptr` manage heap memory. See [[Smart Pointers|Smart Pointers]].
- **Locks**: `std::lock_guard` and `std::unique_lock` manage mutexes. See [[C++ Concurrency|C++ Concurrency]].
- **Containers**: `std::vector` and `std::string` manage their own internal dynamic arrays.
- **File Streams**: `std::fstream` automatically closes files when it goes out of scope.

## RAII and the Rule of Five

If you are writing an RAII class to manage a raw resource, you must follow the **[[Object Lifecycle#The Rule of Five|Rule of Five]]** to ensure that copying or moving the object does not lead to double-frees or dangling pointers.

## Related

- [[C++ Classes|C++ Classes]]
- [[Object Lifecycle|Object Lifecycle]]
- [[Systems Programming/C++ Fundamentals/Heap Management|C++ Heap Management]]
- [[Smart Pointers|Smart Pointers]]
- [[C++ Concurrency|C++ Concurrency (Locks)]]

## Industry Standard Terms

- **RAII** — "Resource Acquisition Is Initialization"; sometimes also described as "Scope-Bound Resource Management" (SBRM) to better capture the idea that the resource's lifetime is bound to a scope
- **Destructor** — The C++ mechanism that enables RAII; called deterministically when an object's scope ends, unlike a garbage collector's finalizer which runs non-deterministically
- **Exception safety** — A property of code that ensures resources are not leaked and invariants are maintained even when exceptions are thrown; RAII enables the "strong guarantee" and "basic guarantee" exception safety levels
