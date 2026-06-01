# CSE451: EFLAGS Status Flags

**Status flags** in [[EFLAGS]] reflect the result of recent arithmetic and logic operations.

- **Carry Flag (CF, bit 0)** — set if an arithmetic operation produced a carry or borrow
- **Zero Flag (ZF, bit 6)** — set if the result was zero
- **Sign Flag (SF, bit 7)** — set if the result was negative (most significant bit = 1)
- **Overflow Flag (OF, bit 11)** — set if a signed overflow occurred
- **Parity Flag (PF, bit 2)** — set if the result has an even number of set bits

## Related
- [[Control Flags]] — the other half of EFLAGS
- [[EFLAGS]] — the parent register
