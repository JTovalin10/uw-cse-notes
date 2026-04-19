# CSE451: General Protection Fault (GPF)

A **General Protection Fault (GPF)** is a CPU exception that occurs when code violates processor protection rules.

## Common Causes
- **Privilege violation**: Ring 3 code tries to execute a Ring 0 instruction — see [[Privilege Level]]
- **Segment violation**: access outside segment limits
- **Null pointer dereference**: accessing address 0 (or very low memory)
- **Invalid memory access**: writing to read-only memory, executing non-executable pages

## Related
- [[Exception]] — the general category of hardware-triggered control transfers
- [[Privilege Level]] — the Ring 0/3 privilege system enforced by the GPF
- [[Dual-Mode Restrictions]] — what restricted operations trigger a GPF
- [[Source of Interrupts]] — GPF listed as an exception source
