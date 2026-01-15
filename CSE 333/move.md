This is a more efficient way to transfer resources from one object to another without making a copy. 
- avoids expensive deep copies
- Transfers unique ownerships [[Unique Pointer]]
It allows objects to "steal" rather than copy
```c++
class MyClass {
private:
    int* data;
    
public:
    // Regular constructor
    MyClass(int value) : data(new int(value)) {}
    
    // Copy constructor
    MyClass(const MyClass& other) : data(new int(*other.data)) {
        std::cout << "Copy constructor called" << std::endl;
    }
    
    // Move constructor
    MyClass(MyClass&& other) noexcept : data(other.data) {
        other.data = nullptr; // Leave the source in a valid but unspecified state
        std::cout << "Move constructor called" << std::endl;
    }
    
    // Move assignment operator
    MyClass& operator=(MyClass&& other) noexcept {
        if (this != &other) {
            delete data;
            data = other.data;
            other.data = nullptr; // Leave the source in a valid but unspecified state
        }
        std::cout << "Move assignment called" << std::endl;
        return *this;
    }
    
    ~MyClass() {
        delete data;
    }
};
```
[[Smart Pointer]]