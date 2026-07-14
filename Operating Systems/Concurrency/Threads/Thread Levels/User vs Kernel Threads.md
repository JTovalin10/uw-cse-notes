# CSE451: User vs Kernel Threads

|  | [[Kernel Threads]] | [[User Threads]] |
|---|---|---|
| **Scheduling** | 1:1 — one app thread per kernel thread | N:1 — many app threads per kernel thread |
| **Speed** | Slower (requires kernel trap) | Faster (entirely in user space) |
| **I/O Blocking** | Only the blocked thread stalls | All threads on that kernel thread stall |
| **OS Visibility** | Kernel sees every thread | Kernel only sees one thread |

- User-level threads are faster but they don't know about each other, so the kernel can't help schedule around a blocked one — this is exactly the **[[Blocking IO Problem]]**
- Kernel threads are heavier but give the OS full visibility for scheduling
- **[[Scheduler Activations]]** aim to combine the best of both by having the kernel and user-level scheduler communicate directly

## Formal Definition

Let $N$ be the number of user-level threads and $K$ be the number of kernel threads backing them:
- **1:1 scheduling (Kernel Threads)**: $N = K$, each user thread has a dedicated kernel thread.
- **N:1 scheduling (User Threads)**: $K = 1$, all $N$ user threads multiplex onto a single kernel thread.
- **M:N scheduling (Scheduler Activations)**: $1 < K < N$, $M$ user threads multiplex onto $K$ kernel threads, with the kernel and user scheduler cooperating to adjust $K$ dynamically as threads block/unblock.

### Simplified Explanation

1:1 gives every worker their own phone line to the kernel — reliable, but expensive to set up each line. N:1 gives all workers one shared phone line — cheap, but if one worker ties it up, nobody else can call out. Scheduler activations are a compromise: a small pool of shared lines, and the kernel taps a worker on the shoulder to say "your line just got blocked, hand out a new one."

## Industry Standard Terms
- **1:1 scheduling** -> Native/kernel threading model
- **N:1 scheduling** -> Green threading model
- **M:N scheduling** -> Hybrid threading model (e.g., early Go runtime, Windows Fibers/UMS)

## Related
- [[Thread Levels]]
- [[Kernel Threads]]
- [[User Threads]]
- [[Scheduler Activations]]
- [[Blocking IO Problem]]
