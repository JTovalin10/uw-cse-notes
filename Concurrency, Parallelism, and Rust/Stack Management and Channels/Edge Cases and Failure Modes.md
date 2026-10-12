# Stack Management and Channels: Edge Cases and Failure Modes

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

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Guard Page** | Redzone Page / Stack Guard Page (`PROT_NONE`) |

## Related

- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Channel Formal Specification|Channel Formal Specification]] — Formal definition and intuition
