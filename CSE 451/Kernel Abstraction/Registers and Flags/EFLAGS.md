# What is it
EFLAGS stands for **Extended FLAGS register**. it contains **status flags** and **control flags** about the cpu current state

# Common Status Flags
- Carry Flag (CF) (bit 0)
	- set if arithmetic operation carried/borrowed
- Zero Flag (ZF) (bit 6)
	- set if the result was zero
- Sign Flag (SF, bit 7)
	- Set if result was negative (MSB = 1)
- Overflow Flag (OF, bit 11)
	- set if signed overflow occurred
- Parity Flag (PF, bit 2)
	- set if result has even number of bits

# Control Flags
- Interrupt Flag (IF, bit 9)
	- if set, interrupts are enabled
- Direction Flag (DF, bit 10)
	- controls string oepration direction
- Trap Flag (TF, bit 8)
	- Single-step mode for debugging