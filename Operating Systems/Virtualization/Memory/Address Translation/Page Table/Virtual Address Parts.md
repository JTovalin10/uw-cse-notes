# CSE451: Parts of a Virtual Address (32-bit 10-10-12)

## Overview
In a multi-level page table system, such as the standard x86 32-bit scheme used in **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]**, the virtual address is not a single opaque number — it is split into three fields, each used for a different purpose during translation:

1. **PDI (Page Directory Index)**: bits 31-22 (10 bits). Used to index into the Page Directory.
2. **PTI (Page Table Index)**: bits 21-12 (10 bits). Used to index into the Page Table.
3. **Offset**: bits 11-0 (12 bits). The exact location within the 4KB physical frame.

## The Math Behind the Bit Widths
These widths are not arbitrary; they fall directly out of the page size and the size of a page table entry:
- **Why 10 bits for PDI and PTI?**
	- Page size = 4KB ($2^{12}$ bytes).
	- PTE size = 4 bytes.
	- Entries per page = $4KB / 4B = 1024$ entries ($2^{10}$).
	- Since each Page Table (and each Page Directory) is itself stored in a single 4KB page, and each entry within it is 4 bytes, exactly 1024 entries fit in one page. Therefore, 10 bits are required to index every entry in a single page-sized table.
- **Why 12 bits for the offset?**
	- $2^{12} = 4096$, which matches the 4KB page size exactly, so 12 bits are needed and sufficient to address every individual byte within a single frame.

This is also why the three fields sum to exactly 32 bits ($10 + 10 + 12 = 32$): the design is self-consistent, since the same 4KB page size that determines the offset width also determines how many entries fit in an index-sized page, which in turn determines the PDI/PTI widths.

## Bitwise Calculation (Pseudo-code)
```c
pdi = (va >> 22) & 0x3FF;
pti = (va >> 12) & 0x3FF;
offset = va & 0xFFF;
```
Each field is extracted by shifting the virtual address right past the lower bits that don't belong to it, then masking off any higher bits that don't belong to it either — `0x3FF` is a 10-bit mask ($1023$) and `0xFFF` is a 12-bit mask ($4095$).

## Formal Definition
Given a 32-bit virtual address $VA$, the three fields are extracted as:

$$
\begin{aligned}
\text{PDI} &= \left\lfloor \frac{VA}{2^{22}} \right\rfloor \bmod 2^{10} \\
\text{PTI} &= \left\lfloor \frac{VA}{2^{12}} \right\rfloor \bmod 2^{10} \\
\text{Offset} &= VA \bmod 2^{12}
\end{aligned}
$$

such that $VA = (\text{PDI} \times 2^{22}) + (\text{PTI} \times 2^{12}) + \text{Offset}$.

## Simplified Explanation
A 32-bit address is really just three numbers glued together: which chapter of the page directory to open (PDI), which entry within that chapter's page table to read (PTI), and which byte within the resulting 4KB frame you actually want (offset). The bit widths work out to exactly 10-10-12 only because a 4KB page holding 4-byte entries happens to fit exactly 1024 of them — the same page size used for the offset also dictates how big each index needs to be.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| PDI (Page Directory Index) | First-level page table index |
| PTI (Page Table Index) | Second-level page table index |
| Offset | Page offset / byte offset |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Structure Diagram|Page Table Structure Diagram]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
