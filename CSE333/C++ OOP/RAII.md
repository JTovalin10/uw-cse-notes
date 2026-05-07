# CSE 333: RAII (Resource Allocation Is Initialization)

**RAII** is the most important programming idiom in C++. it binds the life cycle of a resource (heap memory, file handles, network sockets, mutexes) to the life cycle of a stack-allocated object.

## The Core Concept
1.  **Acquisition**: A resource is acquired in the **Constructor**.
2.  **Release**: The resource is automatically released in the **Destructor**.

Because the C++ compiler guarantees that an object's destructor is called when it goes out of scope (even if an exception is thrown), the resource is guaranteed to be cleaned up.

```cpp
class FileHandler {
 public:
  FileHandler(const char* filename) {
    file_ = fopen(filename, "r"); // Resource Acquired
  }
  ~FileHandler() {
    if (file_) fclose(file_);      // Resource Released
  }
 private:
  FILE* file_;
};
```

## Why it Matters (The "Why")

### 1. Exception Safety
In languages without RAII (like C), an exception or early `return` can bypass a `free()` or `fclose()` call, leading to leaks. In C++, RAII ensures the cleanup code *always* runs as the stack unwinds.

### 2. Manual vs. Automatic Management
- **Manual**: You must remember to pair every `malloc` with a `free`.
- **RAII**: You manage the **object**, and the object manages the **resource**.

## Common RAII Examples in C++
- **Smart Pointers**: `std::unique_ptr` and `std::shared_ptr` manage heap memory.
- **Locks**: `std::lock_guard` and `std::unique_lock` manage mutexes.
- **Containers**: `std::vector` and `std::string` manage their own internal dynamic arrays.
- **File Streams**: `std::fstream` automatically closes files.

## RAII and the Rule of Five
If you are writing an RAII class to manage a raw resource, you must follow the **[[Object Lifecycle#The Rule of Five|Rule of Five]]** to ensure that copying or moving the object doesn't lead to double-frees or dangling pointers.

## Related
- [[C++ Classes]]
- [[Object Lifecycle]]
- [[C++ Fundamentals/Heap Management|Heap Management]]
- [[Smart Pointers/Smart Pointers|Smart Pointers]]
- [[Concurrency/C++ Concurrency|C++ Concurrency (Locks)]]
