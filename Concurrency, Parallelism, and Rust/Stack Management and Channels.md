# Concurrency, Parallelism, and Rust: Stack Management and Channels

User-space coroutines require dedicated execution stacks, low-level CPU context switching, and structured communication primitives to coordinate concurrent execution without OS kernel intervention or shared mutable state hazards.

---

## Motivation & Overview

Cooperative concurrency models rely on two foundational abstractions to execute and coordinate concurrent tasks safely:
1. **Private Execution Stacks**: Because a coroutine can suspend midway through function calls, it cannot share the primary execution stack of `main()`. Each coroutine requires an independent stack to preserve local variables, call frames, and CPU register state across context switches.
2. **Channel-Based Synchronization**: To exchange data without shared-memory data races, coroutines pass messages through FIFO queue primitives (**Channels**), enforcing strict causal dependencies between concurrent producers and consumers.

### Naive Approaches & Limitations

- **Shared Stack Execution**: Attempting to execute coroutines on a single shared process stack fails because suspending a function deep in a call tree leaves active stack frames that would be overwritten if another coroutine began executing on the same stack.
- **Unprotected Memory Overflows**: Allocating fixed-size stack buffers on the heap (e.g., via `malloc()`) risks silent stack overflows. If a coroutine's call stack exceeds its allocated memory boundary, it corrupts adjacent heap data or neighboring coroutine stacks, triggering delayed crashes in unrelated routines.
- **Unsynchronized Shared Memory**: Exchanging data between concurrent tasks via shared mutable variables requires heavy locks or atomic operations, reintroducing race conditions and deadlock risks that cooperative user-space runtimes aim to avoid.

---

## Architecture & Core Mechanics

The user-space runtime manages coroutine execution contexts through private stack buffers, an assembly context-switch trampoline, and channel message queues.

### 1. Coroutine Stack Frames & x86-64 Memory Layout

On x86-64 architectures, execution stacks grow downward from higher memory addresses to lower memory addresses. The stack pointer register (`%rsp`) tracks the current top of the stack (the lowest active memory address).

![[Images/recap of x64-64 stack frame.png]]

- **`push %src`**: Decrements `%rsp` by 8 bytes and writes the value of `%src` to memory at address `(%rsp)`.
- **`pop %dst`**: Reads the 8-byte value from memory at address `(%rsp)` into `%dst` and increments `%rsp` by 8 bytes.
- **`call target`**: Pushes the 8-byte return address (the address of the instruction immediately following `call`) onto the stack and jumps to `target`.
- **`ret`**: Pops the 8-byte return address off the stack into the instruction pointer (`%rip`) and resumes execution.

#### Stack Allocation & Control Block Architecture

Every coroutine is represented by a control structure (`struct Coroutine`) paired with a heap-allocated stack buffer:

![[Images/coroutine stacks from malloc.png]]

```c
struct Coroutine {
    uint64_t rsp;          // Saved stack pointer (%rsp) while suspended (MUST be at offset 0)
    uint8_t* stack;        // Base pointer to heap-allocated stack buffer (from malloc/mmap)
    void (*fn)(void*);     // Function entry point pointer
    void* arg;             // Single parameter passed to entry function
    
    // Waiter queue pointers for join handles and channel blocking
};
```

---

### 2. Context Switching & Assembly Trampoline

Context switching between coroutines is performed entirely in user space via `yield()`, `block_on()`, and an assembly helper `context_switch`.

```mermaid
flowchart TD
    subgraph CoroutineA ["Coroutine A (Active)"]
        A1["Execution Loop"] -->|yield()| A2["Enqueue to ready_queue"]
        A2 --> A3["Call run_next()"]
        A3 --> A4["Call context_switch(&next->rsp, &prev->rsp)"]
    end

    subgraph AssemblySwitch ["Assembly Trampoline (context_switch)"]
        S1["Push 6 Callee-Saved Regs to Stack A"]
        S2["Save %rsp -> prev->rsp"]
        S3["Load next->rsp -> %rsp (Switch Stack Pointer)"]
        S4["Pop 6 Callee-Saved Regs from Stack B"]
        S5["ret (Pops Saved %rip)"]
    end

    subgraph CoroutineB ["Coroutine B (Resumed)"]
        B1["Resume Execution after ret"]
    end

    A4 --> S1
    S2 --> S3
    S3 --> S4
    S5 --> B1
```

#### Scheduler C Interface

```c
static inline void run_next(void) {
    // Save reference to active coroutine
    Coroutine* prev = current;
    
    // Dequeue next runnable coroutine from the ready queue
    current = queue_pop(&ready_queue);
    
    // If no routines are runnable, the runtime has deadlocked
    if (!current) {
        fputs("deadlock: nothing is ready\n", stderr);
        exit(1);
    }
    
    // Perform assembly context switch: save prev state, load current state
    context_switch(&current->rsp, &prev->rsp);
}

// Voluntary yield relinquishes CPU to next ready coroutine
static inline void yield(void) {
    queue_push(&ready_queue, current);
    run_next();
}

// Blocking puts the current coroutine on a specific waiter queue (e.g. channel)
static inline void block_on(CoroutineQueue *waiters) {
    queue_push(waiters, current);
    run_next();
}
```

#### Low-Level x86-64 Context Switch Implementation

```assembly
// void context_switch(uint64_t* next_rsp [%rdi], uint64_t* prev_rsp [%rsi])
.global context_switch
context_switch:
    // 1. Save callee-saved registers on current coroutine stack
    push %r12
    push %r13
    push %r14
    push %r15
    push %rbx
    push %rbp
    
    // 2. Save current stack pointer into prev->rsp (passed in %rsi)
    mov %rsp, (%rsi)
    
    // 3. Load target stack pointer from next->rsp (passed in %rdi) into %rsp
    mov (%rdi), %rsp
    
    // 4. Restore callee-saved registers from target coroutine stack (LIFO order)
    pop %rbp
    pop %rbx
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    
    // 5. Return into target coroutine (pops saved return address into %rip)
    ret
```

#### Callee-Saved vs. Caller-Saved Registers

![[Images/x86-64 calling convention.png]]

- **Callee-Saved Registers (`%r12`, `%r13`, `%r14`, `%r15`, `%rbx`, `%rbp`)**: The System V AMD64 ABI mandates that a function must preserve these register values across function calls. Because `context_switch` is an explicit function call, it must manually push and pop these 6 registers to preserve caller state across stack switches.
- **Caller-Saved Registers (`%rax`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`–`%r11`)**: Scratch registers saved by the C compiler onto the local stack frame *before* calling `context_switch` if their contents are required after the call.
- **Instruction Pointer (`%rip`) Management**: `%rip` is never pushed manually. When C executes `call context_switch`, the CPU automatically pushes the 8-byte return address onto the current stack. When `context_switch` restores `%rsp` to the new stack and executes `ret`, it pops that stack's saved return address into `%rip`, executing a seamless control transition.

---

## Concrete Walkthrough & Execution Trace

### Unbuffered Channel Rendezvous Trace

Consider two coroutines: **Producer (Routine 1)** sending value `42` and **Consumer (Routine 2)** receiving on unbuffered Channel `C`.

```
Initial State (t = 0):
  ready_queue = [Routine 1 (Active), Routine 2]
  Channel C: buffer = [], send_waiters = [], recv_waiters = []

Trace:
  1. Routine 1 calls send(C, 42):
     - Channel C is unbuffered (k = 0). No receiver is currently waiting on recv_waiters.
     - Routine 1 places payload 42 into Channel C rendezvous slot.
     - Routine 1 enqueues itself to C.send_waiters and calls block_on().
     - run_next() pops Routine 2 from ready_queue and executes context_switch.

  2. Routine 2 runs (Active):
     - Routine 2 calls recv(C).
     - Routine 2 inspects C.send_waiters and dequeues Routine 1.
     - Routine 2 extracts payload 42 from Channel C rendezvous slot.
     - Routine 2 unblocks Routine 1 by moving Routine 1 to ready_queue.
     - Routine 2 returns 42 to caller.

  3. Routine 2 calls yield():
     - Routine 2 enqueues to ready_queue.
     - run_next() pops Routine 1 and switches context back to Routine 1.
     - Routine 1 returns cleanly from send(C, 42).

Final State:
  Value 42 successfully transferred. Both routines active and ready.
```

---

## Edge Cases, Failure Modes & Mitigations

### 1. Stack Overflow Corruption
- **Failure Mode**: A coroutine performs deep recursion or allocates large local arrays, pushing `%rsp` past the bottom boundary of its heap-allocated stack buffer into adjacent coroutine memory.
- **Consequence**: Data on neighboring stacks is corrupted. When the victim coroutine pops registers or executes `ret`, it jumps to invalid memory or crashes with a segmentation fault, falsely attributing blame to the victim.
- **Mitigation Strategies**:
  - **OS Guard Pages (`mmap` + `mprotect`)**: Allocate stacks using `mmap()` with an extra page marked `PROT_NONE` via `mprotect()`. Any stack write touching the guard page immediately triggers a hardware page fault (`SIGSEGV`), terminating execution cleanly before data corruption occurs.
  - **Generous Allocation**: Allocate large static stack bounds (e.g., 32KB/64KB) when guard pages are not supported.

### 2. Deadlock Detection
- **Failure Mode**: All coroutines enter a blocked state waiting on empty channels or join handles, leaving `ready_queue` completely empty.
- **Mitigation**: `run_next()` checks if `current` is `NULL` after popping `ready_queue`. If empty, it emits a `"deadlock: nothing is ready"` error to `stderr` and terminates execution cleanly rather than looping infinitely.

---

## Formal Analysis / Protocol Specification

### Formal Definition

Let $q$ be the channel queue buffer, $k$ be maximum capacity, $W_s$ be the set of blocked senders, and $W_r$ be the set of blocked receivers.

$$\forall t, \quad |q(t)| \le k$$

$$\text{If } |q(t)| = k \implies \text{send}(v) \implies \text{Block}(W_s)$$

$$\text{If } |q(t)| = 0 \implies \text{recv}() \implies \text{Block}(W_r)$$

$$\text{Unbuffered Rendezvous } (k = 0): \quad W_s \cap W_r = \emptyset, \quad \text{Transfer occurs when } |W_s| > 0 \land |W_r| > 0$$

### Simplified Explanation

A buffered channel acts as a safe pipe with $k$ storage slots. If full, senders wait outside; if empty, receivers wait outside. An unbuffered channel has zero slots, forcing the sender and receiver to shake hands in real time to transfer data.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Coroutine** | Green Thread / Fiber / User-Level Thread |
| **`yield()`** | Cooperative Context Switch / Relinquish |
| **Unbuffered Channel** | Synchronous Channel / Zero-Capacity Rendezvous Channel |
| **Buffered Channel** | Asynchronous Bounded Channel / Circular Queue Channel |
| **Guard Page** | Redzone Page / Stack Guard Page (`PROT_NONE`) |

---

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Primary navigation hub covering user-space coroutines, state machines, and assembly switching
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Foundations of task vs data parallelism, hardware microarchitecture, and dataflow DAGs
- [[Operating Systems/Concurrency/Threads/Thread Levels/User vs Kernel Threads|User vs Kernel Threads]] — Comparison between 1:1 OS kernel thread scheduling and M:N / 1:N user-space coroutines
- [[Systems Programming/Memory Management/Stack|Stack Memory Management]] — Deep dive into virtual address space, x86-64 stack alignment, and calling conventions