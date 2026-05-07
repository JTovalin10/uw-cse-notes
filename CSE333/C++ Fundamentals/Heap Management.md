# CSE 333: Heap Management

C++ provides operators for allocating and deallocating memory on the heap, replacing the `malloc()` and `free()` functions from C with a more type-safe and integrated approach.

## `new` and `delete`
The **`new`** keyword is used to allocate an object or primitive on the heap.
- It allocates memory and then invokes the appropriate **constructor** for objects.
- **Syntax**: `Type* ptr = new Type(args);`

The **`delete`** keyword is used to deallocate a heap-allocated object or primitive.
- It invokes the object's **destructor** before freeing the memory.
- **Syntax**: `delete ptr;`

### Arrays on the Heap
To allocate an array on the heap, use **`new[]`**:
- **Syntax**: `Type* array = new Type[size];`
- This default-initializes every element in the array.

To deallocate an array, you **must** use **`delete[]`**:
- **Syntax**: `delete[] array;`
- Using `delete` instead of `delete[]` on an array is **undefined behavior**.

## Template Example
```c++
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
Introduced in C++11, **`nullptr`** is a new literal used to represent a null pointer.
- It is type-safe (has type `T*` for any `T`) and is not an integer.
- It avoids the ambiguity issues associated with the old `NULL` macro (which was often just `0`).
- **Advice**: Always prefer `nullptr` in modern C++ code.

## `malloc` vs. `new`

| Feature | `malloc()` | `new` |
| --- | --- | --- |
| **What is it?** | A library function | An operator or keyword |
| **Usage in C++** | Rarely (mostly for legacy) | Often |
| **Allocates memory for** | Any block of bytes | Specific types/objects |
| **Returns** | `void*` (requires casting) | Appropriate pointer type |
| **Out of memory** | Returns `NULL` | Throws an exception |
| **Deallocating** | `free()` | `delete` or `delete[]` |
| **Constructors?** | No | Yes (invokes them) |

## RAII: Resource Allocation Is Initialization
C++'s constructors and destructors enable a powerful pattern called **RAII**. For a deep dive into how RAII ensures exception safety and prevents leaks, see: **[[C++ OOP/RAII|RAII]]**.

## Related
- [[C++ Introduction]]
- [[Smart Pointers/Smart Pointers|Smart Pointers]]
- [[C++ OOP/Object Lifecycle|Object Lifecycle]]
