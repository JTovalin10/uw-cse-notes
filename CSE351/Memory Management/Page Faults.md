# Page Faults

A **page fault** occurs when a requested page is not in physical memory (valid bit = 0). This means the page has been evicted or never loaded

## What happens then
- when the page is evicted, the OS set the PTE as invalid and noted the disk location of the page in a data strucrture
- when a process tries to access the page, the invalid PTE will cause an exception (page fault) to be thrown
	- can a single instrution have multiple faults
- the OS will run the page fauklt hanlder in response
	- hanlder uses the like a page data structure to lcoat ethe page on disk
	- handler reads page into a physkical frame, update tPTE to point to it and to be vald
	- OS restarts the failting process
	- and more

**Related:** [[Page Tables]], [[CSE351/Memory Management/Virtual Memory]], [[CSE351/System Programming/Exceptions]]

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
