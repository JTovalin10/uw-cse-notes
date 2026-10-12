# Stack Management and Channels: Context Switching and Assembly Trampoline

## 2. Context Switching & Assembly Trampoline

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

### Scheduler C Interface

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

### Low-Level x86-64 Context Switch Implementation

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

### Callee-Saved vs. Caller-Saved Registers

![[Images/x86-64 calling convention.png]]

- **Callee-Saved Registers (`%r12`, `%r13`, `%r14`, `%r15`, `%rbx`, `%rbp`)**: The System V AMD64 ABI mandates that a function must preserve these register values across function calls. Because `context_switch` is an explicit function call, it must manually push and pop these 6 registers to preserve caller state across stack switches.
- **Caller-Saved Registers (`%rax`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`–`%r11`)**: Scratch registers saved by the C compiler onto the local stack frame *before* calling `context_switch` if their contents are required after the call.
- **Instruction Pointer (`%rip`) Management**: `%rip` is never pushed manually. When C executes `call context_switch`, the CPU automatically pushes the 8-byte return address onto the current stack. When `context_switch` restores `%rsp` to the new stack and executes `ret`, it pops that stack's saved return address into `%rip`, executing a seamless control transition.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Coroutine** | Green Thread / Fiber / User-Level Thread |
| **`yield()`** | Cooperative Context Switch / Relinquish |

## Related

- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Coroutine Stack Frames and Memory Layout|Coroutine Stack Frames and Memory Layout]] — x86-64 layout and control block
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Unbuffered Channel Rendezvous Trace|Unbuffered Channel Rendezvous Trace]] — Trace of a rendezvous
