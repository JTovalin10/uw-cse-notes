# CSE333: C++ Heap Management

C++ provides operators for allocating and deallocating memory on the heap, replacing the `malloc()` and `free()` functions from C with a more type-safe and integrated approach.

## `new` and `delete`

The **`new`** keyword allocates an object or primitive on the heap.

- It allocates the required memory and then invokes the appropriate **constructor** for objects.
- **Syntax**: `Type* ptr = new Type(args);`

The **`delete`** keyword deallocates a heap-allocated object or primitive.

- It invokes the object's **destructor** before freeing the memory.
- **Syntax**: `delete ptr;`

### Arrays on the Heap

To allocate an array on the heap, use **`new[]`**:

- **Syntax**: `Type* array = new Type[size];`
- This default-initializes every element in the array.

To deallocate an array, you **must** use **`delete[]`**:

- **Syntax**: `delete[] array;`
- Using `delete` instead of `delete[]` on an array is **undefined behavior** — it only destructs the first element and may corrupt the heap.

## Template Example

```cpp
template <typename T>
void example(int n) {
    // Single object
    T* temp = new T();
    delete temp;

    // Array
    T* arr = new T[n];
    delete[] arr;
}
```

## `nullptr`

Introduced in C++11, **`nullptr`** is a type-safe null pointer literal.

- It has type `std::nullptr_t`, which is implicitly convertible to any pointer type (`T*`).
- It is **not an integer**, unlike the old `NULL` macro (which was often defined as `0`), so it avoids ambiguity in overloaded function resolution.
- **Advice**: Always prefer `nullptr` in modern C++ code over `NULL` or `0`.

## `malloc` vs. `new`

| Feature | `malloc()` | `new` |
| --- | --- | --- |
| **What is it?** | A library function | A C++ operator |
| **Usage in C++** | Rarely (mostly for C interop) | Standard for objects |
| **Allocates memory for** | Any block of bytes | Specific types/objects |
| **Returns** | `void*` (requires casting) | Appropriate pointer type |
| **Out of memory** | Returns `NULL` | Throws `std::bad_alloc` |
| **Deallocating** | `free()` | `delete` or `delete[]` |
| **Constructors?** | No | Yes (invokes them) |

## RAII: Resource Allocation Is Initialization

C++'s constructors and destructors enable the **RAII** pattern, which ensures resources are automatically released when an object goes out of scope. For a deep dive into how RAII ensures exception safety and prevents leaks, see [[CSE333/C++ OOP/RAII|RAII]].

## Related

- [[CSE333/C++ Fundamentals/C++ Introduction|C++ Introduction]]
- [[CSE333/Smart Pointers/Smart Pointers|Smart Pointers]]
- [[CSE333/C++ OOP/Object Lifecycle|Object Lifecycle]]
- [[CSE333/C++ OOP/RAII|RAII]]

## Industry Standard Terms

- **`new` / `delete`** — C++ heap operators; in modern C++, direct `new`/`delete` is discouraged in favor of smart pointers (RAII wrappers)
- **`nullptr`** — The C++11 null pointer constant; replaces the C `NULL` macro to eliminate integer/pointer ambiguity
- **`std::bad_alloc`** — The exception thrown by `new` when memory allocation fails; can be avoided with `new(std::nothrow)` which returns `nullptr` instead
