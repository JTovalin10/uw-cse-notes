# CSE351: Page Faults

A **page fault** occurs when a requested virtual page is not in physical memory (valid bit = 0). When a page is evicted from RAM, the OS marks its PTE as invalid and records the disk location where the page was stored. On the next access, the invalid PTE causes a page fault exception, and the OS handler brings the page back from disk.

Note: a single instruction can trigger multiple page faults — for example, if both the instruction fetch and the data access reference pages that are not in memory.

---

## Page Fault Handling Steps

1. CPU sends virtual address to MMU
2. MMU looks up the PTE using the VPN
3. Valid bit = 0 → **page fault exception**
4. OS handler:
   - Identifies a victim page in physical memory to evict
   - Writes victim to disk if dirty
   - Reads the requested page from disk into the freed physical frame
   - Updates the PTE (new PPN, valid = 1)
5. OS restarts the faulting instruction
6. On retry, the access is a guaranteed page hit

---

## Page Hit vs. Page Fault

### Page Hit

```
CPU → MMU → Memory (PTE lookup) → MMU → Memory (data) → CPU
```
Memory accesses: **2** (PTE + data)

### Page Fault

```
CPU → MMU → Memory (PTE) → MMU → OS Handler → Disk I/O → Memory update → restart
```
Memory accesses by MMU: **3** (initial PTE + 2 for the subsequent hit after restart)

Plus a massive disk I/O penalty.

---

## Why Page Faults Are Expensive

| Level | Access Time |
|:---|:---|
| Register | ~1 cycle |
| Memory (RAM) | ~100 cycles |
| Disk | ~10,000,000 cycles |

This 100,000× cost is why the [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|TLB]] minimizes page table accesses and why write-back policy limits disk writes.

---

## Address Translation Components

| Component | Purpose |
|:---|:---|
| CPU | Issues virtual addresses |
| MMU | Performs address translation |
| PTBR | Points to the current process's page table |

---

## Related
- [[CSE351/Memory Management/Page Tables|Page Tables]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]]
- [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|TLB]]
- [[CSE351/System Programming/Exceptions|Exceptions]]
- [[CSE351/System Programming/Context Switching|Context Switching]]
- [[CSE451/Virtual Memory/Page Fault|Page Fault (CSE451)]]
- [[CSE451/Virtual Memory/How does the OS handle page faults|How the OS Handles Page Faults (CSE451)]]
- [[CSE451/Virtual Memory/Page Replacement/Page replacement|Page Replacement (CSE451)]]
