# Thread Levels

- **Kernel threads** are managed by the kernel for scheduling on a CPU
- **User threads** are managed by the user for scheduling on a kernel thread

Threads support concurrency and parallelism within an application. They are more lightweight than processes, making them much faster to create and switch between.

## What if a thread tries to do I/O
I/O operations are blocking

the kernel thread "powering" it is lost for the duration of the operation
- the kernel thread blocks in the OS, as always
- cant run a different user-level thread
the main issue is that kernel doesn't know there are user threads and doesn't know there's something else it could run
## Topics

- [[Kernel Threads]] — OS-managed threads using 1:1 scheduling
- [[User Threads]] — user-space threads using N:1 scheduling
- [[Blocking IO Problem]] — the main drawback of N:1 threading
- [[Scheduler Activations]] — letting the kernel and user scheduler communicate to solve blocking
- [[User vs Kernel Threads]] — comparison of both approaches
