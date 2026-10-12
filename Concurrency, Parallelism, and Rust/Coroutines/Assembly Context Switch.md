# Coroutines: Assembly Context Switch

## Low-Level Assembly Context Switch: `routine_switch.S`

The low-level context switch is implemented in assembly because standard C compilers do not provide primitives to directly overwrite the CPU stack pointer (`%rsp`) or manipulate the instruction pointer (`%rip`).

### C Signature & x86-64 System V AMD64 ABI
```c
void routine_switch(Routine* next);
```

Under the x86-64 System V AMD64 ABI:
- The argument `next` is passed in register `%rdi`.
- The `call routine_switch` instruction pushes the 8-byte return address (the next instruction in the calling function) onto the active stack and decrements `%rsp` by 8.
- **Callee-Saved Registers**: The ABI mandates that `%rbx`, `%rbp`, `%r12`, `%r13`, `%r14`, and `%r15` must be preserved across function calls. Any function modifying these registers must save them on the stack and restore them prior to returning.
- **Caller-Saved Registers**: Registers `%rax`, `%rcx`, `%rdx`, `%rsi`, `%r8`–`%r11` are scratch registers. Whoever called `routine_switch` was responsible for spilling them to the stack if their values were needed across the call.

### Assembly Implementation (`routine_switch.S`)
```assembly
.global routine_switch
.text

// void routine_switch(Routine* next);
routine_switch:
    // 1. Save callee-saved registers on current routine's stack.
    // Whoever called routine_switch was responsible for saving caller-saved registers.
    push %r12
    push %r13
    push %r14
    push %r15
    push %rbx   // Callee-saved: holds caller's local variables surviving across switch.
    push %rbp   // Callee-saved: base frame pointer anchoring caller's stack frame.

    // 2. Save current stack pointer to offset 0 of the global current_routine.
    mov current_routine(%rip), %rsi // Caller-saved scratch: safe because routine_switch has 1 argument (%rdi).
    mov %rsp, (%rsi)                // Write %rsp into current_routine->saved_stack_pointer.

    // 3. Set CPU stack pointer to the saved stack pointer in `next`.
    mov (%rdi), %rsp                // Read next->saved_stack_pointer (offset 0) into %rsp.

    // 4. Update global current_routine to point to `next`.
    mov %rdi, current_routine(%rip)

    // 5. Restore callee-saved registers from target routine's stack in LIFO order.
    pop %rbp    // Restores next routine's frame pointer.
    pop %rbx    // Restores next routine's local variables.
    pop %r15
    pop %r14
    pop %r13
    pop %r12

    // 6. Return into target routine context.
    ret         // Pops saved %rip off newly activated stack and jumps to it.
```

### Equivalent C Mental Model
```c
// Conceptual C equivalent of routine_switch.S
void routine_switch(Routine* next) {
    // 1. Push callee-saved registers to active routine's stack:
    //    stack_push(%r12, %r13, %r14, %r15, %rbx, %rbp);

    // 2. Save updated stack pointer into current routine control block (offset 0)
    current_routine->saved_stack_pointer = rsp;

    // 3. Pivot CPU execution to target routine's stack
    rsp = next->saved_stack_pointer;

    // 4. Update global tracking pointer
    current_routine = next;

    // 5. Restore callee-saved registers from the new stack:
    //    stack_pop(%rbp, %rbx, %r15, %r14, %r13, %r12);

    // 6. Resume execution in target routine
    //    'ret' instruction pops target return address into %rip
}
```

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **`routine_switch.S`** | Context Switch Trampoline / Stack Swap Stub / Register Swap |

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Coroutine Memory Layout and Control Block|Coroutine Memory Layout and Control Block]] — Private stacks, struct Routine, and the core API
- [[Concurrency, Parallelism, and Rust/Coroutines/Channels and Rendezvous Semantics|Channels and Rendezvous Semantics]] — CSP channels, causal consistency, and unbuffered rendezvous
