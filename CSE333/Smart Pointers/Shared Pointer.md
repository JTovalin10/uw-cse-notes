Can read/write to the pointer and multiple shared pointers can point to the same resource.

- It is important to note that a shared pointer is only deconstructed if there is only once shared pointer pointing to the object or if all objects go out of scope (exit the stack)
- If one shared pointer gets declared a nullptr then all sharedptrs are declared a nullptr (but only calls the deconstructor once)

```c++
#include <iostream>
#include <memory>
#include <vector>

/*
WHAT MAKES std::shared_ptr DIFFERENT:

- Shared Ownership: Multiple shared_ptrs can own the same resource (unlike unique_ptr's exclusive ownership)
- Reference Counting: Automatically tracks how many shared_ptrs point to the resource
- Copy Semantics: Can be copied freely (unique_ptr can only be moved)
- Automatic Cleanup: Resource is deleted only when the last shared_ptr is destroyed
- Thread Safety: Reference counting operations are atomic/thread-safe
- Higher Overhead: Slightly more expensive than unique_ptr due to reference counting mechanism
- Potential for Cycles: Can create memory leaks with circular references (solved with weak_ptr)
- Control Block: Uses an additional memory allocation for the reference counting mechanism
*/

// 1. Defining shared_ptr
void defining_shared_ptr() {
    // Basic initialization with make_shared (preferred for performance)
    std::shared_ptr<int> ptr1 = std::make_shared<int>(42);
    
    // Alternative syntax
    auto ptr2 = std::make_shared<int>(100);
    
    // Direct constructor usage (less preferred)
    std::shared_ptr<int> ptr3(new int(200));
    
    // Create a shared_ptr to an array (requires custom deleter)
    std::shared_ptr<int[]> array_ptr(new int[5], std::default_delete<int[]>());
    
    // Initialize with nullptr
    std::shared_ptr<int> empty_ptr = nullptr;
}

// 2. Using shared_ptr
void using_shared_ptr() {
    auto ptr = std::make_shared<int>(42);
    
    // Dereferencing
    *ptr = 100;
    std::cout << "Value: " << *ptr << std::endl;
    
    // Check if pointer is valid
    if (ptr) {
        std::cout << "Pointer is valid" << std::endl;
    }
    
    // Get the raw pointer (use with caution)
    int* raw_ptr = ptr.get();
    
    // Get reference count
    std::cout << "Reference count: " << ptr.use_count() << std::endl;
    
    // Custom class example
    auto obj_ptr = std::make_shared<std::string>("Hello");
    std::cout << "Length: " << obj_ptr->length() << std::endl;
    std::cout << "String: " << *obj_ptr << std::endl;
}

// 3. Sharing ownership
void sharing_ownership() {
    // Create first shared_ptr
    auto ptr1 = std::make_shared<int>(42);
    std::cout << "Initial ref count: " << ptr1.use_count() << std::endl;
    
    // Create a second shared_ptr to the same resource
    auto ptr2 = ptr1;  // No need for std::move, copying is allowed
    std::cout << "Ref count after copy: " << ptr1.use_count() << std::endl;
    
    // Create a third shared_ptr
    std::shared_ptr<int> ptr3 = ptr2;
    std::cout << "Ref count after another copy: " << ptr1.use_count() << std::endl;
    
    // Modify through any pointer affects all
    *ptr2 = 100;
    std::cout << "Value through ptr1: " << *ptr1 << std::endl;
    std::cout << "Value through ptr3: " << *ptr3 << std::endl;
    
    // Store in a container
    std::vector<std::shared_ptr<int>> vec;
    vec.push_back(ptr1);
    vec.push_back(std::make_shared<int>(200));
    std::cout << "Ref count after storing in vector: " << ptr1.use_count() << std::endl;
}

// 4. Releasing and resetting
void releasing_and_resetting() {
    auto ptr1 = std::make_shared<int>(42);
    auto ptr2 = ptr1;
    
    std::cout << "Ref count: " << ptr1.use_count() << std::endl;
    
    // Reset one pointer
    ptr1.reset();
    std::cout << "ptr1 is null: " << (ptr1 == nullptr) << std::endl;
    std::cout << "Ref count via ptr2: " << ptr2.use_count() << std::endl;
    
    // Reset with a new resource
    ptr1.reset(new int(100));
    std::cout << "ptr1 new value: " << *ptr1 << std::endl;
    std::cout << "Ref count for new resource: " << ptr1.use_count() << std::endl;
    
    // Last pointer reset will deallocate
    ptr2.reset();
    std::cout << "Resource deallocated when last pointer reset" << std::endl;
}

// 5. Custom deleters
void custom_deleters() {
    // Custom deleter function
    auto custom_deleter = [](int* p) {
        std::cout << "Custom deleting resource: " << *p << std::endl;
        delete p;
    };
    
    // Create shared_ptr with custom deleter
    std::shared_ptr<int> ptr(new int(42), custom_deleter);
    
    // Resource will be deleted with custom deleter when ref count reaches zero
}
```
[[Smart Pointer]]