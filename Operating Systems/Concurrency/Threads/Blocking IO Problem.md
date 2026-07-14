# CSE451: Blocking IO Problem

The blocking IO problem is the main drawback of **[[Thread Levels/User Threads|N:1 scheduling]]**.

## Why It Happens

In N:1 threading, many user-level threads share a single kernel thread. The kernel has no idea that multiple user-level threads exist — it only sees the one kernel thread. So when any user-level thread makes a blocking system call (like a disk read or network request), the kernel blocks the only kernel thread it knows about.

## The Consequence

When that kernel thread blocks, *all* user-level threads mapped to it are frozen — even if they have work ready to do.

- The user-level thread library can't schedule another thread because the kernel thread itself is stuck waiting for IO
- The kernel doesn't know there are other user-level threads ready to run
- The same problem applies to any blocking operation, not just IO (e.g., page faults)

## Concrete Walkthrough

Suppose threads A, B, and C all share one kernel thread:
1. Thread A issues a disk read -> the kernel thread blocks
2. Threads B and C are ready to run but can't — the kernel thread powering them is stuck
3. The entire application stalls until thread A's IO completes

![[Screenshot 2026-02-09 at 11.46.39 AM.png]]

## Solutions

- **[[Thread Levels/Kernel Threads|1:1 threading]]** — give each thread its own kernel thread, so one blocking doesn't affect the others (but this is slower)
- **[[Thread Levels/Scheduler Activations|Scheduler Activations]]** — let the kernel and user-level scheduler communicate so the kernel can spawn replacement threads when one blocks (best of both worlds)

## Deep Dive

This same fundamental tension — one blocked execution context stalling everything sharing it — recurs outside of threading proper. Purely event-driven / async I/O models (e.g., `epoll`-based servers, Node.js's event loop) sidestep the blocking IO problem entirely by never issuing a blocking syscall from the main execution context in the first place; instead, I/O readiness is polled or delivered via callback, and no thread is ever "stuck." This is effectively a software-only alternative to N:1 threading that avoids the blocking pitfall at the cost of more complex, callback-driven control flow, as alluded to in **[[The Big Picture]]**'s discussion of program structure.

## Industry Standard Terms
- **N:1 scheduling** -> Green threads / user-mode threading / M:1 threading model
- **Blocking system call** -> Synchronous / blocking I/O
- **Kernel thread blocking** -> Thread parked in the `Blocked`/`Waiting` state (see **[[Operating Systems/Virtualization/Processes/Process/Process State|Process State]]**)

## Related
- [[Thread Levels]]
- [[Thread Levels/User Threads|User Threads]]
- [[Thread Levels/Kernel Threads|Kernel Threads]]
- [[Thread Levels/Scheduler Activations|Scheduler Activations]]
- [[Thread Levels/User vs Kernel Threads|User vs Kernel Threads]]
