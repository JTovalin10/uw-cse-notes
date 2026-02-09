# Kernel Threads

Kernel threads are more efficient than processes but still not cheap.

- The OS manages both threads and processes/address spaces
- All thread operations are implemented in the kernel
- The OS schedules all threads in a system, similar to how it schedules processes
- Kernel threads are cheaper to create than processes

## Context Switching

Trap into kernel → save running thread's processor context in TCB → pick a new thread to run → load new thread's registers

## 1:1 Scheduling

Each application thread maps to exactly one kernel thread. When an app creates 5 threads, the kernel sees and schedules all 5 independently. This is what most modern OSes use (Linux, Windows, macOS).

- **Pros:** the kernel knows about every thread, so if one blocks on I/O the others keep running
- **Cons:** every thread creation/context switch requires a kernel trap, which is slower

![[Screenshot 2026-02-09 at 11.37.22 AM.png]]
