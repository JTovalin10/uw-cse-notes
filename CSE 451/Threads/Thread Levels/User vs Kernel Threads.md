# User vs Kernel Threads

|  | [[Kernel Threads]] | [[User Threads]] |
|---|---|---|
| **Scheduling** | 1:1 — one app thread per kernel thread | N:1 — many app threads per kernel thread |
| **Speed** | Slower (requires kernel trap) | Faster (entirely in user space) |
| **I/O Blocking** | Only the blocked thread stalls | All threads on that kernel thread stall |
| **OS Visibility** | Kernel sees every thread | Kernel only sees one thread |

- User-level threads are faster but they don't know about each other
- Kernel threads are heavier but give the OS full visibility for scheduling
- [[Scheduler Activations]] aim to combine the best of both
