# CSE451: Kernel Threads

**Kernel threads** are more efficient than processes but still not cheap.

- The OS manages both threads and processes/address spaces
- All thread operations are implemented in the kernel
- The OS schedules all threads in a system, similar to how it schedules processes
- Kernel threads are cheaper to create than processes, since they don't require allocating a new address space (see **[[Achieving Multithreading]]**)

## Context Switching

Trap into kernel -> save running thread's processor context in the Thread Control Block (TCB) -> pick a new thread to run -> load new thread's registers.

## 1:1 Scheduling

Each application thread maps to exactly one kernel thread. When an app creates 5 threads, the kernel sees and schedules all 5 independently. This is what most modern OSes use (Linux, Windows, macOS).

- **Pros**: the kernel knows about every thread, so if one blocks on I/O the others keep running — this is precisely how 1:1 scheduling avoids the **[[Blocking IO Problem]]** that N:1 scheduling suffers from
- **Cons**: every thread creation/context switch requires a kernel trap, which is slower than the equivalent operation under **[[User Threads]]**

![[Screenshot 2026-02-09 at 11.37.22 AM.png]]

## Industry Standard Terms
- **Kernel thread** -> Native OS thread (Linux: schedulable entity created by `clone()`; Windows: kernel thread object)
- **1:1 scheduling** -> Native threading model / "one-to-one" threading

## Related
- [[Thread Levels]]
- [[User Threads]]
- [[User vs Kernel Threads]]
- [[Blocking IO Problem]]
- [[Scheduler Activations]]
