# Scheduler Activations

The core idea is to let the kernel and user-level scheduler communicate with each other to avoid the [[Blocking IO Problem]].

## Two-Way Communication

- The OS and user-level scheduler exchange hints
- The user-level scheduler tells the kernel what it needs (it may or may not get those resources)
- The kernel notifies the user-level scheduler of events via an **upcall**:
	- More or fewer CPUs available to the process
	- A thread blocked on I/O, or unblocked when I/O finishes

## What Is a Scheduler Activation?

A scheduler activation replaces a kernel thread. Like a kernel thread, it has its own stack, processor context, and can be scheduled on a CPU. The key difference: if the kernel interrupts an activation, it does not restart it where it left off. Instead, it restarts execution in the user-level scheduler, which then decides which thread to run on that CPU.

## How It Works

When a user-level thread blocks, the kernel spawns additional kernel threads to service the remaining user threads. When the blocked thread finishes, the kernel performs an upcall and the user-level scheduler reschedules threads across the available kernel threads.

## Performance

- When threads aren't blocking on I/O, it's just user-level thread management — an order of magnitude faster than [[Kernel Threads|kernel-level threads]]
- Solves the [[Blocking IO Problem]]
