A smart pointer points to a pointer however, it takes care of memory management for you. It ensures memory is deallocated when it is no longer needed
- It deallocates the pointer when it goes out of scope
- Protects against dangling pointers
- clear ownership semantics
If you delare the pointer like
```c++
std::unique_ptr<Class> name(new Class()); // calls constructor once

std::shared_ptr<Class> name2 = otherSharedPtr // does not call a constructor

std::sahred_ptr<Class> name2 = std::move(name) // does not call constructor

name2 = nullptr // calls deconstrutor
```

