# CSE451: Interrupt Types Summary

There are three broad categories of events that cause a transfer of control from a running program into the kernel, distinguished by their source and timing:

| Type | Source | Synchronous? | Example |
|------|--------|--------------|---------|
| Hardware ([[Interrupts]]) | External device | No — can occur at any point during execution | Keyboard, disk completion, timer |
| Software ([[Traps|Trap]]) | Program instruction | Yes — happens at a specific line of code | System call |
| [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]] | CPU error | Yes — happens at the exact instruction that caused the error | Divide by zero, page fault |

**Hardware interrupts** are asynchronous because an external device can signal completion at any arbitrary point in a program's execution, independent of what instruction is currently running. **Software traps and exceptions** are both synchronous because they are tied to the execution of a specific instruction — either a program deliberately invoking a trap instruction (system call), or the CPU detecting an illegal operation at a specific instruction (exception).

## Related
- [[Interrupts|Interrupts]] — the hardware category
- [[Traps|Traps]] — the software category
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception]] — the CPU-error category
- [[Trap vs Interrupt]] — a focused comparison table between traps and interrupts
- [[Source of Interrupts]] — the specific origins of each interrupt type

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Hardware Interrupt | Hardware interrupt / IRQ |
| Software Interrupt (Trap) | Software interrupt / trap |
