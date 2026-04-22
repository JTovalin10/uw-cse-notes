# CSE333: Dynamic Memory (new and delete)

In C++, **[[new]]** and **[[delete]]** are operators used for dynamic memory allocation and deallocation on the heap, providing a type-safe alternative to `malloc` and `free`.

## Single Object Allocation

To allocate a single object of type `T`:
```c++
T* ptr = new T(args); // Allocates and calls constructor
```

To deallocate:
```c++
delete ptr; // Calls destructor and frees memory
```

## Array Allocation

To allocate an array of `n` objects of type `T`:
```c++
T* array = new T[n]; // Allocates and calls default constructor for each element
```

To deallocate an array:
```c++
delete[] array; // Must use [] to ensure all destructors are called
```

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

## Related
- [[CSE333/Smart Pointers/Smart Pointer]]
- [[CSE333/Smart Pointers/Unique Pointer]]
- [[CSE333/Smart Pointers/Shared Pointer]]
- [[CSE333/Memory Management/Heap]]
