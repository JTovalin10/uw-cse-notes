# CSE451: Interrupt Flag (IF)

The **Interrupt Flag (IF)** is a single bit in the x86 processor's [[EFLAGS]] register that controls whether the CPU responds to maskable hardware interrupts.

## States
- **IF = 1**: Interrupts enabled — CPU will respond to interrupt requests from devices
- **IF = 0**: Interrupts disabled — CPU ignores maskable interrupt requests

## How to Modify
- [[STI]]: sets IF to 1 (enables interrupts)
- [[CLI]]: sets IF to 0 (disables interrupts)
- Only executable in kernel mode (Ring 0)

## Related
- [[EFLAGS]] — the register that contains the IF bit
- [[CLI]] / [[STI]] — x86 instructions to modify IF
- [[Interrupt Masking]] — OS-level use of IF for synchronization
