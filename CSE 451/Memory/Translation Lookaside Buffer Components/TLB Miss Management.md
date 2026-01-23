# Hardware vs. Software Management

Who handles the "TLB Miss" (the slow path)?

- **Hardware Managed (e.g., x86/Intel):** The CPU handles it automatically. It pauses the current instruction, walks the page table in RAM, updates the TLB, and resumes. The OS doesn't even know it happened.

- **Software Managed (e.g., MIPS/RISC-V):** The CPU raises a **Trap**. The OS pauses the process, runs a specific kernel code to look up the address, updates the TLB, and then restarts the instruction.
