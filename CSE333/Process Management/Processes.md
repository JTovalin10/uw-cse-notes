# CSE 333: Processes

An alternative to using [[Threads]] for concurrency is forking **processes**.

## Creating New Processes: fork()
The `fork()` system call creates a new process (the **child**) that is an exact clone of the current process (the **parent**).
*   **Cloned**: Variables, file descriptors, open sockets, and the entire virtual address space (code, globals, heap, stack).
*   **Not Cloned**: Threads (only the thread that called `fork()` exists in the child).

### fork() Semantics
`fork()` is peculiar because it is called once but returns twice:
*   In the **parent**: Returns the Process ID (PID) of the child.
*   In the **child**: Returns `0`.
*   On error: Returns `-1` in the parent (no child created).

## Process Management
*   **Zombies**: When a child process terminates, it becomes a "zombie" until its parent reaps it.
*   **wait()**: The parent calls `wait()` (or `waitpid()`) to block until a child exits and retrieve its exit status. Reaping children prevents resource leaks.

### The Double-Fork Trick
If a parent doesn't want to `wait()` for a child, it can use the double-fork trick:
1.  Parent forks child.
2.  Child forks grandchild and then immediately exits.
3.  Grandchild is orphaned and adopted by `init` (PID 1), which reaps it automatically.
4.  Parent reaps the short-lived child immediately.

## Processes vs. Threads for Servers
| Feature | Processes | Threads |
| :--- | :--- | :--- |
| **Creation** | Slow (~0.25 ms/fork) | Fast (~0.036 ms/thread) |
| **Address Space** | Private (Isolated) | Shared |
| **Communication** | Complex (IPC, Pipes, Files) | Easy (Shared Memory) |
| **Fate** | Independent | Shared (Rogue thread can crash process) |
| **Overhead** | High (Context switching) | Low |

## Thread Pools
In high-performance servers, creating a new thread or process for every request is still too expensive. A **thread pool** creates a fixed set of worker threads at startup. Requests are placed in a queue, and workers take tasks from the queue as they become available.

# Related
- [[CSE333/Concurrency/Threads|CSE333: Threads]]
- [[CSE451/Processes/Process|CSE451: Process]]
