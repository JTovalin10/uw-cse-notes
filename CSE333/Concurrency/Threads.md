# CSE 333: Threads

A **thread** is a sequential execution stream within a process. It is often called a "lightweight process".

## Threads vs. Processes
*   **Process**: A container that holds address space and OS resources (files, etc.).
*   **Thread**: The unit of scheduling. Every process has at least one thread.
*   **Shared State**: Threads within a process cohabitate the same address space. They share the same **heap**, **globals**, and **code segments**.
*   **Private State**: Each thread has its own **stack**, **stack pointer**, **program counter**, and **registers**.

## POSIX Threads (pthreads)
In C/C++, pthreads is the standard library for threading (`#include <pthread.h>`).

### Basic Functions
*   `pthread_create()`: Starts a new thread. Takes a function pointer (`void* (*start_routine)(void*)`) and one argument (`void* arg`).
*   `pthread_join()`: Waits for a specific thread to terminate (similar to `wait()` for processes).
*   `pthread_detach()`: Indicates that the thread's resources can be reclaimed immediately upon termination; the thread cannot be joined.

## Data Races
A **data race** occurs when two or more threads try to mutate the same data structure simultaneously. This can lead to:
*   Incorrect answers.
*   Broken data structures (e.g., corrupted linked lists).
*   Non-deterministic behavior that is difficult to debug.

## Synchronization
**Synchronization** is the act of preventing concurrent threads from interfering with each other when operating on shared data.

### Locks and Mutexes
A **mutex** ("mutual exclusion") is used to grant access to a **critical section** so that only one thread can operate there at a time.
*   **Lock Acquire**: Wait until the lock is free, then take it.
*   **Lock Release**: Release the lock. If other threads are waiting, one is woken up.

### pthread Mutex API
*   `pthread_mutex_init()`: Initializes a mutex.
*   `pthread_mutex_lock()`: Blocks until the lock is acquired.
*   `pthread_mutex_unlock()`: Releases the lock.

### C++11 Threads
C++11 introduced standard library support for threads (`<thread>`), mutexes (`<mutex>`), and atomics (`<atomic>`). While these are often built on top of pthreads, they provide a more idiomatic C++ interface.

# Related
- [[CSE451/Threads/Thread|CSE451: Thread]]
- [[CSE451/Threads/Threads and Processes|CSE451: Threads and Processes]]
- [[CSE332/Parallelism/Concurrency And Locks|CSE332: Concurrency and Locks]]
