# Threads and Cores: Preemption and Time Quanta

## Preemption, Hardware Timers, and Time Quanta
When multiple threads share fewer physical cores ($M > N$), the OS kernel enforces sharing via **preemptive multitasking**:
- **Hardware Timer Interrupt**: A physical timer on the CPU generates periodic hardware interrupts.
- **Time Quantum (Slice)**: The fixed duration of CPU execution granted to a thread between timer interrupts.
- **Preemption Step**: Upon timer interrupt, the CPU hardware traps into the kernel (Ring 3 to Ring 0). The OS saves the active thread's registers to its Thread Control Block (TCB), selects the next ready thread from the run queue, restores its saved registers, and switches execution contexts.

```mermaid
sequenceDiagram
    autonumber
    participant T1 as Thread 1 (User Space)
    participant HW as CPU Hardware Timer
    participant Kernel as OS Scheduler (Kernel)
    participant T2 as Thread 2 (User Space)

    T1->>T1: Executing User Instructions
    HW->>Kernel: Hardware Timer Interrupt (Quantum Expired)
    Note over T1,Kernel: Privilege Boundary Transition (Ring 3 -> Ring 0)
    Kernel->>Kernel: Save T1 State (RIP, RSP, Registers) to T1 TCB
    Kernel->>Kernel: Select T2 from Ready Queue
    Kernel->>T2: Restore T2 State (RIP, RSP, Registers) from T2 TCB
    Note over Kernel,T2: Return from Interrupt (Ring 0 -> Ring 3)
    T2->>T2: Resume User Instructions
```

### Preemption Frequency Trade-offs
- **High Preemption Frequency (Short Quanta)**:
  - *Advantage*: Low latency and high responsiveness; ready threads run almost immediately.
  - *Disadvantage*: High CPU overhead due to frequent context switches and cache thrashing.
- **Low Preemption Frequency (Long Quanta)**:
  - *Advantage*: High overall system throughput; minimal CPU time spent in kernel context switches.
  - *Disadvantage*: Higher scheduling latency; interactive threads experience perceptible delays.

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Thread Memory Layout and Abstraction|Thread Memory Layout and Abstraction]] — Shared vs private state and the thread lifecycle
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Programmer View vs Processor View|Programmer View vs Processor View]] — Interleaving traces
