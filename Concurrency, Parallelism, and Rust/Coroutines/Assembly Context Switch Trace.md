# Coroutines: Assembly Context Switch Trace

## Walkthrough 3: Step-by-Step Assembly Context Switch Trace (`routine_switch.S`)

The following sequence details how CPU registers and stack pointers shift when switching execution from `Routine 1` (currently executing) to `Routine 2` (suspended on the heap).

### Step 1: Initial State Before Switch
`Routine 1` is actively executing instructions. `Routine 2` is suspended with its saved stack pointer at address `0xC0`. On `Routine 2`'s private stack, a saved return address resides at `0xC0`.

![[routine_switch 1.png]]

### Step 2: The `call routine_switch(next)` Instruction
`Routine 1` calls `routine_switch(Routine 2)`. The hardware `call` instruction pushes the 8-byte return address (inside `yield()`) onto `Routine 1`'s stack at address `0xB0`, and `%rsp` points to `0xB0`.

![[routine switch 2.png]]

### Step 3: Saving `%rsp` to `current_routine->saved_stack_pointer`
Inside `routine_switch.S`, the callee-saved registers are pushed (`%r12`, `%r13`, `%r14`, `%r15`, `%rbx`, `%rbp`), and the assembly executes:
```assembly
mov current_routine(%rip), %rsi # Load current_routine pointer into scratch register %rsi
mov %rsp, (%rsi)                # Save updated stack pointer into Routine 1's struct (offset 0)
```
Now `Routine 1`'s context is completely frozen in its heap control block.

![[routine_switch 3.png]]

### Step 4: Pivoting to `next` and Loading its Saved `%rsp`
The assembly pivots `%rsp` to `Routine 2`'s saved stack pointer (`0xC0`), then updates `current_routine = next`:
```assembly
mov (%rdi), %rsp                # Load Routine 2's saved stack pointer (0xC0) into %rsp
mov %rdi, current_routine(%rip) # Update current_routine global pointer to Routine 2
```
The CPU's stack pointer `%rsp` has now transitioned entirely to `Routine 2`'s private stack (`0xC0`).

![[routine switch 4.png]]

### Step 5: The `ret` Instruction Resumes `Routine 2`
After popping `Routine 2`'s callee-saved registers in reverse LIFO order (`%rbp`, `%rbx`, `%r15`, `%r14`, `%r13`, `%r12`) to restore its frame pointer (`%rbp`) and preserved variables (`%rbx`), the assembly executes `ret`:
```assembly
ret
```
The `ret` instruction pops the 8-byte return address off `Routine 2`'s stack into `%rip`. `%rsp` increments past the return address, and the CPU resumes executing instructions inside `Routine 2` exactly where it previously called `routine_switch`!

![[routine switch 5.png]]

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Interleaving and Yield Traces|Interleaving and Yield Traces]] — Output permutations and lazy vs eager spawn
- [[Concurrency, Parallelism, and Rust/Coroutines/Fibonacci Generator Trace|Fibonacci Generator Trace]] — Infinite producer-consumer stream
