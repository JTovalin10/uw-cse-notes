This is a type of smart pointer however it has an exclusive ownership mode where only one pointer can own the resource

- If you do ::move the value gets "stolen" so the pointer is pointing to nothing but it does not get deallocated

Cannot be copied, only moved which ensures exactly one owner
[[move]]
```c++
#include <iostream>
#include <memory>

// 1. Defining unique_ptr
void defining_unique_ptr() {
    // Basic initialization with make_unique (preferred, since C++14)
    std::unique_ptr<int> ptr1 = std::make_unique<int>(42);
    
    // Alternative syntax
    auto ptr2 = std::make_unique<int>(100);
    
    // Direct constructor usage (less preferred)
    std::unique_ptr<int> ptr3(new int(200));
    
    // Create a unique_ptr to an array
    std::unique_ptr<int[]> array_ptr = std::make_unique<int[]>(5);
    
    // Initialize with nullptr
    std::unique_ptr<int> empty_ptr = nullptr;
}

// 2. Using unique_ptr
void using_unique_ptr() {
    auto ptr = std::make_unique<int>(42);
    
    // Dereferencing
    *ptr = 100;
    std::cout << "Value: " << *ptr << std::endl;
    
    // Check if pointer is valid
    if (ptr) {
        std::cout << "Pointer is valid" << std::endl;
    }
    
    // Get the raw pointer (use with caution)
    int* raw_ptr = ptr.get();
    
    // Custom class example
    auto obj_ptr = std::make_unique<std::string>("Hello");
    std::cout << "Length: " << obj_ptr->length() << std::endl;
    std::cout << "String: " << *obj_ptr << std::endl;
}

// 3. Transferring ownership
void transferring_ownership() {
    auto ptr1 = std::make_unique<int>(42);
    
    // Move ownership to ptr2
    auto ptr2 = std::move(ptr1);
    
    // ptr1 is now nullptr
    std::cout << "ptr1 is null: " << (ptr1 == nullptr) << std::endl;
    
    // ptr2 now owns the resource
    std::cout << "ptr2 value: " << *ptr2 << std::endl;
    
    // Transfer to function (function takes ownership)
    auto take_ownership(std::unique_ptr<int> ptr) {
        return *ptr * 2;
    }
    
    // Must use std::move to pass to function
    int result = take_ownership(std::move(ptr2));
    
    // ptr2 is now nullptr
    std::cout << "ptr2 is null: " << (ptr2 == nullptr) << std::endl;
}

// 4. Releasing resources explicitly
void releasing_resources() {
    auto ptr = std::make_unique<int>(42);
    
    // Release ownership without deleting
    int* raw_ptr = ptr.release();
    
    // ptr is now nullptr, but raw_ptr points to the resource
    std::cout << "ptr is null: " << (ptr == nullptr) << std::endl;
    std::cout << "raw_ptr value: " << *raw_ptr << std::endl;
    
    // Must manually delete the resource now
    delete raw_ptr;
    
    // Reset with a new resource
    ptr.reset(new int(100));
    std::cout << "New ptr value: " << *ptr << std::endl;
    
    // Reset with nullptr
    ptr.reset();
    std::cout << "ptr is null: " << (ptr == nullptr) << std::endl;
}
```
[[Smart Pointer]]