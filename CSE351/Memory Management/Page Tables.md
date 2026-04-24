# CSE351: Page Tables

**Page tables** are lookup tables that perform address translation from virtual to physical addresses.

---

## Page Table Entry (PTE)

Similar to cache lines, PTEs contain:
- **Data:** Physical Page Number (PPN)
- **Management bits:** Control access and state

---

## Organization

- **Index:** Virtual Page Number (VPN)
- **Requirement:** One entry for every possible VPN
- **Size:** $2^{n-p}$ entries for $n$-bit virtual addresses with $P$-byte pages

---

## PTE Fields

| Field | Purpose |
|:---|:---|
| Valid bit | Is the page currently in physical memory? |
| Dirty bit | Has the page been modified since being loaded? |
| Access rights | Read / Write / Execute permissions |
| PPN | Physical page number |

---

## Address Translation Process

1. **Extract VPN** from the virtual address
2. **Index the page table** using the VPN
3. **Check the valid bit** in the PTE
4. **Extract PPN** if valid (else → [[CSE351/Memory Management/Page Faults|page fault]])
5. **Combine PPN + offset** → physical address

---

## Page Table Size Example

**32-bit machine with 2 MiB pages:**
- Virtual address space: $2^{32}$ bytes
- Page size: $2^{21}$ bytes
- Virtual pages: $2^{32-21} = 2^{11} = 2{,}048$ entries

---

## Memory Protection

Each process has its own page table, enabling:
- **Protection:** No shared PPNs between processes (unless intentional)
- **Sharing:** Multiple VPNs can map to the same PPN (e.g., shared libraries)

### Access Rights Bits

| Bit | Permission |
|:---|:---|
| R | Read |
| W | Write |
| X | Execute |

### Example by Section

| Section | R | W | X | Rationale |
|:---|:---|:---|:---|:---|
| Code | 1 | 0 | 1 | Execute but not modify |
| Data | 1 | 1 | 0 | Read/write, no execute |
| Literals | 1 | 0 | 0 | Read-only constants |
| Stack | 1 | 1 | 0 | Local variables |

---

## Related
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]]
- [[CSE351/Memory Management/Paging|Paging]]
- [[CSE351/Memory Management/Page Faults|Page Faults]]
- [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|TLB]]
- [[CSE351/Security/Buffer Overflow|Buffer Overflow]]
- [[CSE451/Memory Management/Address Translation/Page Table|Page Table (CSE451)]]
- [[CSE451/Memory Management/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy (CSE451)]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout (CSE484)]]
