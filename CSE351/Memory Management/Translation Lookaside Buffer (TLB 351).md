# Translation Lookaside Buffer (TLB)

The **TLB** is a small hardware cache in the MMU that caches page table entries to speed up address translation.

**Related:** [[Page Tables]], [[CSE351/Memory Management/Virtual Memory]], [[Page Faults]]

---

## Purpose

Reduces memory accesses during translation by caching PTEs.

---

## TLB Structure

- **Cached data:** Page table entries (PPN + management bits)
- **Index:** TLB Index (TLBI) extracted from VPN
- **Tag:** TLB Tag (TLBT) for comparison
- **Organization:** Set associative cache

---

## VPN Field Breakdown

```
VPN: [TLBT (TLB Tag)][TLBI (TLB Index)]
```

---

## TLB Entry Components

| Component | Description |
|-----------|-------------|
| Valid Bit | Is TLB entry valid? |
| TLB Tag | Tag for hit detection |
| PTE Data | Management bits + PPN |

---

## TLB Operation

### TLB Hit
- VPN found in TLB
- Direct translation without page table access
- **Fastest path**

### TLB Miss
- VPN not in TLB
- Fetch PTE from page table
- Load new PTE into TLB
- Subsequent access will be TLB hit

---

## TLB Size Calculation Example

**System:**
- 12-bit virtual addresses
- 8-bit physical addresses
- 16-byte pages (p = 4)
- 5 management bits per PTE
- 4-way set associative, 16 entries

**Calculations:**
- VPN width: 12 - 4 = 8 bits
- PPN width: 8 - 4 = 4 bits
- TLB sets: 16/4 = 4
- TLBI width: log2(4) = 2 bits
- TLBT width: 8 - 2 = 6 bits

**TLB entry size:** 1 (valid) + 6 (tag) + 5 (mgmt) + 4 (PPN) = **16 bits**

---

## Complete Translation Flow

### Stage 1: Virtual to Physical
1. Check TLB with VPN
   - **Hit:** Get PPN directly
   - **Miss:** Access page table
     - **Page hit:** Load PTE into TLB
     - **Page fault:** OS loads page, updates table and TLB

### Stage 2: Cache Access
2. Check cache with physical address
   - **Hit:** Return data
   - **Miss:** Fetch from memory

---

## Performance Paths

| Path | TLB | Page Table | Cache | Accesses |
|------|-----|------------|-------|----------|
| Best | Hit | - | Hit | 1 |
| TLB Miss | Miss | Hit | Hit | 2 |
| Cache Miss | Hit | - | Miss | 2 |
| Both Miss | Miss | Hit | Miss | 3 |
| Page Fault | Miss | Fault | - | Many |

**Related:** [[Page Tables]], [[CSE484/Memory Exploits/Memory Layout]]
