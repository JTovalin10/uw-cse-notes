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
C++'s constructors and destructors enable a powerful pattern called **RAII**.
- Resources (like heap memory, file handles, or locks) are acquired in a constructor and released in a destructor.
- Because the destructor is called automatically when an object goes out of scope, the resource is guaranteed to be released, even in the presence of exceptions.

## Related
- [[C++ Introduction]]
- [[Smart Pointers]]
- [[Constructor Details]]
