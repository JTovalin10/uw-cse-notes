# CSE351: Paging

A **page** is the fixed-size unit of data transfer between memory levels (RAM ↔ disk) in a virtual memory system. Using fixed-size pages simplifies the OS bookkeeping and eliminates external fragmentation at the physical level.

---

## Page Parameters

| Parameter | Definition |
|:---|:---|
| Page size | $P = 2^p$ bytes |
| Page offset | $p$ bits — indexes a specific byte within a page |

---

## Page Number Types

### Virtual Page Number (VPN)

- Identifies a page in the **virtual** address space.
- Range: 0 to $(N/P - 1)$ where $N$ is the virtual address space size.

### Physical Page Number (PPN)

- Identifies a page frame in **physical** memory (RAM).
- Range: 0 to $(M/P - 1)$ where $M$ is the physical memory size.

---

## Address Structure

### Formal Definition

A virtual address is split into two fields:

```
Virtual Address:  [ VPN (n-p bits) ][ Page Offset (p bits) ]
Physical Address: [ PPN (m-p bits) ][ Page Offset (p bits) ]
```

### Simplified Explanation

The page offset is the same in both the virtual and physical address — it selects the byte within the page, and the page doesn't move internally. Only the page number changes: the VPN is translated to a PPN via the [[Page Tables|page table]].

---

## Example Calculation

**System:**
- Physical memory: 4 KiB ($2^{12}$ bytes) → 12-bit physical addresses, $m = 12$
- Virtual addresses: 14 bits → 16 KiB virtual space, $n = 14$
- Page size: 1 KiB ($2^{10}$ bytes) → $p = 10$-bit page offset

**Results:**
- Physical pages: $4 \text{ KiB} / 1 \text{ KiB} = 4$ (PPNs 0–3), PPN width = $12 - 10 = 2$ bits
- Virtual pages: $16 \text{ KiB} / 1 \text{ KiB} = 16$ (VPNs 0–15), VPN width = $14 - 10 = 4$ bits

---

## Address Examples

**Address `0x123` (291 decimal):**
- Binary: `0b 00|01 0010 0011`
- Page offset: $291 \bmod 1024 = 291$
- VPN (top 4 bits): $291 / 1024 = 0$

**Address `0x1234` (4660 decimal):**
- Binary: `0b 01 00|10 0011 0100`
- Page offset: $4660 \bmod 1024 = 564$
- VPN (top 4 bits): $4660 / 1024 = 4$

---

```mermaid
flowchart LR
    VA["Virtual Address: [VPN | Page Offset]"] --> PT["Page Table lookup using VPN"]
    PT --> PA["Physical Address: [PPN | Page Offset]"]
    PA --> MEM["RAM: byte at offset within physical page"]
```

---

## Related

- [[Hardware & Software Interface/Memory Management/Virtual Memory|Virtual Memory]]
- [[Page Tables|Page Tables]]
- [[Translation Lookaside Buffer (TLB 351)|TLB]]
- [[Page Faults|Page Faults]]
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging (CSE451)]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|:---|:---|
| Page | Page; memory page; virtual page |
| Physical page / page frame | Page frame; physical frame; memory frame |
| Virtual Page Number (VPN) | VPN; page number |
| Physical Page Number (PPN) | PPN; frame number; physical frame number (PFN) |
| Page offset | Byte offset within page; intra-page offset |
| $P = 2^p$ | Page size (typically 4 KiB = $2^{12}$ on x86-64) |
