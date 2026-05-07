# CSE 333: Weak Pointer

A **`std::weak_ptr`** is a smart pointer that holds a non-owning ("weak") reference to an object that is managed by `std::shared_ptr`.

## Purpose
The primary purpose of a `weak_ptr` is to break **circular references** (cycles). If two objects hold `shared_ptr`s to each other, their reference counts will never reach zero, even if they are otherwise unreachable, causing a memory leak. Using a `weak_ptr` for one of the links prevents this cycle.

## Key Properties
- **Does not contribute to reference count**: Creating or destroying a `weak_ptr` does not affect the `use_count()` of the associated `shared_ptr`.
- **Cannot be dereferenced directly**: You cannot use `*` or `->` on a `weak_ptr`.
- **Must be "locked" to use**: To access the object, you must convert the `weak_ptr` to a `shared_ptr` using the **`lock()`** method.

## Code Example: Breaking a Cycle

```c++
#include <iostream>
#include <memory>

struct Node {
    std::string name;
    std::shared_ptr<Node> next;
    std::weak_ptr<Node> prev; // Use weak_ptr to break the cycle

    Node(std::string n) : name(n) {
        std::cout << "Constructing " << name << std::endl;
    }
    ~Node() {
        std::cout << "Destructing " << name << std::endl;
    }
};

int main() {
    auto head = std::make_shared<Node>("Head");
    auto tail = std::make_shared<Node>("Tail");

    head->next = tail;
    tail->prev = head; // prev is a weak_ptr

    // Accessing through weak_ptr
    if (auto p = tail->prev.lock()) {
        std::cout << "Tail's prev is: " << p->name << std::endl;
    }

    return 0;
} // Both Head and Tail are correctly destructed here
```

## Common Methods
- **`lock()`**: Returns a `shared_ptr` to the object if it still exists; otherwise returns `nullptr`.
- **`expired()`**: Returns `true` if the managed object has already been deleted.
- **`use_count()`**: Returns the number of `shared_ptr` instances managing the object.

---

## Related
- [[CSE333/Smart Pointers/Smart Pointers|Smart Pointers]]
- [[CSE333/Smart Pointers/Shared Pointer|Shared Pointer]]
- [[CSE333/Smart Pointers/Unique Pointer|Unique Pointer]]
