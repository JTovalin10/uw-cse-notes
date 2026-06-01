# How can we achieve multithreading
we need to have multiple hardware execution states:
- execution stack, stack pointer, program counter, registers, etc.

to achieve this:
- fork several processes
- cause each to map to the same physical memory to share data

but this is heavyweight. a better approach is to support multiple threads within a single process natively:
- the OS allocates a separate stack and register set for each thread
- all threads share the same page table (address space)
- the thread scheduler can switch between threads without changing address spaces

at the hardware level, each CPU core can only run one thread at a time. the OS uses context switching to multiplex threads onto available cores. on a multicore machine, threads can truly run in parallel on different cores.

key mechanisms:
- **thread creation**: allocate a new stack within the process's address space, initialize the program counter to the thread's start function, set up initial register values
- **thread scheduling**: the OS scheduler treats each thread as a schedulable entity, picking which thread runs on which core
- **context switching between threads**: save the current thread's registers/stack pointer, restore the next thread's registers/stack pointer. since threads share an address space, no page table switch is needed (unlike process context switches)
