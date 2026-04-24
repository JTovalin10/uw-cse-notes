# CSE351: Translation Lookaside Buffer (TLB)

The **TLB** is a small, fast hardware cache inside the MMU that caches page table entries to speed up address translation.

---

## Purpose

Each memory access normally requires two memory operations: one to look up the PTE, and one to fetch the actual data. The TLB eliminates the PTE lookup on hits, reducing most accesses to a single memory operation.

---

## TLB Structure

- **Cached data:** Page table entries (PPN + management bits)
- **Index:** TLB Index (TLBI) extracted from the VPN
- **Tag:** TLB Tag (TLBT) for hit detection
- **Organization:** Set-associative cache (typically fully associative due to small size)

---

## VPN Field Breakdown

```
VPN: [ TLBT (TLB Tag) ][ TLBI (TLB Index) ]
```

---

## TLB Entry Components

| Component | Description |
|:---|:---|
| Valid bit | Is this TLB entry valid? |
| TLB Tag (TLBT) | Tag for hit detection |
| PTE Data | Management bits + PPN |

---

## TLB Operation

### TLB Hit
- VPN found in TLB
- PPN retrieved directly without accessing the page table
- **Fastest translation path**

### TLB Miss
- VPN not in TLB
- Fetch PTE from page table in memory
- Load the new PTE into the TLB
- Subsequent access to the same page will be a TLB hit

---

## TLB Size Calculation Example

**System:**
- 12-bit virtual addresses, 8-bit physical addresses
- 16-byte pages ($p = 4$)
- 5 management bits per PTE
- 4-way set associative, 16 entries total

**Calculations:**
- VPN width: 12 − 4 = 8 bits
- PPN width: 8 − 4 = 4 bits
- TLB sets: 16 / 4 = 4
- TLBI width: $\log_2(4) = 2$ bits
- TLBT width: 8 − 2 = 6 bits
- TLB entry size: 1 (valid) + 6 (tag) + 5 (mgmt) + 4 (PPN) = **16 bits**

---

## Complete Translation Flow

### Stage 1: Virtual to Physical
1. Check TLB with VPN
   - **Hit:** Get PPN directly
   - **Miss:** Access page table
     - **Page hit:** Load PTE into TLB, proceed
     - **Page fault:** OS loads page from disk, updates page table and TLB

### Stage 2: Cache Access
2. Check the data cache with the physical address
   - **Hit:** Return data
   - **Miss:** Fetch from main memory

---

## Performance Paths

| Path | TLB | Page Table | Cache | Memory Accesses |
|:---|:---|:---|:---|:---|
| Best case | Hit | — | Hit | 1 |
| TLB miss | Miss | Hit | Hit | 2 |
| Cache miss | Hit | — | Miss | 2 |
| Both miss | Miss | Hit | Miss | 3 |
| Page fault | Miss | Fault | — | Many |

---

## Related
- [[CSE351/Memory Management/Page Tables|Page Tables]]
- [[CSE351/Memory Management/Page Faults|Page Faults]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]]
- [[CSE351/Cache/Cache Associativity|Cache Associativity]]
- [[CSE451/Memory Management/Address Translation/Translation Lookaside Buffer (TLB)|TLB (CSE451)]]
- [[CSE451/Memory Management/Address Translation/TLB/Translation Lookaside Buffer (TLB) How It Works|How the TLB Works (CSE451)]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout (CSE484)]]
