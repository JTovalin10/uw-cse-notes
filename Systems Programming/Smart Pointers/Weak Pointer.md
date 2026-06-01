# CSE333: Weak Pointer

A **`std::weak_ptr`** is a smart pointer that holds a non-owning ("weak") reference to an object managed by `std::shared_ptr`.

## Purpose

The primary purpose of a `weak_ptr` is to break **circular references** (cycles). If two objects hold `shared_ptr`s to each other, their reference counts will never reach zero — even if they are otherwise unreachable from the rest of the program — causing a memory leak. Using a `weak_ptr` for one of the links prevents this cycle.

## Key Properties

- **Does not contribute to reference count**: Creating or destroying a `weak_ptr` does not affect the `use_count()` of the associated `shared_ptr`.
- **Cannot be dereferenced directly**: You cannot use `*` or `->` on a `weak_ptr` because the referenced object may have been deleted already.
- **Must be "locked" to use**: To access the object, you must convert the `weak_ptr` to a `shared_ptr` using the **`lock()`** method. If the object has been deleted, `lock()` returns `nullptr`.

## Code Example: Breaking a Cycle

```cpp
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
    tail->prev = head; // prev is a weak_ptr — does not prevent head's destruction

    // Accessing through weak_ptr requires locking first
    if (auto p = tail->prev.lock()) {
        std::cout << "Tail's prev is: " << p->name << std::endl;
    }

    return 0;
} // Both Head and Tail are correctly destructed here
```

Without `weak_ptr`, `head` and `tail` would each hold a `shared_ptr` to the other. Their reference counts would both be 1 when `main()` exits, so neither would be destroyed — a memory leak.

## Common Methods

- **`lock()`**: Returns a `shared_ptr` to the object if it still exists; otherwise returns `nullptr`. This is the safe way to access the object.
- **`expired()`**: Returns `true` if the managed object has already been deleted (the `use_count` of the associated `shared_ptr` is 0).
- **`use_count()`**: Returns the number of `shared_ptr` instances that currently own the managed object.

## Related

- [[Smart Pointers|Smart Pointers]]
- [[Shared Pointer|Shared Pointer]]
- [[Unique Pointer|Unique Pointer]]

## Industry Standard Terms

- **`std::weak_ptr`** — A non-owning observer pointer; the C++ standard library's solution to the cyclic reference problem inherent in reference-counted ownership
- **Circular reference** — A cycle in the ownership graph where A owns B and B owns A; causes a memory leak in reference-counted systems because the count never reaches zero
- **`lock()`** — The `weak_ptr` method that atomically checks if the object is alive and, if so, returns a `shared_ptr` that keeps it alive for the duration of the access
