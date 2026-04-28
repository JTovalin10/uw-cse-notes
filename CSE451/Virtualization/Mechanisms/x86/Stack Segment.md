# CSE451: Stack Segment

The **Stack Segment (SS)** register tells the CPU which segment the stack is in — for example, whether it is in the code, data, or stack segment.

Note: modern x86-64 segments are mostly ignored but kept for backwards compatibility.

## Related
- [[ESP]] — the stack pointer register that tracks the current top of the stack
- [[Kernel Stack]] — the per-process kernel-mode stack
- [[CSE351/System Programming/Exceptions]] — how the stack is used during exception handling