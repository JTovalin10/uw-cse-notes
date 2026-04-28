# Parts of Virtual Address (32-bit 10-10-12)

In a multi-level page table system (e.g., x86 32-bit), the virtual address is split into:

1. **PDI (Page Directory Index)**: Bits 31-22 (10 bits).
	- Used to index into the Page Directory.
2. **PTI (Page Table Index)**: Bits 21-12 (10 bits).
	- Used to index into the Page Table.
3. **Offset**: Bits 11-0 (12 bits).
	- The exact location within the 4KB physical frame.

## The Math
- **Why 10 bits?**: 
	- Page size = 4KB ($2^{12}$ bytes).
	- PTE size = 4 bytes.
	- Entries per page = $4KB / 4B = 1024$ entries ($2^{10}$).
	- Therefore, 10 bits are required to index every entry in a single page-sized table.
- **Why 12 bits offset?**:
	- $2^{12} = 4096$, which matches the 4KB page size.

## Bitwise Calculation (Pseudo-code)
```c
pdi = (va >> 22) & 0x3FF;
pti = (va >> 12) & 0x3FF;
offset = va & 0xFFF;
```
