# Smart Pointer

A **[[Smart Pointer]]** is a class that wraps a raw pointer to manage the lifetime of the object it points to. Its primary goal is to ensure that `delete` is called on the heap memory at the correct time, preventing memory leaks and dangling pointers. In C++, common types include `std::unique_ptr` (exclusive ownership) and `std::shared_ptr` (reference-counted ownership).
