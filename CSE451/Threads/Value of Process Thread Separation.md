# Value of process/thread separation
concurrency allows us to handle concurrent events, build parallel programs, and improve program structure.

multithreading is useful even on a uniprocessor (single core machine). it allows us to decompose a problem into concurrent pieces in our mind, making the program structure cleaner and easier to reason about, even if only one thread runs at a time.

examples where multithreading helps on a single core:
- **web server**: one thread per client request. while one thread is blocked waiting on disk I/O, another thread can handle a different request. without threads, the server would either block entirely or require complex event-driven (async) code.
- **GUI applications**: one thread handles the UI (repainting, responding to clicks), another thread does background computation. without threads, a long computation freezes the entire interface.
- **producers and consumers**: one thread produces data, another consumes it. the producer/consumer pattern maps naturally onto threads with a shared buffer.

supporting multithreading - separating the concept of a process from that of a minimal thread of control - is a big win:
- **concurrency**: overlap I/O with computation, handle multiple events simultaneously
- **parallelism**: on multicore machines, threads can run truly in parallel for speedup
- **program structure**: express logically concurrent activities as separate threads rather than tangling them into a single event loop
- **resource sharing**: threads within a process share memory, making data sharing trivial (at the cost of needing synchronization)

process = address space + resources + threads

a process without threads is just a lifeless container. threads are what bring execution to a process. the separation of "what is shared" (process) from "what executes" (thread) is one of the most important abstractions in operating system design.
