# CSE333: C++11 Concurrency

C++11 introduced a standard library for concurrency (`<thread>`, `<mutex>`, `<atomic>`) that provides a higher-level, type-safe alternative to POSIX pthreads.

## `std::thread` Callables and "Jobs"

`std::thread` is highly flexible; it can execute any **callable** object. This allows you to structure "jobs" in different ways depending on the task's complexity.

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

Required when a thread needs to operate on a specific object instance. You **must** pass the object's address as the first argument (the implicit `this` pointer).

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

`std::thread` **copies** all arguments into the thread's internal storage by default. This is safer (prevents data races on local stack variables that may go out of scope) but can be confusing.

### Passing by Reference (`std::ref`)

If you want the thread to modify a variable in the calling thread, or if the argument is expensive to copy, use **`std::ref()`**.

```cpp
void Increment(int& n) { n++; }

int main() {
    int count = 0;
    std::thread t(Increment, std::ref(count)); // std::ref wraps count by reference
    t.join();
    // count is now 1
}
```

---

## Synchronization with `std::mutex`

A **`std::mutex`** prevents multiple threads from accessing shared data simultaneously.

### Lock Management (RAII)

Never call `lock()` and `unlock()` manually — an exception between them will leave the mutex permanently locked. Instead, use RAII wrappers:

- **`std::lock_guard`**: A simple scoped lock. Locks on construction, unlocks on destruction. Cannot be manually unlocked.
- **`std::unique_lock`**: A more flexible lock. Can be manually locked and unlocked and can be moved. Essential for use with condition variables.

```cpp
#include <mutex>
#include <vector>

std::mutex mtx;
std::vector<int> data;

void add_data(int x) {
    std::lock_guard<std::mutex> lock(mtx); // RAII: locks here, unlocks at end of scope
    data.push_back(x);
}
```

---

## Atomics

For simple counters or flags, **`std::atomic<T>`** provides thread-safe operations without the overhead of a mutex.

- Examples: `std::atomic<int>`, `std::atomic<bool>`.
- Operations like `++`, `--`, `fetch_add()`, and `compare_exchange_strong()` are guaranteed to be atomic.

---

## C++ vs. POSIX pthreads

| Feature | pthreads (C) | `std::thread` (C++) |
| :--- | :--- | :--- |
| **Interface** | Function-based (`void*`) | Object-oriented (templates, lambdas) |
| **Safety** | Manual `lock`/`unlock` (error-prone) | RAII `lock_guard` (safe) |
| **Portability** | POSIX-only | Standard C++ (cross-platform) |
| **Arguments** | Single `void*` (requires casting) | Variadic templates (type-safe) |

## Related

- [[Concurrency Intro|Concurrency Intro]]
- [[Systems Programming/Concurrency/Threads|Threads (pthreads)]]
- [[C++ Classes|C++ Classes]]
- [[RAII|RAII]]
- [[Concurrency And Locks|CSE332: Concurrency and Locks]]

## Industry Standard Terms

- **`std::thread`** — The C++11 standard thread class; wraps a platform thread (pthreads on Linux, Windows threads on Windows)
- **`std::lock_guard`** — RAII mutex wrapper; the idiomatic way to lock a mutex in C++; equivalent to Java's `synchronized` block or Python's `with threading.Lock():`
- **`std::atomic<T>`** — A type wrapper that ensures operations on the value are indivisible (atomic); uses CPU-level atomic instructions (e.g., `lock xadd`) rather than OS-level locks
- **`std::ref`** — A reference wrapper; tells `std::thread` to pass an argument by reference rather than by value (the default)
