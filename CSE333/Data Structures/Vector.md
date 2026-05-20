# CSE333: Vector (std::vector)

**`std::vector`** is a C++ standard library container that manages a dynamically resizable array on the heap. It is the most commonly used container in C++ and automatically handles memory allocation and deallocation via [[CSE333/C++ OOP/RAII|RAII]].

## Including and Defining

```cpp
#include <vector>

std::vector<int> nums;             // Empty vector of ints
std::vector<int> nums2 = {1,2,3}; // Initialized with values
std::vector<int> nums3{1,2,3};    // Brace initialization
std::vector<int> nums4(3, 2);     // 3 elements, each initialized to 2: {2, 2, 2}
```

## Element Access

```cpp
vector[i]       // Access element at index i (no bounds checking — undefined behavior if out of range)
vector.at(i)    // Access element at index i (with bounds checking — throws std::out_of_range)
vector.front()  // Access first element
vector.back()   // Access last element
vector.data()   // Get raw pointer to the underlying contiguous array
```

## Iterators

```cpp
vector.begin(); // Iterator pointing to the first element
vector.end();   // Iterator pointing one past the last element (sentinel)

// Range-based for loop (C++11, preferred)
for (auto& elem : vector) { /* ... */ }

// Iterator-based loop
for (auto it = vector.begin(); it != vector.end(); ++it) {
    std::cout << *it << std::endl;
}
```

## Capacity and Size

```cpp
vector.size()      // Number of elements currently stored
vector.capacity()  // Total allocated storage (may be larger than size)
vector.reserve(n)  // Pre-allocate capacity for n elements (avoids repeated reallocations)
vector.resize(n)   // Resize to contain n elements (default-initializes new elements)
vector.resize(n, value) // Resize and initialize new elements with value
vector.shrink_to_fit()  // Release unused capacity back to the heap
```

## Modifiers

```cpp
// Adding elements
vector.push_back(value)       // Add element to the end — amortized O(1)
vector.emplace_back(args...)  // Construct element in-place at the end (avoids extra copy)

// Removing elements
vector.pop_back()             // Remove last element
vector.clear()                // Remove all elements (capacity unchanged)

// Insertion and erasure (O(n) — shifts elements)
vector.insert(pos, value)             // Insert value at iterator position
vector.insert(pos, n, value)          // Insert n copies of value
vector.insert(pos, first, last)       // Insert range [first, last)
vector.erase(pos)                     // Erase element at position
vector.erase(first, last)             // Erase range of elements

// Other
vector.swap(other)            // Swap contents with another vector (O(1))
vector.assign(n, value)       // Replace contents with n copies of value
```

## Performance Considerations

- **`push_back()`** and **`emplace_back()`**: Amortized O(1). When capacity is exceeded, the vector typically doubles its capacity — all elements are moved to new storage.
- **Random access (`[]` or `at()`)**: O(1) — same as a raw array.
- **Insertion or erasure in the middle**: O(n) — requires shifting all subsequent elements.
- **Pre-allocation**: Use `vector.reserve(n)` when you know the approximate number of elements in advance to avoid repeated reallocations.

## Memory Management

`std::vector` is an **RAII** container:

- **Internal Allocation**: Uses [[CSE333/C++ Fundamentals/Heap Management|`new`]] (or a custom allocator) to reserve a contiguous block of memory on the heap.
- **Automatic Deallocation**: When the vector object goes out of scope, its destructor automatically calls `delete[]` on the underlying array — no manual cleanup needed.
- The underlying array is always **contiguous** in memory, making `std::vector` compatible with C APIs via `.data()`.

## Example Usage

```cpp
#include <vector>
#include <iostream>

int main() {
    std::vector<int> nums = {10, 20, 30};

    nums.push_back(40);
    nums.emplace_back(50);

    std::cout << "First: " << nums.front() << std::endl;
    std::cout << "Last:  " << nums.back() << std::endl;
    std::cout << "At 2:  " << nums[2] << std::endl;

    // Range-based for loop
    for (auto num : nums) { std::cout << num << " "; }
    std::cout << std::endl;

    // Insert at position 2
    nums.insert(nums.begin() + 2, 25);

    // Erase first element
    nums.erase(nums.begin());

    std::cout << "Size: " << nums.size() << std::endl;
    nums.clear();
    std::cout << "Size after clear: " << nums.size() << std::endl;

    return 0;
}
```

## Related

- [[CSE333/C++ OOP/RAII|RAII]]
- [[CSE333/C++ Fundamentals/Heap Management|C++ Heap Management]]
- [[CSE333/Memory Management/Heap Management|C Heap Management]]
- [[CSE333/Memory Management/Malloc and Free|Malloc and Free]]
- [[CSE333/C++ OOP/C++ Classes|C++ Classes]]
- [[CSE333/Data Structures/LinkedList|LinkedList]]

## Industry Standard Terms

- **`std::vector`** — The C++ equivalent of a Java `ArrayList` or Python `list`; a dynamic array with O(1) amortized append
- **Amortized O(1)** — Occasionally O(n) (when reallocation occurs), but the total cost of n push_back operations is O(n), so the average per-operation cost is O(1)
- **`emplace_back`** — Constructs an element directly in the vector's storage, avoiding an extra copy or move; preferred over `push_back` for objects with non-trivial constructors
