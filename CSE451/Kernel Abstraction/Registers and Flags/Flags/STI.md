# CSE451: STI (Set Interrupt Flag)

**STI** stands for **Set Interrupt Flag**.

- Enables maskable hardware interrupts
- Sets the [[IF]] bit to 1 in [[EFLAGS]]
- The processor can now respond to interrupt requests from devices

## Related
- [[CLI]] — the complementary instruction that clears the interrupt flag
- [[IF]] — the flag bit that STI sets
- [[EFLAGS]] — the register containing the interrupt flag
- [[Interrupt Masking]] — OS use of STI/CLI for critical sections
