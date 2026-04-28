# Page Table Translation Steps (Multi-level)
When a process tries to access a variable, the CPU must translate the Virtual Address (VA) to a Physical Address (PA). In a standard x86 32-bit system with 4KB pages:

1. **Split the VA**:
	- The 32-bit address is split into three parts: **PDI** (10 bits), **PTI** (10 bits), and **Offset** (12 bits).
2. **Page Directory Lookup**:
	- The CPU uses the **PDI** as an index into the **Page Directory** (whose base address is stored in the **CR3** register).
3. **Get Page Table Address**:
	- The entry in the Page Directory (PDE) provides the physical address of the **Page Table**.
4. **Page Table Lookup**:
	- The CPU uses the **PTI** as an index into that Page Table.
5. **Get Frame Number**:
	- The entry in the Page Table (PTE) provides the **Physical Frame Number (PFN)**.
6. **Final PA Calculation**:
	- The CPU concatenates the **PFN** with the original **Offset** from the VA to form the final Physical Address.
