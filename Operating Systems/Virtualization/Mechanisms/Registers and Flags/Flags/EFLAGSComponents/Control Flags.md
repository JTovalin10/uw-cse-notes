# CSE451: EFLAGS Control Flags

**Control flags** in [[EFLAGS]] govern CPU behavior during execution.

- **Interrupt Flag (IF, bit 9)** — if set, maskable hardware interrupts are enabled; see [[IF]]
- **Direction Flag (DF, bit 10)** — controls the direction of string operations (increment vs. decrement)
- **Trap Flag (TF, bit 8)** — enables single-step mode for debugging (one instruction at a time)

## Related
- [[Status Flags]] — the other half of EFLAGS
- [[EFLAGS]] — the parent register
- [[IF]] — detailed note on the Interrupt Flag
