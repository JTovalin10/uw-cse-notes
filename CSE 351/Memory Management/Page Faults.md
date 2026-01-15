# Page Faults

A **page fault** occurs when a requested page is not in physical memory (valid bit = 0).

**Related:** [[Page Tables]], [[Virtual Memory]], [[Exceptions]]

---

## Page Fault Handling

### Steps

1. CPU sends virtual address to MMU
2. MMU looks up PTE using VPN
3. Valid bit = 0 → **page fault exception**
4. OS handler:
   - Identifies victim page in physical memory
   - Pages out victim (if dirty) to disk
   - Pages in requested page from disk
   - Updates PTE with new PPN and valid = 1
5. Returns control to restart instruction
6. Retry is guaranteed page hit

---

## Page Hit vs Page Fault

### Page Hit

```
CPU → MMU → Memory (PTE lookup) → MMU → Memory (data) → CPU
```
Memory accesses: **2** (PTE + data)

### Page Fault

```
CPU → MMU → Memory (PTE) → MMU → OS Handler → Disk I/O → Memory update → restart
```
Memory accesses by MMU: **3** (initial PTE + 2 for subsequent hit)

Plus massive disk I/O penalty!

---

## Why Page Faults Are Expensive

- Disk access: ~10,000,000 cycles
- Memory access: ~100 cycles
- Register access: ~1 cycle

This is why we use [[TLB]] to minimize page table accesses.

---

## Address Translation Components

| Component | Purpose |
|-----------|---------|
| CPU | Issues virtual addresses |
| MMU | Performs address translation |
| PTBR | Points to current process's page table |

**Related:** [[TLB]], [[Context Switching]]
