# Include
To start, to include a vector (class) we need to include it at the top of the file with 
```c++
#include <vector>
```

# How to define
```c++
#include <vector>
int main() {
	std::vector<T> name;

	// example
	std::vector<int> nums;
}
```

# Initialization
```c++
int main() {
	std::vector<int> nums = {1,2,3,4,5,6};
	// or
	std::vector<int> nums{1,2,3,4,5,6};
	// or
	std::vector<int> nums(3,2); // equalvent to {3,3,3}
}
```
# Functions
## Iterators
There are two main iterator functions to know
```c++
vector.begin(); // points to the beginning of the vector
vector.end(); // points to the end of the vector
```
To iterator the vector we do
```c++
int main() {
	for (auto it = vector.begin(); it != vector.end(); ++i) {
		cout << *it << endl;
	}
}
```


## Capacity
```c++
vector.size() // returns size
```

# Element Access

```c++
vector[i]          // access element at index i (no bounds checking)
vector.at(i)       // access element at index i (with bounds checking, throws exception)
vector.front()     // access first element
vector.back()      // access last element
vector.data()      // get pointer to underlying array
```

# Modifiers

```c++
// Adding elements
vector.push_back(value)      // add element to the end
vector.emplace_back(args...) // construct element in-place at the end

// Removing elements
vector.pop_back()            // remove last element
vector.clear()               // remove all elements

// Insertion
vector.insert(pos, value)    // insert value at iterator position
vector.insert(pos, n, value) // insert n copies of value at position
vector.insert(pos, first, last) // insert range

// Erasure
vector.erase(pos)            // erase element at position
vector.erase(first, last)    // erase range of elements

// Size modification
vector.resize(n)             // resize container to contain n elements
vector.resize(n, value)      // resize and initialize new elements with value

// Other modifiers
vector.swap(other_vector)    // swap contents with another vector
vector.emplace(pos, args...) // construct element in-place at position
vector.assign(n, value)      // assign new contents (n copies of value)
vector.assign(first, last)   // assign new contents from range
```

# Example Usage

```c++
#include <vector>
#include <iostream>

int main() {
    // Create a vector
    std::vector<int> nums = {10, 20, 30};
    
    // Add elements
    nums.push_back(40);
    nums.emplace_back(50);
    
    // Access elements
    std::cout << "First element: " << nums.front() << std::endl;
    std::cout << "Last element: " << nums.back() << std::endl;
    std::cout << "Element at index 2: " << nums[2] << std::endl;
    
    // Iterate through vector
    std::cout << "All elements: ";
    for (auto num : nums) {  // Range-based for loop (C++11)
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Insert an element at position
    auto it = nums.begin() + 2;
    nums.insert(it, 25);
    
    // Erase an element
    nums.erase(nums.begin());
    
    // Vector size
    std::cout << "Vector size: " << nums.size() << std::endl;
    
    // Clear the vector
    nums.clear();
    std::cout << "Vector size after clear: " << nums.size() << std::endl;
    
    return 0;
}
```

# Performance Considerations

- `push_back()` and `emplace_back()` have amortized constant time complexity
- Insertion and erasure in the middle have linear time complexity
- Random access (using `[]` or `at()`) has constant time complexity
- When possible, reserve memory in advance using `vector.reserve(n)` to avoid reallocations

# Memory Management

```c++
vector.reserve(n)   // reserve storage capacity for n elements
vector.capacity()   // return current storage capacity
vector.shrink_to_fit() // reduce memory usage by freeing unused memory
```

Hope this helps complete your vector documentation!