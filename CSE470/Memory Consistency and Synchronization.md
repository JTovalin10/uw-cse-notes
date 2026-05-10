# Course: Memory Consistency and Synchronization

Memory Consistency defines the rules for how memory operations from different processors appear to each other. It is the "contract" for multi-core programming.

## Consistency vs. Coherence
- **Coherence**: Defines the behavior of a **single memory location**. All processors must see the same sequence of values for address $X$. (Implementation: MSI/MESI protocols).
- **Consistency**: Defines the ordering of **all memory locations**. Does a write to $A$ become visible before a write to $B$?

## Consistency Models

### Sequential Consistency (SC)
The most intuitive model.
- **Definition**: The result of any execution is the same as if the operations of all processors were executed in some sequential order, and the operations of each individual processor appear in this sequence in the order specified by its program.
- **Practicality**: Very difficult to implement efficiently. Most modern hardware (x86, ARM) violates SC to allow performance optimizations like write buffers and OoO execution.

### Total Store Order (TSO) - x86
- Allows **Write -> Read** reordering (loads can bypass older stores).
- Stores stay in order.

### Weak Ordering (WO) / Release Consistency (RC) - ARM/Power
- No guarantees on ordering unless explicit **Memory Fences (Barriers)** are used.
- **Acquire**: A load that ensures all subsequent memory operations stay after it.
- **Release**: A store that ensures all previous memory operations stay before it.

## Synchronization Primitives
Atomic operations are required to build locks and coordination structures.

### Atomic Instructions
- **Test-and-Set**: Atomically sets a memory location to 1 and returns the old value.
- **Exchange (Swap)**: Atomically swaps a register with a memory location.
- **Load-Link / Store-Conditional (LL/SC)**: A pair of instructions. `LL` reads a value and monitors the address. `SC` only succeeds if the address hasn't been written to since the `LL`.

### Lock Scaling
1. **Spin Lock**: Simple but causes high interconnect traffic.
2. **Test-and-Test-and-Set**: Reduces traffic by checking the lock in the cache before attempting an atomic operation.
3. **Exponential Backoff**: Increases wait time between retries to reduce contention.
4. **Queue Locks**: Each processor waits on a unique local variable, eliminating the "thundering herd" problem when a lock is released.

## Related
- [[CSE452/Consistency/Sequential Consistency|CSE452: Sequential Consistency]]
- [[CSE470/Memory Hierarchy and Coherence|Memory Hierarchy and Coherence]]
