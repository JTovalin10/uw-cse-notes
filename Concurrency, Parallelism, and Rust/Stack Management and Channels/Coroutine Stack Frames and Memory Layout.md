# Stack Management and Channels: Coroutine Stack Frames and Memory Layout

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

## Related

- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Naive Approaches and Motivation|Naive Approaches and Motivation]] — Why coroutines need managed stacks
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Context Switching and Assembly Trampoline|Context Switching and Assembly Trampoline]] — Scheduler interface, register saving, and the switch
