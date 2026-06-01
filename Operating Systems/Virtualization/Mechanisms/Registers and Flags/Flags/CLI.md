# CSE451: CLI (Clear Interrupt Flag)

**CLI** stands for **Clear Interrupt Flag**.

- Disables maskable hardware interrupts
- Sets the [[IF]] bit to 0 in [[EFLAGS]]
- Interrupts will not be processed until re-enabled with [[STI]]
- Non-maskable interrupts (NMI) still work even with CLI active

## Related
- [[STI]] — the complementary instruction that sets the interrupt flag
- [[IF]] — the flag bit that CLI clears
- [[EFLAGS]] — the register containing the interrupt flag
- [[Interrupt Masking]] — OS use of CLI/STI for critical sections
