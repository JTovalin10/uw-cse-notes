# Disabling Interrupts
a mechanism to achieve mutual exclusion by preventing the CPU from responding to interrupts

## How it Works
```c
void acquire() {
    disable_interrupts();  // CLI instruction on x86
}

void release() {
    enable_interrupts();   // STI instruction on x86
}
```

## Why It Works
- without interrupts, no context switch can occur
- the thread cannot be preempted
- guarantees atomicity of the critical section

## Problems
### Only Available to Kernel
- user-level code cannot disable interrupts
- would be a security/stability risk to allow

### Insufficient on Multiprocessors
- each processor has its own interrupt mechanism
- disabling interrupts on one CPU doesn't affect others
- other CPUs can still access shared data

### Device Issues
- long periods with interrupts disabled can cause problems
- missed interrupts
- device timeouts
- system unresponsiveness

### Risk of Forgetting to Re-enable
- if code forgets to re-enable interrupts, system hangs
- exceptions/errors in critical section can leave interrupts disabled

## When to Use
- very short critical sections in kernel
- when other mechanisms would be too expensive
- interrupt handlers (already running with some interrupts disabled)
- boot code and early initialization

## x86 Instructions
- [[CLI]] - Clear Interrupt Flag (disable interrupts)
- [[STI]] - Set Interrupt Flag (enable interrupts)
- Only executable in kernel mode (Ring 0)

## Better Alternatives
- use [[Spinlock]] with atomic instructions on multiprocessors
- use [[Semaphores]] for longer critical sections
- combine: disable interrupts + spinlock for multiprocessor kernel code

## Related
- [[Critical Sections]]
- [[Spinlock]]
- [[IF]]
