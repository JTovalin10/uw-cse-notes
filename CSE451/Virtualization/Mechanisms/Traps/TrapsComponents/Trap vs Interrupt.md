# CSE451: Trap vs Interrupt

| | Trap | Interrupt |
|---|---|---|
| **Cause** | Software (program instruction) | External device / hardware |
| **Timing** | Synchronous — happens at a specific line of code | Asynchronous — can happen at any time |
| **Example** | System call, divide by zero | Keyboard press, disk I/O completion, timer |

## Related
- [[CSE451/Virtualization/Mechanisms/Traps/Traps|Traps]] — the full trap concept
- [[CSE451/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]] — the full interrupt concept
- [[Interrupt Types Summary]] — a broader summary including exceptions
