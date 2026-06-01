# CSE333: Threads (pthreads)

A **thread** is a sequential execution stream within a process. It is often called a "lightweight process" because it shares the process's address space rather than having its own.

## Threads vs. Processes

| Property | Process | Thread |
| :--- | :--- | :--- |
| **Description** | Container holding address space and OS resources | The unit of scheduling; every process has at least one |
| **Address Space** | Private and isolated | Shared with all threads in the same process |
| **Heap / Globals** | Private | Shared |
| **Stack** | Private | Each thread has its own private stack |
| **Program Counter** | N/A | Each thread has its own |
| **Registers** | N/A | Each thread has its own saved register state |

Shared state is convenient for communication but requires synchronization to prevent data races.

## POSIX Threads (pthreads)

In C/C++, pthreads is the standard library for threading (`#include <pthread.h>`).

### Basic Functions

- **`pthread_create()`**: Starts a new thread. Takes a function pointer (`void* (*start_routine)(void*)`) and one `void*` argument.
- **`pthread_join()`**: Waits for a specific thread to terminate and reclaims its resources (analogous to `wait()` for processes).
- **`pthread_detach()`**: Marks a thread so its resources are reclaimed immediately upon termination. A detached thread **cannot** be joined.

```c
#include <pthread.h>
#include <stdio.h>

void* worker(void* arg) {
    int id = *(int*)arg;
    printf("Thread %d running\n", id);
    return NULL;
}

int main() {
    pthread_t t;
    int id = 1;
    pthread_create(&t, NULL, worker, &id);
    pthread_join(t, NULL); // Wait for thread to finish
    return 0;
}
```

## Data Races

A **data race** occurs when two or more threads concurrently access the same memory location and at least one access is a write, without any synchronization. Data races can cause:

- Incorrect answers due to interleaved reads and writes.
- Corrupted data structures (e.g., a corrupted linked list).
- Non-deterministic behavior that is very difficult to debug.

## Synchronization

**Synchronization** prevents concurrent threads from interfering with each other when operating on shared data.

### Locks and Mutexes

A **mutex** ("mutual exclusion") guards a **critical section** so that only one thread executes it at a time.

- **Lock Acquire**: Wait until the mutex is unlocked, then atomically claim it.
- **Lock Release**: Release the mutex. If other threads are waiting, one is woken up.

### pthread Mutex API

```c
pthread_mutex_t mtx;
pthread_mutex_init(&mtx, NULL);
pthread_mutex_lock(&mtx);
// --- critical section ---
pthread_mutex_unlock(&mtx);
pthread_mutex_destroy(&mtx);
```

### C++11 Threads

C++11 introduced standard library support for threads (`<thread>`), mutexes (`<mutex>`), and atomics (`<atomic>`). For details on modern C++ concurrency with RAII-managed locks, see [[C++ Concurrency|C++ Concurrency]].

## Related

- [[C++ Concurrency|C++ Concurrency]]
- [[Concurrency Intro|Concurrency Intro]]
- [[Thread|CSE451: Thread]]
- [[Threads and Processes|CSE451: Threads and Processes]]
- [[Concurrency And Locks|CSE332: Concurrency and Locks]]

## Industry Standard Terms

- **POSIX Threads (pthreads)** — The standard C threading API on Unix-like systems; superseded in C++ by `std::thread` but still widely used in C codebases
- **Mutex** — "Mutual exclusion lock"; the fundamental synchronization primitive; equivalent to `synchronized` blocks in Java or `threading.Lock` in Python
- **Critical section** — A region of code that must be executed by only one thread at a time to prevent data races
- **Data race** — Concurrent unsynchronized access to shared mutable state; undefined behavior in C and C++; detected by ThreadSanitizer (`-fsanitize=thread`)
