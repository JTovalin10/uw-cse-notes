# Paging

A **page** is a fixed-width unit of data transfer between memory levels.

**Related:** [[CSE351/Memory Management/Virtual Memory]], [[Page Tables]], [[TLB]]

---

## Page Parameters

| Parameter | Definition |
|-----------|------------|
| Page Size | P = 2^p bytes |
| Page Offset | p bits to reference bytes within page |

---

## Page Number Types

### Virtual Page Number (VPN)
- Identifies pages in virtual address space
- Range: 0 to (N/P - 1)

### Physical Page Number (PPN)
- Identifies pages in physical address space
- Range: 0 to (M/P - 1)

---

## Address Structure

```
Virtual Address:  [VPN (n-p bits)][Page Offset (p bits)]
Physical Address: [PPN (m-p bits)][Page Offset (p bits)]
```

---

## Example Calculation

**System:**
- Physical memory: 4 KiB (2^12 bytes) → 12-bit physical addresses
- Virtual addresses: 14 bits → 16 KiB virtual space
- Page size: 1 KiB (2^10 bytes) → 10-bit page offset

**Results:**
- Physical pages: 4 KiB / 1 KiB = 4 (PPNs 0-3)
- Virtual pages: 16 KiB / 1 KiB = 16 (VPNs 0-15)
- PPN width: 12 - 10 = 2 bits
- VPN width: 14 - 10 = 4 bits

---

## Address Examples

**Address 0x123 (291 decimal):**
- Binary: `0b 00|01 0010 0011`
- Page offset: 291 % 1024 = 291
- PPN: 291 / 1024 = 0

**Address 0x1234 (4660 decimal):**
- Binary: `0b 01 00|10 0011 0100`
- Page offset: 4660 % 1024 = 564
- VPN: 4660 / 1024 = 4

**Related:** [[Page Tables]], [[CSE351/Memory Management/Virtual Memory]]
