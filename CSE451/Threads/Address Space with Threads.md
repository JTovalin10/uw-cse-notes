# Address space with threads
each thread has its own stack within the process's address space. the limitation of this is that we don't allow each stack to grow too large as it may conflict with other threads' stacks.

![[address space with threads.png]]

in a single-threaded process, the layout is straightforward:
- code (text) at the bottom
- data/heap growing upward
- stack growing downward from the top

with multiple threads, the address space must accommodate multiple stacks:
- each thread gets a fixed-size region for its stack
- these stacks are placed at different locations in the address space
- if a thread's stack overflows its allocated region, it can corrupt another thread's stack (stack overflow)
- the heap remains shared - any thread can allocate and free heap memory

typical layout with threads:
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

guard pages are unmapped memory regions placed between thread stacks. if a thread's stack grows into a guard page, the hardware triggers a page fault (segfault), catching the overflow before it silently corrupts another thread's stack.

the default stack size varies by OS (commonly 1-8 MB per thread), which limits how many threads a process can practically create. for example, with a 2 GB user address space and 8 MB stacks, you could fit roughly 250 threads before running out of address space for stacks alone.
