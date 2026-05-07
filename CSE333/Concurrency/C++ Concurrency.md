# CSE 333: C++11 Concurrency

C++11 introduced a standard library for concurrency (`<thread>`, `<mutex>`, `<atomic>`) that provides a higher-level, type-safe alternative to POSIX pthreads.

## `std::thread` Callables and "Jobs"
`std::thread` is highly flexible; it can execute any **callable** object. This allows you to structure "jobs" in different ways depending on the complexity.

### 1. Function Pointers
The simplest form, used for independent, top-level tasks.
```cpp
void SimpleJob(int id) { /* ... */ }
std::thread t1(SimpleJob, 1);
```

### 2. Lambdas
Ideal for short-lived tasks or when you need to capture local variables.
```cpp
int x = 10;
std::thread t2([x](int y) { 
    std::cout << x + y << std::endl; 
}, 5);
```

### 3. Function Objects (Functors)
Useful when a "job" needs to maintain its own state or internal data.
```cpp
struct BackgroundWorker {
    void operator()(int limit) { /* stateful work */ }
};
std::thread t3(BackgroundWorker(), 100);
```

### 4. Member Functions
Required when a thread needs to operate on a specific object instance. You **must** pass the object's address as the first argument (the `this` pointer).
```cpp
class Manager {
 public:
  void Process() { /* ... */ }
};

Manager m;
std::thread t4(&Manager::Process, &m);
```

---

## Passing Arguments: Value vs. Reference
`std::thread` **copies** all arguments into the thread's internal storage by default. This is safer (prevents data races on local stack variables) but can be confusing.

### Passing by Reference (`std::ref`)
If you want the thread to modify a variable in the calling thread, or if the argument is expensive to copy, you must use **`std::ref()`**.
```cpp
void Increment(int& n) { n++; }

int main() {
    int count = 0;
    // std::thread t(Increment, count); // ERROR: would try to copy count
    std::thread t(Increment, std::ref(count)); // Success
    t.join();
}
```

## Synchronization with `std::mutex`
A **`std::mutex`** (mutual exclusion) prevents multiple threads from accessing shared data simultaneously.

### Lock Management (RAII)
Never call `lock()` and `unlock()` manually. Instead, use RAII wrappers to ensure the mutex is released even if an exception is thrown.

- **`std::lock_guard`**: A simple scoped lock. Locks on construction, unlocks on destruction. Cannot be manually unlocked.
- **`std::unique_lock`**: A more flexible lock. Can be manually locked/unlocked and moved. Essential for use with condition variables.

```cpp
#include <mutex>
#include <vector>

std::mutex mtx;
std::vector<int> data;

void add_data(int x) {
    std::lock_guard<std::mutex> lock(mtx); // RAII Lock
    data.push_back(x);
    // Mutex automatically released when 'lock' goes out of scope
}
```

## Atomics
For simple counters or flags, **`std::atomic<T>`** provides a way to perform thread-safe operations without the overhead of a mutex.
- Examples: `std::atomic<int>`, `std::atomic<bool>`.
- Operations like `++` and `--` are guaranteed to be atomic.

## C++ vs. POSIX pthreads

| Feature | pthreads (C) | std::thread (C++) |
| :--- | :--- | :--- |
| **Interface** | Function-based (void*) | Object-oriented (templates/lambdas) |
| **Safety** | Manual `lock`/`unlock` (error-prone) | RAII `lock_guard` (safe) |
| **Portability** | POSIX-only | Standard C++ (Cross-platform) |
| **Arguments** | Single `void*` (requires casting) | Variadic templates (type-safe) |

## Related
- [[Concurrency Intro]]
- [[Threads]]
- [[C++ OOP/C++ Classes|C++ Classes]]
- [[CSE332/Parallelism/Concurrency And Locks|CSE332: Concurrency and Locks]]
