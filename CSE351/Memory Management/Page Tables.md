# Page Tables

**Page tables** are lookup tables that perform address translation from virtual to physical addresses.

**Related:** [[CSE351/Memory Management/Virtual Memory]], [[CSE351/Memory Management/Paging]], [[TLB]], [[Page Faults]]

---

## Page Table Entry (PTE)

Similar to cache lines, PTEs contain:
- **Data:** Physical Page Number (PPN)
- **Management bits:** Control access and state

---

## Organization

- **Index:** Virtual Page Number (VPN)
- **Requirement:** One entry for every possible VPN
- **Size:** 2^(n-p) entries for n-bit virtual addresses, P-byte pages

---

## PTE Fields

| Field | Purpose |
|-------|---------|
| Valid Bit | Is page in physical memory? |
| Dirty Bit | Has page been modified? |
| Access Rights | Read/Write/Execute permissions |
| PPN | Physical page number |

---

## Address Translation Process

1. **Extract VPN** from virtual address
2. **Index page table** using VPN
3. **Check valid bit** in PTE
4. **Extract PPN** if valid
5. **Combine PPN + offset** → physical address

---

## Page Table Size Example

**32-bit machine with 2 MiB pages:**
- Virtual address space: 2^32 bytes
- Page size: 2^21 bytes
- Virtual pages: 2^(32-21) = 2^11 = 2,048 entries

---

## Memory Protection

Each process has own page table, enabling:
- **Protection:** No shared PPNs between processes
- **Sharing:** Multiple VPNs can map to same PPN when desired

### Access Rights Bits

| Bit | Permission |
|-----|------------|
| R | Read |
| W | Write |
| X | Execute |

### Example by Section

| Section | R | W | X | Rationale |
|---------|---|---|---|-----------|
| Code | 1 | 0 | 1 | Execute, no modify |
| Data | 1 | 1 | 0 | Read/write, no execute |
| Literals | 1 | 0 | 0 | Read-only constants |
| Stack | 1 | 1 | 0 | Local variables |

**Related:** [[Buffer Overflow]], [[CSE484/Memory Exploits/Memory Layout]]
