# CSE451: Address Space with Threads

Each **[[Thread]]** has its own stack within the process's address space. The limitation of this is that we don't allow each stack to grow too large as it may conflict with other threads' stacks.

![[address space with threads.png]]

In a single-threaded process, the layout is straightforward:
- Code (text) at the bottom
- Data/heap growing upward
- Stack growing downward from the top

With multiple threads, the address space must accommodate multiple stacks:
- Each thread gets a fixed-size region for its stack
- These stacks are placed at different locations in the address space
- If a thread's stack overflows its allocated region, it can corrupt another thread's stack (stack overflow)
- The heap remains shared — any thread can allocate and free heap memory

Typical layout with threads:
```
+------------------+ high address
|  thread 1 stack  |  (main thread, grows downward)
+------------------+
|      guard       |  (unmapped page to catch overflow)
+------------------+
|  thread 2 stack  |  (grows downward)
+------------------+
|      guard       |
+------------------+
|  thread 3 stack  |
+------------------+
|       ...        |
+------------------+
|                  |
|       heap       |  (shared, grows upward)
|                  |
+------------------+
|    data (BSS)    |  (shared global/static vars)
+------------------+
|    data (init)   |  (shared initialized globals)
+------------------+
|    code (text)   |  (shared, read-only)
+------------------+ low address
```

**Guard pages** are unmapped memory regions placed between thread stacks. If a thread's stack grows into a guard page, the hardware triggers a page fault (segfault), catching the overflow before it silently corrupts another thread's stack.

The default stack size varies by OS (commonly 1-8 MB per thread), which limits how many threads a process can practically create. For example, with a 2 GB user address space and 8 MB stacks, you could fit roughly 250 threads before running out of address space for stacks alone. This fixed-size-region constraint is the practical consequence of the "cheap thread creation" claim made in **[[Achieving Multithreading]]** — creation is cheap in CPU time, but the address space itself is a finite resource that bounds the number of threads.

## Deep Dive

The choice of stack size is a tradeoff: a larger per-thread stack allows deeper recursion or larger local buffers before overflow, but wastes address space (and, if the page is actually touched, physical memory) per thread — directly limiting the maximum number of concurrent threads a single process can host. Some threading libraries let a programmer set a custom stack size at thread-creation time (e.g., `pthread_attr_setstacksize`) specifically to trade off this limit against per-thread memory needs. On 64-bit systems, the much larger virtual address space (as opposed to the 2 GB example in a 32-bit address space) makes this stack-count ceiling far less of a practical concern, since the constraint shifts from "address space exhaustion" to "physical memory exhaustion" if stacks are actually touched.

## Industry Standard Terms
- **Guard page** -> Stack guard page / redzone
- **Thread stack region** -> Thread stack (pthreads: configurable via `pthread_attr_setstacksize`)

## Related
- [[Systems Programming/Concurrency/Threads|CSE333: Threads]]
- [[Thread]]
- [[Achieving Multithreading]]
- [[Operating Systems/Virtualization/Memory/Concepts/Address Space Contents|Address Space Contents]]
