# Pure Virtual
- **Pure Virtual**: This means that the derived classes must implement this function as there is no implementation
- **makes the class abstract**: cannot be called by the class
## Read only
```c++
virtual std::string ToString() const = 0;
```
- **Read-only**: const = 0 tells the compiler that the object state cannot be modified within this function
- **const objects can use it**
## Read and Write
```c++
virtual std::string ToString() = 0;
```
- **Modifiable**: can change member variables
- **Cannot be called on const objects**: a const object calling on this will cause a compuler error
# Regular Virtual
- **Virtual**: Can be overriden
- **Not abstract**: can be called by current class
## Read only
```c++
virtual std::string ToString() const { return x_ };
```
- **Read-only**: Cannot modify obkect state
- **Can be called on const objects**
## Read and Write
```c++
```c++
virtual std::string ToString() { x_++; return x_ };
```
- **Modifiable**: Can change member variables
- **Cannot be called on const objects**

[[Virtual Indentifier]]